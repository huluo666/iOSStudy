//
//  DetailViewController.m
//  1.FontTableViewDemo
//
//  Created by 周泉 on 13-2-24.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G开发培训中心. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

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
    
    NSArray *array = [UIFont familyNames];
    _fontsArray = [[NSMutableArray alloc] initWithCapacity:13];
    NSMutableArray *temp = nil;
    for (int index = 0; index < [array count]; index++) {
        
        // 取出字体内容
        NSString *font = array[index];
        
        if (index % 5 == 0) {
            
            temp = [[NSMutableArray alloc] initWithCapacity:5];
            [_fontsArray addObject:temp];
            [temp release];
        } // 将5整除时，创建temp数组，添加到_fontsArray
        [temp addObject:font];
    }
    
    UITableViewStyle style = self.isPlain ? UITableViewStylePlain : UITableViewStyleGrouped; 
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, kDeviceHeight-20-44) style:style];
    // 设置数据源
    _tableView.dataSource = self;
    // 设置代理方法
    _tableView.delegate = self;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    headerView.backgroundColor = [UIColor redColor];
    // 添加子视图
    UILabel *headText = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 200, 80)];
    headText.backgroundColor = [UIColor clearColor];
    headText.text = @"秋高气爽";
    headText.textAlignment = NSTextAlignmentCenter;
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

#pragma mark - UITablView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_fontsArray count]; // 13
} // 表视图当中存在secion的个数，默认是1个

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    NSLog(@"secion : %d", section);
    return [_fontsArray[section] count]; // 5
} // section 中包含row的数量

// indexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSLog(@"indexPath : %@", indexPath);
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [[_fontsArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    return cell;
    
} // 创建单元格

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = [NSString stringWithFormat:@"header 第%d个section", section+1];
    return title;
} // 设置section header 的title

/*
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    NSString *title = [NSString stringWithFormat:@"footer 第%d个section", section+1];
    return title;
}*/ // 设置section footer 的title

#pragma mark - TableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 && indexPath.section == 2) {
        return 80; // 第三个section中第一行
    }return 44;
} // 设置行高

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 44;
    }return 25;
} // 设置section header的高度


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 12) {
        return 80;
    }return 50;
} // 设置section footer的高度

/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
    headerView.backgroundColor = [UIColor cyanColor];
    return [headerView autorelease];
}*/ // 设置section自定义头部视图


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectZero];
    footerView.backgroundColor = [UIColor cyanColor];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 200, 30)];
    tipLabel.numberOfLines = 0;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.text = [NSString stringWithFormat:@"section footer %d", section+1];
    [footerView addSubview:tipLabel];
    [tipLabel release];
    
    return [footerView autorelease];
} // 设置section自定义尾部视图

- (void)dealloc
{
    [_tableView release], _fontsArray = nil;
    [_fontsArray release], _fontsArray = nil;
    [super dealloc];
}

@end
