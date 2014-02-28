//
//  DDRootViewController.m
//  「UI」下拉刷新下拉加载
//
//  Created by 萧川 on 14-2-25.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDRootViewController.h"
#import "DDPullDown.h"
#import "DDPullUp.h"

@interface DDRootViewController ()
{
    NSMutableArray *_dataSource; // 数据源
    UIAlertView *_alertView;
}

// 初始化数据
- (void)initDataSource;
// 初始化用户界面
- (void)initUserInterface;
// 加载下拉刷新视图
- (void)loadPullDownView;
// 加载上拉加载更多视图
- (void)loadPullUpView;
// 响应网络请求
- (void)responseRequestWithDDRefreshBaseView:(DDRefreshBaseView*)refreshBaseView
                               DDRefreshType:(DDRefreshType)type;
@end

@implementation DDRootViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"列表视图展示";
    }
    return self;
}

- (void)dealloc
{
    [_dataSource release];
    [_alertView release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initDataSource];
    [self initUserInterface];
}

#pragma mark - 私有方法

- (void)initDataSource
{
    _dataSource = [[NSMutableArray alloc] init];
    for (int i = 0; i < 5; i++) {
        [_dataSource addObject:[NSString stringWithFormat:@"初始测试数据编号：%d",
                                arc4random() % 99999]];
    }
}

- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // 载入下拉刷新视图
    [self loadPullDownView];
    
    // 载入上拉加载更多视图
    [self loadPullUpView];
}

- (void)loadPullDownView
{
    DDPullDown *pullDown = [DDPullDown pullDown];
    pullDown.scrollView = self.tableView;
    
    // 打开页面自动刷新
//    [pullDown beginRefreshing];
    
    // 回调方法实现
    pullDown.refreshStateChange = ^(DDRefreshBaseView *refreshBaseView,
                                    DDRefreshState state) {
        switch (state){
            case DDRefreshStatePulling:
                NSLog(@"!!!!!!!!%@当前状态：松开即将刷新数据", [refreshBaseView class]);
                break;
            case DDRefreshStateNormal:
                NSLog(@"!!!!!!!!%@当前状态：普通状态", [refreshBaseView class]);
                break;
            case DDRefreshStateRefreshing:
                NSLog(@"!!!!!!!!%@当前状态：正在刷新中...", [refreshBaseView class]);
                break;
            default:
                break;
        }
    };
    
    pullDown.beginRefreshBaseView = ^(DDRefreshBaseView *refreshBaseView) {
        [self responseRequestWithDDRefreshBaseView:refreshBaseView
                                     DDRefreshType:DDRefreshTypePullDown];
    };
    
    pullDown.didRefreshBaseView = ^(DDRefreshBaseView *refreshBaseView) {
        NSLog(@"!!!!!!!!%@当前状态：数据刷新完成", [refreshBaseView class]);
    };
    
}

- (void)responseRequestWithDDRefreshBaseView:(DDRefreshBaseView*)refreshBaseView
                               DDRefreshType:(DDRefreshType)type
{
    // 模拟网络请求过程，返回请求成功或者失败和一个数组对象(这里为了简单，数组已经添加到数据源了)
    for (int i = 0; i < 5; i++) {
        if (type == DDRefreshTypePullDown) {
            [_dataSource insertObject:[NSString stringWithFormat:@"下拉测试数据编号：%d",
                                  arc4random() % 99999] atIndex:0];
        } else {
            [_dataSource addObject:[NSString stringWithFormat:@"上拉测试数据编号：%d",
                               arc4random() % 99999]];
        }
        
    }
    
    BOOL success = YES;
//    BOOL success = NO;
    if (success) {
        // 模拟加载数据等待过程, 加载完成更新数据
        [self performSelector:@selector(loadData:)
                   withObject:refreshBaseView
                   afterDelay:1.0];
    } else {
        _alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                message:@"刷新数据失败，或者没有更新的数据，或者网络连接不正常，请稍候重试"
                                               delegate:nil
                                      cancelButtonTitle:nil
                                      otherButtonTitles:nil];
        [_alertView show];
        [self performSelector:@selector(dissmissAlertView:)
                   withObject:refreshBaseView
                   afterDelay:1.5];
    }
}

- (void)dissmissAlertView:(DDRefreshBaseView *)refreshBaseView
{
    [_alertView dismissWithClickedButtonIndex:0 animated:YES];
    [refreshBaseView endRefreshing];
}

- (void)loadData:(DDRefreshBaseView *)refreshBaseView
{
    [self.tableView reloadData];
    [refreshBaseView endRefreshing];
}

- (void)loadPullUpView
{
    DDPullUp *pullUp = [DDPullUp pullUp];
    pullUp.scrollView = self.tableView;
    pullUp.beginRefreshBaseView = ^(DDRefreshBaseView *refreshBaseView) {
        [self responseRequestWithDDRefreshBaseView:refreshBaseView
                                     DDRefreshType:DDRefreshTypePullUp];
    };
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                       reuseIdentifier:CellIdentifier] autorelease];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;

        UIView *cellBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cellBackgroundView.backgroundColor = kRandomColor;
        cell.backgroundView = cellBackgroundView;
        [cellBackgroundView release];
    }
    cell.textLabel.text = _dataSource[indexPath.row];
    
    return cell;
}

@end
