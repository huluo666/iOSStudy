//
//  HomePageViewController.m
//  UITask
//
//  Created by cuan on 14-2-13.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "HomePageViewController.h"

@interface HomePageViewController () <UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) NSMutableArray *timeArray;
@property (retain, nonatomic) UIRefreshControl *control;
@property (retain, nonatomic) UITableView *myTableView;

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
        _timeArray = [[NSMutableArray alloc]init];
        _control = [[UIRefreshControl alloc] init];
        _myTableView = [[UITableView alloc] init];
        self.refreshControl = _control;
        self.tableView = _myTableView;
    }
    return self;
}

- (void)dealloc
{
    [_timeArray release];
    [_control release];
    [_myTableView release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadClearBarItem];
    [self initUserInterface];
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
    [_myTableView reloadData];
}


- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor whiteColor];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    
    _control.tintColor = [UIColor lightGrayColor];
    NSAttributedString *attributedTitle = [[NSAttributedString alloc]
                                           initWithString:@"下拉刷新"];
    _control.attributedTitle = attributedTitle;
    [attributedTitle release];
    [_control addTarget:self
                 action:@selector(refreshTableviewAction:)
       forControlEvents:UIControlEventValueChanged];
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
    _control.attributedTitle = attributedTitle;
    [attributedTitle release];
    
    [_timeArray addObject:syseTime];
    [_control endRefreshing];
    [_myTableView reloadData];
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
