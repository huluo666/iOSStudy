//
//  DDPullDownViewController.m
//  「Demo」下拉刷新上拉关闭
//
//  Created by 萧川 on 14-4-12.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDPullDownViewController.h"
#import "DDPullDown.h"

@interface DDPullDownViewController () <UITableViewDataSource>

@property (strong, nonatomic) DDPullDown *pullDown;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DDPullDownViewController

- (void)dealloc {

    [_pullDown free];
    NSLog(@"%s", __FUNCTION__);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    __weak DDPullDownViewController *weakSelf = self;
    
    DDPullDown *pullDown = [DDPullDown pullDown];
    pullDown.scrollView = self.tableView;
    pullDown.beginRefreshBaseView = ^(DDRefreshBaseView *refreshBaseView) {
        // 刷新
        [weakSelf performSelector:@selector(stopWithRefreshBaseView:) withObject:refreshBaseView afterDelay:0.01];
    };
    
    pullDown.didRefreshBaseView = ^(DDRefreshBaseView *refreshBaseView) {
        // 刷新完成以后调用
        NSLog(@"!!!!!!!!%@当前状态：数据刷新完成", [refreshBaseView class]);
    };
    
    _pullDown = pullDown;
    
    _dataSource = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 16; i++) {
        NSString *str = [NSString stringWithFormat:@"初始数据编号：%ld", i];
        [_dataSource addObject:str];
    }
}

- (void)stopWithRefreshBaseView:(DDRefreshBaseView *)refreshBaseView {

    [refreshBaseView endRefreshingWithSuccess:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cellIdenitfier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = _dataSource[indexPath.row];
    return cell;
}


@end
