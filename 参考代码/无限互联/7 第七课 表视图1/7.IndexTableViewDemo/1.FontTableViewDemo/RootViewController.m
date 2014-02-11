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
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ListData" ofType:@"plist"];
    _dataDic = [[NSDictionary dictionaryWithContentsOfFile:path] retain];
    
    NSArray *keyArray = [NSArray arrayWithArray:[_dataDic allKeys]];
    
    // 排序
    _keyArray = [[keyArray sortedArrayUsingSelector:@selector(compare:)] retain];
    
    _tableView = [[UITableView alloc] initWithFrame:view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self; // 设置数据源
    _tableView.delegate   = self; // 设置委托
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
    return [_keyArray count];
} // 表视图当中存在secion的个数，默认是1个

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    NSArray *data = [_dataDic objectForKey:[_keyArray objectAtIndex:section]];
    return [data count];
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
    // 给cell内容赋值
    
    NSArray *data = [_dataDic objectForKey:[_keyArray objectAtIndex:indexPath.section]];
    NSString *fontName = [data objectAtIndex:indexPath.row];
    cell.textLabel.text = fontName;
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    
    return cell;
    
} // 创建单元格

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _keyArray[section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _keyArray;
} // 返回索引的内容

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSLog(@"index : %d title : %@", index, title);
    return index;
} // 选中时，跳转表视图

#pragma mark - UITableViewDelegate
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //  NSIndexPath -> max row  取消上一次选中
    NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:_index inSection:0];
    UITableViewCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
    lastCell.accessoryType = UITableViewCellAccessoryNone;
    // 用户选中了新的一行
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    _index = indexPath.row;

    [_tableView performSelector:@selector(deselectRowAtIndexPath:animated:) withObject:indexPath afterDelay:.5];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didDeselectRowAtIndexPath : %d", indexPath.row);
}
*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)dealloc
{
    [_tableView release];
    _tableView = nil;
    [super dealloc];
}

@end
