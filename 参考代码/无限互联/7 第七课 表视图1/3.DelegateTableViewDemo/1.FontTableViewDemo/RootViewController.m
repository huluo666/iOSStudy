//
//  RootViewController.m
//  1.FontTableViewDemo
//
//  Created by 周泉 on 13-2-24.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G开发培训中心. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"UITablView sytle";
    }
    return self;
}

- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view = view;
    [view release];
    
    _listArray = [@[@"UITableViewStylePlain", @"UITableViewStyleGrouped"] retain];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, kDeviceHeight-20-44) style:UITableViewStylePlain];
    // 设置数据源
    _tableView.dataSource = self;
    // 设置代理方法
    _tableView.delegate = self;
        
    [self.view addSubview:_tableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
} // 表视图当中存在secion的个数，默认是1个

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [_listArray count]; // 2 rows
} // section 中包含row的数量

// indexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }

    NSString *text = _listArray[indexPath.row];
    cell.textLabel.text = text;
    
    
    return cell;
    
} // 创建单元格

#pragma TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    detailVC.isPlain = indexPath.row ? NO : YES;
    [self.navigationController pushViewController:detailVC animated:YES];
    [detailVC release];
} // 当用户选择某一行时

- (void)dealloc
{
    [_tableView release];
    _tableView = nil;
    [super dealloc];
}

@end
