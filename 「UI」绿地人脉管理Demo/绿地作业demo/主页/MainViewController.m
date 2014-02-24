//
//  MainViewController.m
//  绿地作业demo
//
//  Created by 张鹏 on 14-2-14.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController () {
    
    NSMutableDictionary *_dataSource;
    NSMutableArray *_dates;
}

- (void)initializeDataSource;
- (void)initializeUserInterface;
// 开始刷新
- (void)processStartRefresh:(UIRefreshControl *)refreshControl;
// 刷新完成
- (void)processCompleteRefresh:(UIRefreshControl *)refreshControl;
// 更新数据源
- (void)updateDataSource;
// 清除数据
- (void)barButtonPressed:(UIBarButtonItem *)sender;

@end

@implementation MainViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = @"主页";
    }
    return self;
}

- (void)dealloc {
    
    [_dataSource release];
    [_dates      release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)initializeDataSource {
    
    _dataSource = [[NSMutableDictionary alloc] init];
    _dates = [[NSMutableArray alloc] init];
}

- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.attributedTitle = [[[NSAttributedString alloc] initWithString:@"下拉刷新"] autorelease];
    [refreshControl addTarget:self action:@selector(processStartRefresh:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    [refreshControl release];
    
    UIBarButtonItem *clearItem = [[UIBarButtonItem alloc]
                                  initWithTitle:@"Clear"
                                  style:UIBarButtonItemStylePlain
                                  target:self
                                  action:@selector(barButtonPressed:)];
    self.navigationItem.rightBarButtonItem = clearItem;
    [clearItem release];
}

- (void)barButtonPressed:(UIBarButtonItem *)sender {
    
    [_dataSource removeAllObjects];
    [_dates removeAllObjects];
    [self.tableView reloadData];
}

- (void)processStartRefresh:(UIRefreshControl *)refreshControl {
    
    [refreshControl beginRefreshing];
    refreshControl.attributedTitle = [[[NSAttributedString alloc] initWithString:@"刷新中..."] autorelease];
    [self performSelector:@selector(processCompleteRefresh:) withObject:refreshControl afterDelay:3];
}

- (void)processCompleteRefresh:(UIRefreshControl *)refreshControl {
    
    [refreshControl endRefreshing];
    refreshControl.attributedTitle = [[[NSAttributedString alloc] initWithString:@"下拉刷新"] autorelease];
    [self updateDataSource];
    [self.tableView reloadData];
}

- (void)updateDataSource {
    
    NSUInteger count = [_dataSource count];
    NSString *value = [NSString stringWithFormat:@"index%u", count];
    NSString *date = [NSString stringWithFormat:@"%@", [NSDate date]];
    [_dataSource setObject:value forKey:date];
    [_dates removeAllObjects];
    [_dates addObjectsFromArray:[_dataSource allKeys]];
    [_dates sortUsingSelector:@selector(compare:)];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:cellIdentifier] autorelease];
    }
    cell.textLabel.text = _dataSource[_dates[indexPath.row]];
    cell.detailTextLabel.text = _dates[indexPath.row];
    
    return cell;
}

@end
