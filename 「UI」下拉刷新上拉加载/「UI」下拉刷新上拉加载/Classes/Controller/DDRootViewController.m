//
//  DDRootViewController.m
//  「UI」下拉刷新下拉加载
//
//  Created by 萧川 on 14-2-25.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

static NSString *CellIdentifier = @"Cell";

#import "DDRootViewController.h"

@interface DDRootViewController ()
{
    NSMutableArray *_dataSource; // 数据源
}

// 初始化数据
- (void)initDataSource;
// 初始化用户界面
- (void)initUserInterface;
// 加载头部视图
- (void)loadHeaderView;
// 加载尾部视图
- (void)loadFooterView;

@end

@implementation DDRootViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"表视图展示";
    }
    return self;
}

- (void)dealloc
{
    [_dataSource release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    [self initDataSource];
    [self initUserInterface];
}

#pragma mark - 私有方法

- (void)initDataSource
{
    _dataSource = [[NSMutableArray alloc] init];
    for (int i = 0; i < 12; i++) {
        [_dataSource addObject:[NSString stringWithFormat:@"测试数据编号：%d", arc4random() % 99999]];
    }
}

- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 注册重用cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    // 载入头部视图
    [self loadHeaderView];
    
    // 载入尾部视图
    [self loadFooterView];
}

- (void)loadHeaderView
{

}

- (void)loadFooterView
{

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
