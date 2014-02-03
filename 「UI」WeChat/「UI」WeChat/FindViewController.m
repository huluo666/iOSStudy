//
//  FindViewController.m
//  「UI」WeChat
//
//  Created by cuan on 14-2-1.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "FindViewController.h"
#import "FindSubViewController.h"
#import "FindDataSource.h"

@interface FindViewController ()

@property (retain, nonatomic) FindDataSource *dataSource;

@end

@implementation FindViewController

- (void)dealloc
{
    [_dataSource release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        _dataSource = [[FindDataSource alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    /*
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *pushButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    pushButton.bounds = CGRectMake(0, 0, 320, 40);
    pushButton.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMinY(self.view.frame) + 20 + 44 + 35 + 20 + 5);
    [pushButton setTitle:@"PUSH" forState:UIControlStateNormal];
    pushButton.layer.borderWidth = 1.0f;
    pushButton.layer.borderColor = [UIColor colorWithWhite:0.721 alpha:1.000].CGColor;
    [pushButton addTarget:self action:@selector(pushVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushButton];
    */
     
    [self initTableView];
    
}

- (void)initTableView
{
#pragma mark 如何让UITaleView视图自动适应内容所占空间大小？
    CGRect frame;
    frame.origin = CGPointMake(0, 35);
//    frame.size = self.view.frame.size;
    frame.size = CGSizeMake(320, 375);
    UITableView *findTableView = [[UITableView alloc] initWithFrame:frame
                                                              style:UITableViewStylePlain];
    // 设置(数据源里面的)数据
#pragma mark 由于界面是固定的，不需要加载动态数据，所以直接给值，动态加载方式参考ContactsViewController.m
    self.dataSource.allTables = @[@"朋友圈", @"扫一扫", @"摇一摇", @"附近的人", @"游戏", @"表情商店"];
    // 关联数据源
    // @property (nonatomic, assign)   id <UITableViewDataSource> dataSource;
    findTableView.dataSource = self.dataSource;
    [self.view addSubview:findTableView];
    [findTableView release];
}

- (void)pushVC:(UIButton *)sender
{
    FindSubViewController *findSubVC = [[FindSubViewController alloc] init];
    [self.navigationController pushViewController:findSubVC animated:YES];
    [findSubVC release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
