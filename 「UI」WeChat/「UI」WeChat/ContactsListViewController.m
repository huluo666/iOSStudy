//
//  ContactsViewController.m
//  「UI」WeChat
//
//  Created by cuan on 14-2-1.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "ContactsListViewController.h"
#import "ContactsGroup.h"
#import "PersonInformations.h"
#import "ContactsDatas.h"
#import "ParticularViewController.h"
#import "DetailInformationViewController.h"

@interface ContactsListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic, readonly) NSMutableArray *contacts; // 网络端获取到的数据
@property (retain, nonatomic, readonly) NSMutableArray *contactGroups; // 网络端获取的数据，经过分组处理后的数据
- (NSArray *)group; // 对获取到的数据分组

@end

@implementation ContactsListViewController

- (void)dealloc
{
    [_contacts release];
    [_contactGroups release];
    [super dealloc];
}

- (id)init
{
    if (self = [super init])
    {
        _contactGroups = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initTableView];
    self.title = CONTACTS;
}

- (void)initTableView
{
    UITableView *contactsTableView = [[UITableView alloc] init];
    NSInteger deviceScreenHeight = self.view.frame.size.height;
    contactsTableView.bounds = CGRectMake(0, 0, 320, deviceScreenHeight - 35);
    contactsTableView.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame) + 35/2);

    // 关联数据源
    contactsTableView.dataSource = self;
    // 设置数据
    _contacts = [[ContactsDatas datas] retain];
    // 处理数据(分组)
    [self group];
    // 设置代理
    contactsTableView.delegate = self;
    [self.view addSubview:contactsTableView];
    [contactsTableView release];
}

#pragma mark - 对数据进行分组处理
- (NSArray *)group
{
    // 先设置显示名称
    for (int i = 0; i < _contacts.count; i++)
    {
        PersonInformations *pInfos = _contacts[i];
        if ([_contacts[i] remarkName] && [_contacts[i] remarkName].length > 0)
        {

            pInfos.displayName = [_contacts[i] remarkName];
        }
        else
        {
            pInfos.displayName = [_contacts[i] nickName];
        }
    }
    
    // 对所有数据按displayName排序
    [_contacts sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if ([obj1 isKindOfClass:[PersonInformations class]] &&
            [obj2 isKindOfClass:[PersonInformations class]])
        {
            return [[obj1 displayName] compare:[obj2 displayName]];
        }
        else
        {
            return NSOrderedSame;
        }
    }];

    // 特殊分组
    ContactsGroup *particularGroup = [ContactsGroup contactsGroupWithGroupName:PARTICULAR_GROUP_NAME];
    // 星标分组
    ContactsGroup *startGroup = [ContactsGroup contactsGroupWithGroupName:START_GROUP_NAME];
    // 其他分组
    ContactsGroup *othersGroup = [ContactsGroup contactsGroupWithGroupName:OTHERS_GROUP_NAME];
    for (PersonInformations *pinfo in _contacts)
    {
        int firstChar = [pinfo.displayName characterAtIndex:0];
        if ([[pinfo.displayName substringWithRange:NSMakeRange(0, 1)] isEqualToString:PARTICULAR_GROUP_NAME])
        {
            [particularGroup.infos addObject:pinfo];
        }
        else if (!((firstChar >= 'A' && firstChar <= 'Z') || (firstChar >= 'a' && firstChar <= 'z'))) // 非字母开头
        {
            [othersGroup.infos addObject:pinfo];
        }

        if (pinfo.isStart)
        {
            [startGroup.infos addObject:pinfo];
        }
    }
    
    // 添加特殊分组的数据
    [self.contactGroups addObject:particularGroup];

    // 添加星标分组数据
    [_contactGroups addObject:startGroup];
    
    // 普通分组
    for (int i = 'A'; i <= 'Z'; i++)
    {
        ContactsGroup *group = [ContactsGroup contactsGroupWithGroupName:[NSString stringWithFormat:@"%c", i]];
        for (PersonInformations *pinfo in _contacts)
        {
            if ([[pinfo.displayName substringWithRange:NSMakeRange(0, 1)]
                 isEqualToString:[NSString stringWithFormat:@"%c", i]] ||
                [[pinfo.displayName substringWithRange:NSMakeRange(0, 1)]
                 isEqualToString:[NSString stringWithFormat:@"%c", i + 32]]
                )
            {
                [group.infos addObject:pinfo];
            }
        }
        
        if (group.infos)
        {
            [self.contactGroups addObject:group];
        }
    }
    
    // 添加其他分组数据
    [_contactGroups addObject:othersGroup];

    return _contactGroups;
}

#pragma mark - 数据源方法<UITableViewDataSource>
// 一共多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _contactGroups.count;
}

// 第section组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_contactGroups[section] infos] count];
}

// 每一行的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:cellIdentifier] autorelease];
    }

    // 设置显示文本(姓名)
    NSString *text = [[_contactGroups[indexPath.section] infos][indexPath.row] displayName];
    
    if (![[text substringWithRange:NSMakeRange(0, 1)] isEqualToString:PARTICULAR_GROUP_NAME])
    {
        cell.textLabel.text = text;
    }
    else
    {
        cell.textLabel.text = [text substringWithRange:NSMakeRange(1, text.length -1 )];
    }

    // 设置显示头像(左侧)
    UIImage *avatar = [[_contactGroups[indexPath.section] infos][indexPath.row] avatar];
    if (avatar)
    {
        cell.imageView.image = avatar;
    }
    else
    {
        cell.imageView.image = [UIImage imageNamed:@"contacts_default_avatar"];
    }
    
    return cell;
}

// 分组title
// ⭐︎ 2字节
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([[_contactGroups[section] infos] count] > 0)
    {
        if ([[_contactGroups[section] groupName] isEqualToString:START_GROUP_NAME])
        {
            return @"星标朋友";
        }
        
        if ([[_contactGroups[section] groupName] isEqualToString:PARTICULAR_GROUP_NAME])
        {
            return nil;
        }
        
        return [_contactGroups[section] groupName];
    }
    else
    {
        return nil;
    }
}

#pragma mark 如何改变索引颜色？ 如何实现索引滑动时动画效果？如何实现索引最前面加一个星标索引？索引位置有偏差，造成困然，明明点击的A却跳转到B。。
// 索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *indexArray = nil;
    indexArray = [_contactGroups valueForKey:GROUP_NAME]; // KVC
    return indexArray;
}

#pragma mark 代理方法 <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonInformations *personInfos = [_contactGroups[indexPath.section] infos][indexPath.row];
    if (0 == indexPath.section) // 特殊分组
    {
        ParticularViewController *conatctsParticularVC = [[ParticularViewController alloc] init];
        conatctsParticularVC.personInformations = personInfos;
//        self.title = [[personInfos displayName] substringWithRange:NSMakeRange(1, [personInfos displayName].length - 1)];
        [self.navigationController pushViewController:conatctsParticularVC animated:YES];
        [conatctsParticularVC release];
    }
    else // 星标，普通，其他分组，展示内容形式一致
    {
        DetailInformationViewController *contactsOtherGroupsVC = [[DetailInformationViewController alloc] init];
        contactsOtherGroupsVC.personInformations = personInfos;
//        self.title = [personInfos displayName];
        [self.navigationController pushViewController:contactsOtherGroupsVC animated:YES];
        [contactsOtherGroupsVC release];
    }
}

@end
