//
//  OtherGroupsViewController.m
//  「UI」WeChat
//
//  Created by cuan on 14-2-4.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "DetailInformationViewController.h"
#import "PersonInformations.h"
#import "UIViewController+SettingDecoilClose.m"

@interface DetailInformationViewController () <UITableViewDataSource, UITableViewDelegate>

- (void)showDetails;
@property (retain, nonatomic) NSMutableArray *packedInfos;
@property (retain, nonatomic) NSMutableDictionary *cellsHeight;

@end

@implementation DetailInformationViewController

- (void)dealloc
{
    [_personInformations release];
    [_packedInfos release];
    [_cellsHeight release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _cellsHeight = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _packedInfos = [[self packPersonInformations] retain];
    [self customTitleViewWithText:DETAIL_INFOMATIONS];
    [self showDetails];
    [self loadRightBarButtonItem];
}

- (void)loadRightBarButtonItem
{
    UIBarButtonItem *itemMore = [[UIBarButtonItem alloc] init];
    itemMore.image = [UIImage imageNamed:@"taBbar_more_icon"];
    itemMore.tintColor = [UIColor whiteColor];
    itemMore.target = self;
    itemMore.action = @selector(rithtItemsPressed:);
    self.navigationItem.rightBarButtonItem = itemMore;
    [itemMore release];
}

- (void)rithtItemsPressed:(UIBarButtonItem *)sender
{
    /*
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, 320, 568);
    view.tag = DETAIL_INFOMATION_SETTING_TABLE_BG_VIEW_TAG;
    view.backgroundColor = [UIColor clearColor];
    [self.tabBarController.view addSubview:view];
    [view release];
    
    UITableView *settingTV = [[UITableView alloc] initWithFrame:CGRectMake(320 - 150, 20 + 44, 150, 308) style:UITableViewStylePlain];
    settingTV.tag = DETAIL_INFOMATION_SETTING_TABLE_VIEW_TAG;
    settingTV.backgroundColor = [UIColor colorWithRed:0.434 green:0.451 blue:0.471 alpha:1.000];
    [self.tabBarController.view addSubview:settingTV];
    [settingTV release];
#pragma mark 事件监听方法在WeChatTabBarController里面。因为设置的tag值一样，而且视图都是加载到WeChatTabBarController视图上的。self.tabBarController就是WeChatTabBarController
     */
    [self settingDecoilCloseWithFrame:CGRectMake(320 - 150, 20 + 44, 150, 308) color:[UIColor colorWithRed:0.434 green:0.451 blue:0.471 alpha:1.000] tableViewDataSource:nil tableViewDalegate:nil forViewController:self];
}

- (void)showDetails
{
    [self customRequiredInfosView];
    
    UIView *view = (UIView *)[self.view viewWithTag:REQUIRED_VIEW_TAG];
    UITableView *tableView = [[UITableView alloc] init];
    // 计算tableView的高度
    double height = 0;
    for (int i = 0; i < _packedInfos.count; i++)
    {
        if ([_packedInfos[i] objectForKey:PHOTOS])
        {
            height += PHOTOS_CELL_HEIGHT;
        }
        else
        {
            height += [[_packedInfos[i] objectForKey:TEXT_LINE_HEIGHT] doubleValue] + 20.0f;
        }
    }
    tableView.frame = CGRectMake(0, CGRectGetMaxY(view.frame), 320, height);
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.bounces = NO;
    // 干掉底部多余的横线
    UIView *footerView = [[UIView alloc] init];
    footerView.frame = CGRectMake(0, 0, 320, 1);
    footerView.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:footerView];
    [footerView release];
    [self.view addSubview:tableView];
    [tableView release];
}

#pragma mark 数据源方法<UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _packedInfos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 文本行
    if ([_packedInfos[indexPath.row] objectForKey:CONTENT] &&
             [[_packedInfos[indexPath.row] objectForKey:CONTENT] length] > 0)
    {
        return [self customLabelCellWithLabel:[_packedInfos[indexPath.row] objectForKey:DICT_INFO_KIND] detailLabel:[_packedInfos[indexPath.row] objectForKey:CONTENT] forCellIndexPath:indexPath];
    }
    
    // 个人相册
    if ([_packedInfos[indexPath.row] objectForKey:PHOTOS] && [[_packedInfos[indexPath.row] objectForKey:PHOTOS] count] > 0)
    {
        return [self customPhotosViewWithLabel:[_packedInfos[indexPath.row] objectForKey:DICT_INFO_KIND] photos:[_packedInfos[indexPath.row] objectForKey:PHOTOS] forCellIndexPath:indexPath];
    }
    
    return [[[UITableViewCell alloc] init] autorelease];
}

#pragma mark - 代理方法<UITableViewDelegate>
#pragma mark 如何做到cell行高根据文本内容多少自动适应？？？
// 每一行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 个人相册
    if ([_packedInfos[indexPath.row] objectForKey:PHOTOS])
    {
        [_cellsHeight setObject:@(PHOTOS_CELL_HEIGHT) forKey:@(indexPath.row)];
        return PHOTOS_CELL_HEIGHT;
    }

    // 其他文本数据行
    NSInteger cellHeight = [[_packedInfos[indexPath.row] objectForKey:TEXT_LINE_HEIGHT] integerValue] + 20;
    [_cellsHeight setObject:@(cellHeight) forKey:@(indexPath.row)];
    return cellHeight; // cell自适应文本高度
}

#pragma mark - 内部方法
// 自定义必要信息展示的视图
- (void)customRequiredInfosView
{
    UIView *requiredView = [[UIView alloc] init];
    requiredView.frame = CGRectMake(0, 44 + 20 , 320, REQUIRED_VIEW_HEIGHT);
    requiredView.tag = REQUIRED_VIEW_TAG;
    [self.view addSubview:requiredView];
    [requiredView release];
    
   // 显示头像
    UIImage *avatar = _personInformations.avatar;

    if (!avatar)
    {
        avatar = [UIImage imageNamed:@"contacts_default_avatar@2x"];
    }
    UIImageView *avatarView = [[UIImageView alloc] initWithImage:avatar];
    avatarView.bounds = CGRectMake(0, 0, REQUIRED_VIEW_AVATAR_HEIGHT, REQUIRED_VIEW_AVATAR_HEIGHT);
    avatarView.center = CGPointMake(REQUIRED_VIEW_AVATAR_HEIGHT/2 + 10, requiredView.frame.size.height/2);
    [requiredView addSubview:avatarView];
    [avatarView release];    

    // 显示备注or昵称or帐号
    // 大字号显示的内容
    NSString *remarkName = _personInformations.remarkName; // 可能存在
    NSString *nickName = _personInformations.nickName; // 一定存在
    NSString *account = _personInformations.account; // 一定存在
    NSString *mainLabelText = nil;
    BOOL isRemarkNameExist = NO;
    if (remarkName && remarkName.length > 0) // 备注存在
    {
        mainLabelText = [NSString stringWithFormat:@"%@", remarkName];
        isRemarkNameExist = YES;
    }
    else // 昵称一定存在的
    {
        mainLabelText = [NSString stringWithFormat:@"%@", nickName];
    }
        
    CGSize size = CGSizeMake(0, 0);
    if (mainLabelText && mainLabelText.length > 0)
    {
        size = [self sizeWithString:mainLabelText
                               font:[UIFont systemFontOfSize:14.0f]
                     constraintSize:CGSizeMake(320 - CONTACTS_DETAIL_REQUIRED_INFOS_DEVIDE_COORDINATE_X, REQUIRED_VIEW_AVATAR_HEIGHT/3)];
    }
    
    // 备注名和性别标识图片的父视图
    UIView *mainView = [[UIView alloc] init];
    mainView.bounds = CGRectMake(0, 0, 320 - CONTACTS_DETAIL_REQUIRED_INFOS_DEVIDE_COORDINATE_X, REQUIRED_VIEW_AVATAR_HEIGHT/3);
    mainView.center = CGPointMake((320 - CONTACTS_DETAIL_REQUIRED_INFOS_DEVIDE_COORDINATE_X)/2 + CONTACTS_DETAIL_REQUIRED_INFOS_DEVIDE_COORDINATE_X, REQUIRED_VIEW_HEIGHT/2 - mainView.bounds.size.height);
    [requiredView addSubview:mainView];
    [mainView release];
    
    UILabel *mainLabel = [[UILabel alloc] init];
    mainLabel.bounds = CGRectMake(0, 0, size.width, size.height);
    mainLabel.center = CGPointMake(size.width/2 , mainView.frame.size.height/2);
    mainLabel.font = [UIFont systemFontOfSize:14.0f];
    mainLabel.text = mainLabelText;
    [mainView addSubview:mainLabel];
    [mainLabel release];
    // 性别标识图片
    UIImage *sexImage;
    if (_personInformations.sex == male)
    {
        sexImage = [UIImage imageNamed:@"ic_sex_male"];
    }
    else if (_personInformations.sex == famale)
    {
        sexImage = [UIImage imageNamed:@"ic_sex_female"];
    }
    else
    {
        sexImage = nil;
    }
    UIImageView *sexView = [[UIImageView alloc] initWithImage:sexImage];
    sexView.bounds = CGRectMake(0, 0, 15, 15);
    sexView.center = CGPointMake(CGRectGetMaxX(mainLabel.frame) + 15/2, CGRectGetMidY(mainLabel.frame));
    [mainView addSubview:sexView];
    [sexView release];
    
    UILabel *detailMiddleLabel = [[UILabel alloc] init];
    detailMiddleLabel.bounds = CGRectMake(0, 0, 320 - CONTACTS_DETAIL_REQUIRED_INFOS_DEVIDE_COORDINATE_X, REQUIRED_VIEW_AVATAR_HEIGHT/3);
    detailMiddleLabel.center = CGPointMake((320 - CONTACTS_DETAIL_REQUIRED_INFOS_DEVIDE_COORDINATE_X)/2 + CONTACTS_DETAIL_REQUIRED_INFOS_DEVIDE_COORDINATE_X, CGRectGetMidY(mainView.frame) + detailMiddleLabel.bounds.size.height);
    detailMiddleLabel.font = [UIFont systemFontOfSize:12.0f];
    NSString *detailMiddleLabelText = nil;
    BOOL isdetailMiddleLabelShouldAdd = YES; // 是否应该添加detailMiddleLabel视图
    if (isRemarkNameExist)
    {
        // 显示帐号
        UILabel *detailBottomLabel = [[UILabel alloc] init];
        detailBottomLabel.bounds = CGRectMake(0, 0, 320 - CONTACTS_DETAIL_REQUIRED_INFOS_DEVIDE_COORDINATE_X, REQUIRED_VIEW_AVATAR_HEIGHT/3);
        detailBottomLabel.center = CGPointMake((320 - CONTACTS_DETAIL_REQUIRED_INFOS_DEVIDE_COORDINATE_X)/2 + CONTACTS_DETAIL_REQUIRED_INFOS_DEVIDE_COORDINATE_X, CGRectGetMidY(detailMiddleLabel.frame) + detailBottomLabel.bounds.size.height);
        detailBottomLabel.font = [UIFont systemFontOfSize:12.0f];
        detailBottomLabel.text = [NSString stringWithFormat:WECHAT_NUMBER_PRINT, account];
        [requiredView addSubview:detailBottomLabel];
        [detailBottomLabel release];
        
        detailMiddleLabelText = [NSString stringWithFormat:NICK_NAME_PRINT, nickName];
    }
    else
    {
        BOOL isVisible = YES;
        NSInteger flag = arc4random()%2;
        if (flag)
        {
            isVisible = NO;
        }
        
        if (!isVisible) // 如果设置了微信号不可见，只显示昵称或者备注
        {
            mainView.center = CGPointMake((320 - CONTACTS_DETAIL_REQUIRED_INFOS_DEVIDE_COORDINATE_X)/2 + CONTACTS_DETAIL_REQUIRED_INFOS_DEVIDE_COORDINATE_X, REQUIRED_VIEW_HEIGHT/2);
            
            isdetailMiddleLabelShouldAdd = NO;
        }
        else // 微信号可见，显示昵称(或备注)和微信号
        {
            mainView.center = CGPointMake((320 - CONTACTS_DETAIL_REQUIRED_INFOS_DEVIDE_COORDINATE_X)/2 + CONTACTS_DETAIL_REQUIRED_INFOS_DEVIDE_COORDINATE_X, CGRectGetMidY(avatarView.frame) - mainView.bounds.size.height + mainView.frame.size.height/2);
            detailMiddleLabel.center = CGPointMake((320 - CONTACTS_DETAIL_REQUIRED_INFOS_DEVIDE_COORDINATE_X)/2 + CONTACTS_DETAIL_REQUIRED_INFOS_DEVIDE_COORDINATE_X, CGRectGetMidY(mainView.frame) + detailMiddleLabel.bounds.size.height);
            
            detailMiddleLabelText = [NSString stringWithFormat:WECHAT_NUMBER_PRINT, account];
        }
    }
    
    if (isdetailMiddleLabelShouldAdd)
    {
        detailMiddleLabel.text = detailMiddleLabelText;
        [requiredView addSubview:detailMiddleLabel];
    }
    
    [detailMiddleLabel release];
}

// 自定义文本cell显示效果
- (UITableViewCell *)customLabelCellWithLabel:(NSString *)labelText detailLabel:(NSString *)detailLabelText forCellIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[[UITableViewCell alloc] init] autorelease];
    [self customLabelWithText:labelText forCell:cell indexPath:indexPath];
    [self customDetailLabelWithText:detailLabelText forCell:cell indexPath:indexPath];
    return cell;
}

// 自定义个人相册cell显示效果
- (UITableViewCell *)customPhotosViewWithLabel:(NSString *)labelText photos:(NSMutableArray *)phpotos forCellIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[[UITableViewCell alloc] init] autorelease];
    [self customLabelWithText:labelText forCell:cell indexPath:indexPath];
    [self customDetailViewWithImages:phpotos forCell:cell indexPath:indexPath];
    return cell;
}

// 自定义左侧显示文本的label
- (void)customLabelWithText:(NSString *)text forCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    UILabel *customLabel = [[UILabel alloc] init];
    NSUInteger cellHeight = [[_cellsHeight objectForKey:@(indexPath.row)] integerValue];
    customLabel.bounds = CGRectMake(0, 0, 320/5 , cellHeight);
    customLabel.center = CGPointMake(CONTACTS_DETAIL_REQUIRED_INFOS_DEVIDE_COORDINATE_X/2 + 5, cellHeight/2);
    customLabel.textAlignment = NSTextAlignmentLeft;
    customLabel.font = [UIFont systemFontOfSize:14];
    customLabel.text = text;
    [cell addSubview:customLabel];
    [customLabel release];
}

// 自定义右侧显示文本的label
- (void)customDetailLabelWithText:(NSString *)text forCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    UILabel *customDetailLabel = [[UILabel alloc] init];
    NSUInteger cellHeight = [[_cellsHeight objectForKey:@(indexPath.row)] integerValue];
    NSInteger devideX = CONTACTS_DETAIL_REQUIRED_INFOS_DEVIDE_COORDINATE_X/2 + 320/5/2;
    customDetailLabel.bounds = CGRectMake(0, 0, 320 - devideX - 17, cellHeight);
    customDetailLabel.center = CGPointMake((320 - devideX)/2 + devideX + 5, cellHeight/2);
    customDetailLabel.textAlignment = NSTextAlignmentLeft;
    customDetailLabel.text = text;
    customDetailLabel.font = [UIFont systemFontOfSize:12];
    customDetailLabel.numberOfLines = 0;
    [cell addSubview:customDetailLabel];
    [customDetailLabel release];
}

// 自定义右侧显示图片的ImageView
- (void)customDetailViewWithImages:(NSMutableArray *)images forCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    NSInteger width = (320 - CONTACTS_DETAIL_REQUIRED_INFOS_DEVIDE_COORDINATE_X)/3;
    for (int i = 0; i < images.count; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.bounds = CGRectMake(0, 0, 60, 60);
        imageView.center = CGPointMake(CONTACTS_DETAIL_REQUIRED_INFOS_DEVIDE_COORDINATE_X + width/2 + i * width, PHOTOS_CELL_HEIGHT/2);
        imageView.image = images[images.count -1 - i];
        [cell addSubview:imageView];
        [imageView release];
    }
}

#pragma mark 打包个人信息数据，重新封装到信息字典到数组
- (NSMutableArray *)packPersonInformations
{
    NSMutableArray *pInfos = [NSMutableArray array];
    // 打包可选信息字典
    // 地区信息
    if (_personInformations.region && _personInformations.region.length > 0)
    {
        NSMutableDictionary *regionDict = [[NSMutableDictionary alloc] init];
        [regionDict setObject:_personInformations.region forKey:CONTENT];
        CGSize size = [self sizeWithString:_personInformations.region
                                      font:[UIFont systemFontOfSize:12.0f]
                            constraintSize:CGSizeMake(320 - 87, 568)];
        [regionDict setObject:@(size.height) forKey:TEXT_LINE_HEIGHT];
        [regionDict setObject:REGION forKey:DICT_INFO_KIND];
        [pInfos addObject:regionDict];
        [regionDict release];
    }

    // 个性签名
    if (_personInformations.signature && _personInformations.signature.length > 0)
    {
        NSMutableDictionary *signatureDict = [[NSMutableDictionary alloc] init];
        [signatureDict setObject:_personInformations.signature forKey:CONTENT];
        CGSize size = [self sizeWithString:_personInformations.signature
                               font:[UIFont systemFontOfSize:12.0f]
                     constraintSize:CGSizeMake(320 - 87, 568)]; // 87 = devideX
        [signatureDict setObject:@(size.height) forKey:TEXT_LINE_HEIGHT];
        [signatureDict setObject:_SIGNATURE forKey:DICT_INFO_KIND];
        [pInfos addObject:signatureDict];
        [signatureDict release];
    }
    
    // 个人相册
    if (_personInformations.photos && _personInformations.photos.count > 0)
    {
        NSMutableDictionary *photosDict = [[NSMutableDictionary alloc] init];
        [photosDict setObject:_personInformations.photos forKey:PHOTOS];
        [photosDict setObject:PHOTOS forKey:DICT_INFO_KIND];
        [pInfos addObject:photosDict];
        [photosDict release];
    }
    
    return pInfos;
}

// 根据文本内容获取Rect的size
- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font constraintSize:(CGSize)constraintSize
{
    CGRect rect = [string boundingRectWithSize:constraintSize
                                       options: NSStringDrawingTruncatesLastVisibleLine |
                                                NSStringDrawingUsesFontLeading |
                                                NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
                                       context:nil];
    return rect.size;
}


@end
