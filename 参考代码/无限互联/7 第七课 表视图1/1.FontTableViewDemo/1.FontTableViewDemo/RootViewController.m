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
    _tableView.dataSource = self; // 设置数据源
    // 实现数据源方法
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 定义一个静态标识符
    static NSString *cellIdentifier = @"cell";
    // 检查是否限制单元格
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    // 创建单元格
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    NSLog(@"indexPath : %d", indexPath.row);
    // 给cell内容赋值
    NSString *fontName = _listArray[indexPath.row];
    cell.textLabel.text = fontName;
    cell.textLabel.font = [UIFont fontWithName:fontName size:14];

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
