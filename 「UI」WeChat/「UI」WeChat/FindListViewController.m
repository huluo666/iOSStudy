//
//  FindViewController.m
//  「UI」WeChat
//
//  Created by cuan on 14-2-1.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "FindListViewController.h"
#import "FindDatas.h"
#import "Find.h"
#import "FriendsCricleViewController.h"
#import "ScanViewController.h"
#import "ShakeViewController.h"
#import "NearbyViewController.h"
#import "GamesViewController.h"
#import "EmotionStoreViewController.h"
#import "BaseViewController.h"

@interface FindListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic) NSArray *allTables;

@end

@implementation FindListViewController

- (void)dealloc
{
    [_allTables release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    [self initTableView];
    self.title = FIND;
}

- (void)initTableView
{
#pragma mark 如何让UITaleView视图自动适应内容所占空间大小？

    UITableView *findTableView = [[UITableView alloc] init];
    NSInteger deviceScreenHeight = self.view.frame.size.height;
    findTableView.frame = CGRectMake(0, 35, 320, deviceScreenHeight - 35);
    // 干掉底部多余的横线,效果不彻底，点住拖出去松开，又会出现
    UIView *footerView = [[UIView alloc] init];
    footerView.frame = CGRectMake(0, 0, 320, 1);
    footerView.backgroundColor = [UIColor clearColor];
    [findTableView setTableFooterView:footerView];
    [footerView release];
    // 关联数据源
    // @property (nonatomic, assign)   id <UITableViewDataSource> dataSource;
    findTableView.dataSource = self;
    // 设置代理
    findTableView.delegate = self;
    // 设置数据
    _allTables = [[FindDatas datas] retain];
    // 去掉弹簧效果
    findTableView.bounces = NO;
    [self.view addSubview:findTableView];
    [findTableView release];
}

#pragma mark - 数据源方法<UITableViewDataSource>
// 第section组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allTables.count;
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
    cell.textLabel.text = [_allTables[indexPath.row] name];
    cell.imageView.image = [_allTables[indexPath.row] leftImage];
    cell.accessoryView = [[[UIImageView alloc] initWithImage:[_allTables[indexPath.row] rightImage]] autorelease];
    return cell;
}

#pragma mark - 代理方法<UITableViewDelegate>
// 每一行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger deviceScreenHeight = self.view.frame.size.height;
    if (480 == deviceScreenHeight) {
        return FIND_CELL_HEIGHT_BEFORE_IP5;
    }
    return FIND_CELL_HEIGHT_BEFORE_NOW;
}

// 选中某一行的cell调用该方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *subVCs = [self findSubVCs];
//    self.title = [_allTables[indexPath.row] name];
    [subVCs[indexPath.row] setTitle:[_allTables[indexPath.row] name]];
    [self.navigationController pushViewController:subVCs[indexPath.row] animated:YES];
}

#pragma mark - 内部方法
- (NSMutableArray *)findSubVCs
{
    NSMutableArray *subVCs = [NSMutableArray array];
    
    // 初始化VC数据
    // 朋友圈
    FriendsCricleViewController *friendsVC = [[FriendsCricleViewController alloc] init];
    [subVCs addObject:friendsVC];
    [friendsVC release];
    // 扫一扫
    ScanViewController *scanVC = [[ScanViewController alloc] init];
    [subVCs addObject:scanVC];
    [scanVC release];
    // 摇一摇
    ShakeViewController *shakeVC = [[ShakeViewController alloc] init];
    [subVCs addObject:shakeVC];
    [shakeVC release];
    // 附近的人
    NearbyViewController *nearbyVC = [[NearbyViewController alloc] init];
    [subVCs addObject:nearbyVC];
    [nearbyVC release];
    // 游戏
    GamesViewController *gamesVC = [[GamesViewController alloc] init];
    [subVCs addObject:gamesVC];
    [gamesVC release];
    // 表情商店
    EmotionStoreViewController *emotionStoreVC = [[EmotionStoreViewController alloc] init];
    [subVCs addObject:emotionStoreVC];
    [emotionStoreVC release];
    
    return subVCs;
}


@end
