//
//  ContactsDataSource.m
//  「UI」WeChat
//
//  Created by cuan on 14-2-3.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "ContactsDataSource.h"
#import "PersonInformationsDatas.h"
#import "PersonInformations.h"
#import "ContactsGroup.h"

@interface ContactsDataSource ()

@property (retain, nonatomic, readonly) NSMutableArray *contacts; // 网络端获取到的数据
@property (retain, nonatomic, readonly) NSMutableArray *contactGroups; // 网络端获取的数据，经过分组处理后的数据
- (NSArray *)group; // 对获取到的数据分组

@end

@implementation ContactsDataSource

- (id)init
{
    if (self = [super init])
    {
        // 初始化分组数据容器
        _contactGroups = [[NSMutableArray alloc] init];
        
        // 获取数据
        _contacts = [[PersonInformationsDatas datas] retain];
        [self group];
    }
    return self;
}

- (void)dealloc
{
    [_contacts release];
    [_contactGroups release];
    [super dealloc];
}

#pragma mark - 对数据进行分组处理
- (NSArray *)group
{
    // 对所有数据按name排序
    [_contacts sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if ([obj1 isKindOfClass:[PersonInformations class]] &&
            [obj2 isKindOfClass:[PersonInformations class]])
        {
            return [[obj1 name] compare:[obj2 name]];
        }
        else
        {
            return NSOrderedSame;
        }
    }];
    
    // 分组
    for (int i = 'A'; i <= 'Z'; i++)
    {
        ContactsGroup *group = [ContactsGroup contactsGroupWithGroupName:[NSString stringWithFormat:@"%c", i]];
        for (PersonInformations *pinfo in _contacts)
        {
            if ([[pinfo.name substringWithRange:NSMakeRange(0, 1)]
                 isEqualToString:[NSString stringWithFormat:@"%c", i]] ||
                [[pinfo.name substringWithRange:NSMakeRange(0, 1)]
                 isEqualToString:[NSString stringWithFormat:@"%c", i + 32]]
                )
            {
                [group.infos addObject:pinfo];
            }
        }

        if (group.infos)
        {
            [_contactGroups addObject:group];
        }
    }
    
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
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell.textLabel.text = [[_contactGroups[indexPath.section] infos][indexPath.row] name];
    
    return cell;
}

// 分组title
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([[_contactGroups[section] infos] count] > 0)
    {
        return [NSString stringWithFormat:@"%@", [_contactGroups[section] groupName]];
    }
    return nil;
}

#pragma mark 如何改变索引颜色？ 如何实现索引滑动时动画效果？如何实现索引最前面加一个星标索引？
// 索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *indexArray = nil;
    indexArray = [_contactGroups valueForKey:@"groupName"]; // KVC
    
    return indexArray;
}


@end
