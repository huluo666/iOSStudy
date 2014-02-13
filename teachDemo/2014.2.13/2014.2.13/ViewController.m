//
//  ViewController.m
//  2014.2.13
//
//  Created by 张鹏 on 14-2-13.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate> {
    
    UITableView *_tableView;
    NSMutableDictionary *_dataSource;
    NSMutableArray *_keys;
    
    UISearchDisplayController *_searchDisplayController;
    NSMutableArray *_searchDataSource;
}

- (void)initializeDataSource;
- (void)initializeUserInterface;
// 初始化搜索功能
- (void)initializeSearch;

@end

@implementation ViewController

- (id)init
{
    self = [super init];
    if (self) {
        
        self.title = @"Font List";
        
    }
    return self;
}

- (void)dealloc {
    
    [_tableView  release];
    [_dataSource release];
    [_keys       release];
    [_searchDisplayController release];
    [_searchDataSource release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)initializeDataSource {
    
    _dataSource = [[NSMutableDictionary alloc] init];
    _keys = [[NSMutableArray alloc] init];
    
    // 获取系统字体列表，并排序，caseInsensitiveCompare:不区分大小写比较
    NSArray *fonts = [UIFont familyNames];
    // 其它类别数组
    NSMutableArray *otherList = [NSMutableArray array];
    for (NSString *font in fonts) {
        // 截取首字母
//        char charactor = [font UTF8String][0];
        char charactor = [font characterAtIndex:0];
        
        // 判断其它类型
        if (charactor < 'A' || charactor > 'z' || (charactor > 'Z' && charactor < 'a')) {
            [otherList addObject:font];
            continue;
        }
        
        // 小写转大写
        if (charactor >= 'a' && charactor <= 'z') {
            charactor -= 32;
        }
        
        // 添加字体到指定数组
        NSString *key = [NSString stringWithFormat:@"%c", charactor];
        NSMutableArray *fontsList = [NSMutableArray arrayWithArray:[_dataSource objectForKey:key]];
        [fontsList addObject:font];
        [_dataSource setObject:fontsList forKey:key];
    }
    
    // 判断是否存在其它类型数据
    if ([otherList count] > 0) {
        [_dataSource setObject:otherList forKey:@"#"];
    }
    
    [_keys addObjectsFromArray:[_dataSource allKeys]];
    [_keys sortUsingSelector:@selector(caseInsensitiveCompare:)];
    if ([_keys containsObject:@"#"]) {
        [_keys removeObject:@"#"];
        [_keys addObject:@"#"];
    }
    NSLog(@"%@", _dataSource);
}

- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                              style:UITableViewStylePlain];
    // 配置数据源对象
    _tableView.dataSource = self;
    // 配置委托对象
    _tableView.delegate = self;
    // 配置边列索引字体颜色
    _tableView.sectionIndexColor = [UIColor redColor];
    // 配置边列索引背景色
    _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    // 配置边列索引背景高亮色
//    _tableView.sectionIndexTrackingBackgroundColor = [UIColor greenColor];
    [self.view addSubview:_tableView];
    
    // 初始化搜索功能
    [self initializeSearch];
}

- (void)initializeSearch {
    
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_tableView.bounds), 44)];
    tableHeaderView.backgroundColor = [UIColor grayColor];
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:tableHeaderView.bounds];
    // 配置委托对象
    searchBar.delegate = self;
    // 配置显示类型
    searchBar.searchBarStyle = UISearchBarStyleDefault;
    // 配置占位符
    searchBar.placeholder = @"Search";
    searchBar.tintColor = [UIColor redColor];
    searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    [tableHeaderView addSubview:searchBar];
    [searchBar release];
    
    // searbar关联tableview
    _tableView.tableHeaderView = tableHeaderView;
    [tableHeaderView release];
    
    _searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar
                                                                 contentsController:self];
    _searchDisplayController.searchResultsDelegate = self;
    _searchDisplayController.searchResultsDataSource = self;
}

#pragma mark - <UITableViewDataSource>

// section个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (tableView == _tableView) {
        return [_keys count];
    }
    else {
        return 1;
    }
}

// 指定setion的rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == _tableView) {
        return [[_dataSource objectForKey:_keys[section]] count];
    }
    else {
        return [_searchDataSource count];
    }
}

// 每一行如何显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 声明cell重用标识，static：静态变量，局部静态变量，生命周期与程序相同
    static NSString *cellIdentifier = @"Cell";
    // cell重用标识从tableview重用队列获取指定类型cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    // 若该类型的cell不存在，则新建一个对应类型的
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:cellIdentifier] autorelease];
    }
    // 根据不同的indexpath配置cell显示的内容
    NSString *fontName = nil;
    if (tableView == _tableView) {
        NSString *key = _keys[indexPath.section];
        NSArray *fonts = [_dataSource objectForKey:key];
        fontName = fonts[indexPath.row];
    }
    else {
        fontName = _searchDataSource[indexPath.row];
    }
    
    cell.textLabel.text = fontName;
    
    return cell;
}

// 配置section的header标题文字
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (tableView == _tableView) {
        return _keys[section];
    }
    else {
        return nil;
    }
}

// 配置表视图边列索引标题
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    if (tableView == _tableView) {
        return _keys;
    }
    else {
        return nil;
    }
}

#pragma mark - <UITableViewDelegate>

// 选中指定indexpath索引路径下的单元行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"did select row at section:%d row:%d.", indexPath.section, indexPath.row);
    
    // 取消指定单元行的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *fontName = nil;
    if (tableView == _tableView) {
        NSString *key = _keys[indexPath.section];
        NSArray *fonts = [_dataSource objectForKey:key];
        fontName = fonts[indexPath.row];
    }
    else {
        fontName = _searchDataSource[indexPath.row];
    }
    DetailViewController *detailVC = [[DetailViewController alloc] initWithFontName:fontName];
    [self.navigationController pushViewController:detailVC animated:YES];
    [detailVC release];
}

#pragma mark - <UISearchBarDelegate>

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    NSLog(@"%@", searchText);
    
    if (!_searchDataSource) {
        _searchDataSource = [[NSMutableArray alloc] init];
    }
    [_searchDataSource removeAllObjects];
    
    // 过滤字体
    NSMutableArray *fonts = [NSMutableArray arrayWithArray:[UIFont familyNames]];
    [fonts sortUsingSelector:@selector(caseInsensitiveCompare:)];
    for (NSString *font in fonts) {
        if ([font rangeOfString:searchText].location != NSNotFound) {
            [_searchDataSource addObject:font];
        }
    }
    NSLog(@"%@", _searchDataSource);
}


@end























