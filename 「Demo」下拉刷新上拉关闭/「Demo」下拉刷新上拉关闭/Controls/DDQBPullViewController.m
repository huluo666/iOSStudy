//
//  DDQBPullViewController.m
//  「Demo」下拉刷新上拉关闭
//
//  Created by 萧川 on 14-4-12.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDQBPullViewController.h"
#import "QBRefreshControl.h"
#import "QBArrowRefreshControl.h"

@interface DDQBPullViewController () <QBRefreshControlDelegate, UITableViewDataSource>

@property (nonatomic, retain) QBArrowRefreshControl *myRefreshControl;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation DDQBPullViewController

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
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // Black Background
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, -400, 320, 400)];
    bgView.backgroundColor = [UIColor blackColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView addSubview:bgView];
    
    // Refresh Control
    QBArrowRefreshControl *refreshControl = [[QBArrowRefreshControl alloc] init];
    refreshControl.delegate = self;
    [self.tableView addSubview:refreshControl];
    self.myRefreshControl = refreshControl;
    
    _dataSource = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 16; i++) {
        NSString *str = [NSString stringWithFormat:@"初始数据编号：%ld", i];
        [_dataSource addObject:str];
    }

    
}

#pragma mark - QBRefreshControlDelegate

- (void)refreshControlDidBeginRefreshing:(QBRefreshControl *)refreshControl
{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 3.0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.myRefreshControl endRefreshing];
    });
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
