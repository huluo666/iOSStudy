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

@interface DDRootViewController () <DDRefreshBaseDelegate>
{
    NSMutableArray *_dataSource; // 数据源
    DDPullDown *_pullDown;
}

// 初始化数据
- (void)initDataSource;
// 初始化用户界面
- (void)initUserInterface;
// 加载头部视图
- (void)loadHeaderView;
// 加载尾部视图
- (void)loadFooterView;

@end

@implementation DDRootViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"表视图展示";
    }
    return self;
}

- (void)dealloc
{
    [_dataSource release];
    [_pullDown release];
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
        [_dataSource addObject:[NSString stringWithFormat:@"测试数据编号：%d", arc4random() % 99999]];
    }
}

- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 注册重用cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    // 载入头部视图
    [self loadHeaderView];
    
    // 载入尾部视图
//    [self loadFooterView];
}

- (void)loadHeaderView
{
    DDPullDown *pullDown = [DDPullDown pullDown];

    pullDown.scrollView = self.tableView;
//    pullDown.beginRefreshBaseView = ^(DDRefreshBaseView *refreshBaseView) {
//        // 添加数据
//        for (int i = 0; i < 5; i++) {
//            [_dataSource addObject:[NSString stringWithFormat:@"测试数据编号：%d", arc4random() % 99999]];
//        }
//        
//        [self performSelector:@selector(doneWithView:) withObject:refreshBaseView afterDelay:1.0];
//        
//        NSLog(@"%@ 开始刷新", refreshBaseView.class);
//    };
    
//    pullDown.didRefreshBaseView = ^(DDRefreshBaseView *refreshBaseView) {
//        NSLog(@"%@ 刷新完成", refreshBaseView.class);
//    };
//    
//    pullDown.refreshStateChange = ^(DDRefreshBaseView *refreshBaseView, DDRefreshState state) {
//        if (state == DDRefreshStateNormal) {
//            NSLog(@"%@当前状态: 普通", refreshBaseView.class);
//        }
//        if (state == DDRefreshStatePulling) {
//            NSLog(@"%@当前状态: 松开即可刷新", refreshBaseView.class);
//        }
//        if (state == DDRefreshStateRefreshing) {
//            NSLog(@"%@当前状态: 正在刷新", refreshBaseView.class);
//        }
//    };
    
    _pullDown = [pullDown retain];
    
}

- (void)doneWithView:(DDRefreshBaseView *)refreshBaseView
{
    [self.tableView reloadData];
    [refreshBaseView endRefreshing];
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
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }

    cell.textLabel.text = _dataSource[indexPath.row];
    
    return cell;
}

#pragma mark ---

- (void)refreshBaseViewbeginRefreshing:(DDRefreshBaseView *)refreshBaseView
{
    NSLog(@"refreshBaseViewbeginRefreshing");
}

- (void)refreshBaseView:(DDRefreshBaseView *)refreshBaseView stateChange:(DDRefreshState)state
{
    NSLog(@"refreshBaseView");
}

- (void)refreshBaseViewDidRefreshing:(DDRefreshBaseView *)refreshBaseView
{
    NSLog(@"refreshBaseViewDidRefreshing");
}

@end
