//
//  DDTestViewController.m
//  「UI」下拉刷新上拉加载
//
//  Created by 萧川 on 14-2-27.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDTestViewController.h"
#import "DDPullDown.h"

@interface DDTestViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_dataSource;
}

@end

@implementation DDTestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _dataSource = [NSMutableArray array];
        for (int i = 0; i < 5; i++) {
            [_dataSource addObject:[NSString stringWithFormat:@"随机数据：%d",arc4random() % 9999]];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
	self.view.backgroundColor = [UIColor whiteColor];
    DDPullDown *pullDown = [DDPullDown pullDown];
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
//    pullDown.scrollView = tableView;
    [pullDown setScrollView:tableView];
    [tableView release];

}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    // 若该类型的cell不存在，新建一个对应的类型
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:cellIdentifier] autorelease];
        cell.textLabel.text = _dataSource[indexPath.row];
    }
    
    return cell;
}

#pragma mark - <UITableViewDelegate>


@end
