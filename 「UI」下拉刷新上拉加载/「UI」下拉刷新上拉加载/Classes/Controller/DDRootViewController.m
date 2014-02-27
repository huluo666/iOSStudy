//
//  DDRootViewController.m
//  「UI」下拉刷新下拉加载
//
//  Created by 萧川 on 14-2-25.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

static NSString *CellIdentifier = @"Cell";

#import "DDRootViewController.h"
#import "DDPullDown.h"
#import "DDPullUp.h"

@interface DDRootViewController ()
{
    NSMutableArray *_dataSource; // 数据源
}

// 初始化数据
- (void)initDataSource;
// 初始化用户界面
- (void)initUserInterface;
// 加载下拉刷新视图
- (void)loadPullDownView;
// 加载上拉加载更多视图
- (void)loadPullUpView;

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
        [_dataSource addObject:[NSString stringWithFormat:@"初始测试数据编号：%d", arc4random() % 99999]];
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
    pullDown.refreshStateChange = ^(DDRefreshBaseView *refreshBaseView, DDRefreshState state) {
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
        // 添加数据
        for (int i = 0; i < 5; i++) {
            [_dataSource insertObject:[NSString stringWithFormat:@"下拉测试数据编号：%d",
                                       arc4random() % 99999] atIndex:0];
        }
        // 模拟加载数据等待过程
        [self performSelector:@selector(loadData:)
                   withObject:refreshBaseView
                   afterDelay:1.0];
    };
    
    pullDown.didRefreshBaseView = ^(DDRefreshBaseView *refreshBaseView) {
        NSLog(@"!!!!!!!!%@当前状态：数据刷新完成", [refreshBaseView class]);
    };
    
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
        // 添加数据
        for (int i = 0; i < 5; i++) {
            [_dataSource addObject:[NSString stringWithFormat:@"上拉测试数据编号：%d",
                                       arc4random() % 99999]];
        }
        // 模拟加载数据等待过程
        [self performSelector:@selector(loadData:)
                   withObject:refreshBaseView
                   afterDelay:1.0];
    };
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier]; 
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }

    cell.textLabel.text = _dataSource[indexPath.row];
    
    return cell;
}

@end
