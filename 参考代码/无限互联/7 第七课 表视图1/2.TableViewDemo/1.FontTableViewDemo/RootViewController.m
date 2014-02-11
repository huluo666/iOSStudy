//
//  RootViewController.m
//  1.FontTableViewDemo
//
//  Created by 周泉 on 13-2-24.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G开发培训中心. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view = view;
    [view release];
    
    _listArray = [[UIFont familyNames] retain];
    
    _tableView = [[UITableView alloc] initWithFrame:view.bounds style:UITableViewStylePlain];
    // 设置数据源
    _tableView.dataSource = self;
    // 设置表视图cell的高度，统一的高度
    _tableView.rowHeight = 70;    // 44px
    // 设置表视图的背景
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IMG_0410"]];
    _tableView.backgroundView = backgroundView;
    [backgroundView release];
    // 设置表视图的颜色
//    _tableView.backgroundColor = [UIColor yellowColor];
    // 设置表视图的分割线的颜色
//    _tableView.separatorColor = [UIColor purpleColor];
    // 设置表视图的分割线的风格
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    // 设置表视图的头部视图(headView 添加子视图)
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    headerView.backgroundColor = [UIColor redColor];
    // 添加子视图
    UILabel *headText = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 200, 80)];
    headText.text = @"天晴朗,天晴朗天晴朗天晴朗!";
    headText.numberOfLines = 0;
    [headerView addSubview:headText];
    [headText release];
    _tableView.tableHeaderView = headerView;
    [headerView release];
    // 设置表视图的尾部视图(footerView 添加子视图)    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    footerView.backgroundColor = [UIColor yellowColor];
    _tableView.tableFooterView = footerView;
    [footerView release];
    
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [_listArray count];
} // section 中包含row的数量

// indexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    // 指向其中一行
    NSLog(@"indexPath row: %d", indexPath.row);
    NSLog(@"indexPath section: %d", indexPath.section);
//    cell.textLabel.text = [self.listArray objectAtIndex:indexPath.row];
    NSString *fontName = _listArray[indexPath.row];
    cell.textLabel.text = fontName;
    cell.textLabel.textColor = [UIColor redColor];
    cell.textLabel.font = [UIFont fontWithName:fontName size:18];
    
    
    return cell;
    
} // 创建单元格

/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
} // 表视图当中存在secion的个数，默认是1个
 */

- (void)dealloc
{
    [_tableView release];
    _tableView = nil;
    [super dealloc];
}

@end
