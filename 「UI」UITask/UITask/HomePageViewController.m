//
//  HomePageViewController.m
//  UITask
//
//  Created by cuan on 14-2-13.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "HomePageViewController.h"
#import "LoginViewController.h"

@interface HomePageViewController () <UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) NSMutableArray *timeArray;

- (void)initUserInterface;
- (void)refreshTableviewAction:(UIRefreshControl *)refresh;
- (void)refershData;
- (void)loadClearBarItem;
- (void)clearTableViewData:(UIBarButtonItem *)clearItem;

@end

@implementation HomePageViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"主页";
        _timeArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)dealloc
{
    [_timeArray release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _logined = NO;
    [self loadClearBarItem];
    [self initUserInterface];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    _logined = YES;
    if (!_logined) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
        [loginVC release];
        
        self.title = @"首页";
    }
}

- (void)loadClearBarItem
{
    UIBarButtonItem *clearItem = [[UIBarButtonItem alloc]
                                  initWithTitle:@"请空"
                                  style:UIBarButtonItemStylePlain
                                  target:self
                                  action:@selector(clearTableViewData:)];
    self.navigationItem.rightBarButtonItem = clearItem;
    [clearItem release];
}

#pragma mark 请空数据

- (void)clearTableViewData:(UIBarButtonItem *)clearItem
{
    _timeArray = [@[] mutableCopy];
    [self.tableView reloadData];
}


- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIRefreshControl *refreshController = [[UIRefreshControl alloc] init];
    self.refreshControl = refreshController;
    [refreshController release];
    
    self.refreshControl.tintColor = [UIColor lightGrayColor];
    NSAttributedString *attributedTitle = [[NSAttributedString alloc]
                                           initWithString:@"下拉刷新"];
    self.refreshControl.attributedTitle = attributedTitle;
    [attributedTitle release];
    [self.refreshControl addTarget:self
                 action:@selector(refreshTableviewAction:)
       forControlEvents:UIControlEventValueChanged];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

#pragma mark 开始刷新数据

-(void)refreshTableviewAction:(UIRefreshControl *)refresh
{
    if (refresh.refreshing) {
        NSAttributedString *attributedTitle = [[NSAttributedString alloc]
                                               initWithString:@"正在刷新"];
        refresh.attributedTitle = attributedTitle;
        [attributedTitle release];
        [self performSelector:@selector(refershData) withObject:nil afterDelay:0.8f];
    }
}

-(void)refershData
{
    NSString *syseTime = nil;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    syseTime = [formatter stringFromDate:[NSDate date]];
    
    NSString *lastUpdated = [NSString stringWithFormat:@"上一次更新时间为 %@",
                             [formatter stringFromDate:[NSDate date]]];
    [formatter release];
    
    NSAttributedString *attributedTitle = [[NSAttributedString alloc]
                                           initWithString:lastUpdated];
    self.refreshControl.attributedTitle = attributedTitle;
    [attributedTitle release];
    
    [_timeArray addObject:syseTime];
    [self.refreshControl endRefreshing];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _timeArray.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleSubtitle
                 reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"index%ld", indexPath.row];
    cell.detailTextLabel.text = [_timeArray objectAtIndex:indexPath.row];
    
    return cell;
}

@end
