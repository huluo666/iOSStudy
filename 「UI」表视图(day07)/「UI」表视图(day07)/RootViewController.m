//
//  RootViewController.m
//  「UI」表视图(day07)
//
//  Created by cuan on 14-2-13.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"

@interface RootViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (retain, nonatomic) UITableView *tableView;
@property (retain, nonatomic) NSMutableDictionary *dataSource;
@property (retain, nonatomic) NSMutableArray *keys;
@property (retain, nonatomic) UISearchDisplayController *serachDisplayController;
@property (retain, nonatomic) NSMutableArray *searchDataSource;

- (void)initDataSource;
- (void)loadBasicView;
- (void)loadSerach;

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"Font List";
    }
    return self;
}

- (void)dealloc
{
    [_tableView release];
    [_dataSource release];
    [_keys release];
    [_serachDisplayController release];
    [_searchDataSource release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initDataSource];
    [self loadBasicView];
    [self loadSerach];
}

- (void)initDataSource
{
    _dataSource = [[NSMutableDictionary alloc] init];
    _keys = [[NSMutableArray alloc] init];
    NSMutableArray *otherList = [NSMutableArray array];
    NSArray *fonts = [UIFont familyNames];
    for (NSString *font in fonts) {
        char charactor = [font characterAtIndex:0];
        // 判断其他类型
        if (charactor < 'A' || charactor > 'z' || (charactor > 'Z' && charactor < 'a')) {
            [otherList addObject:font];
            continue;
        }
        
        // 小写转大写
        if (charactor >= 'a' && charactor <= 'z') {
            charactor -= 32;
        }
        
        // 添加字体到指定数组
        NSString *key = [NSString stringWithFormat:@"%c" ,charactor];
        NSMutableArray *fontsList = [NSMutableArray arrayWithArray:[_dataSource objectForKey:key]];
        [fontsList addObject:font];
        [_dataSource setObject:fontsList forKey:key];
    }
    
    if ([otherList count] > 0) {
        [_dataSource setObject:otherList forKey:@"#"];
    }
    
    [_keys addObjectsFromArray:[_dataSource allKeys]];
    
    [_keys sortUsingSelector:@selector(caseInsensitiveCompare:)];
    if ([_keys containsObject:@"#"]) {
        [_keys removeObject:@"#"];
        [_keys addObject:@"#"];
    }
}

- (void)loadBasicView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.bounces = NO;
    // 索引字体颜色
    _tableView.sectionIndexColor = [UIColor colorWithRed:0.000 green:0.618 blue:0.000 alpha:1.000];
    // 索引背景颜色
    _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    // 索引背景高亮颜色
    _tableView.sectionIndexTrackingBackgroundColor = [UIColor colorWithWhite:0.818 alpha:1.000];
    [self.view addSubview:_tableView];
}

- (void)loadSerach
{
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_tableView.frame), 44)];
    tableHeaderView.backgroundColor = [UIColor grayColor];
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:tableHeaderView.frame];
    searchBar.delegate = self;
    searchBar.searchBarStyle = UISearchBarStyleDefault;
    searchBar.placeholder = @"Search";
    searchBar.tintColor = [UIColor whiteColor];
    searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    [tableHeaderView addSubview:searchBar];
    [searchBar release];
    
    // search关联tableView
    _tableView.tableHeaderView = tableHeaderView;
    [tableHeaderView release];
    
    _serachDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    _serachDisplayController.searchResultsDataSource = self;
    _serachDisplayController.searchResultsDelegate = self;
}

#pragma mark - <UITableViewDataSource>数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_tableView == tableView) {
        return _keys.count;
    }
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tableView) {
         return [[_dataSource objectForKey:_keys[section]] count];
    }
    
    return _searchDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 声明cell重用标志
    static NSString *cellIdentifier = @"Cell";
    // cell重用标识从tableView重用队列获取指定类型cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    // 若该类型的cell不存在，新建一个对应的类型
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:cellIdentifier] autorelease];
    }
    
    if (_tableView == tableView) {
        cell.textLabel.text = [_dataSource objectForKey:_keys[indexPath.section]][indexPath.row];
    } else {
        cell.textLabel.text = _searchDataSource[indexPath.row];
    }
 
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == _tableView) {
        return _keys[section];
    }
    
    return nil;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == _tableView) {
        return _keys;
    }
    
    return nil;
}

#pragma mark - <UITableViewDelegate>代理方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *title = nil;
    if (_tableView == tableView) {
        title = [_dataSource objectForKey:_keys[indexPath.section]][indexPath.row];
    } else {
        title = _searchDataSource[indexPath.row];
    }
    DetailViewController *detailVC = [[DetailViewController alloc]
                                      initWithTitle:title];
    [self.navigationController pushViewController:detailVC animated:YES];
    [detailVC release];
}

#pragma mark - <UITableViewDelegate>代理方法

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (!_searchDataSource) {
        _searchDataSource = [[NSMutableArray alloc] init];
    }
    [_searchDataSource removeAllObjects];
    
    // 过滤搜索结果
    NSMutableArray *searchResult = [[UIFont familyNames] mutableCopy];
    for (NSString *font in searchResult) {
        if ([font rangeOfString:searchText].location != NSNotFound) {
            [_searchDataSource addObject:font];;
        }
    }
    [_searchDataSource sortUsingSelector:@selector(caseInsensitiveCompare:)];
    NSLog(@"_searchDataSource = %@", _searchDataSource);
}

@end
