//
//  RootViewController.m
//  1.ScrollViewPropertyDemo
//
//  Created by 周泉 on 13-2-28.
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
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 250)];
    scrollView.backgroundColor = [UIColor redColor];
    // 设置内容大小
    scrollView.contentSize = CGSizeMake(320*5, 300*5);
    // 是否反弹
//    scrollView.bounces = NO;
    // 是否分页
//    scrollView.pagingEnabled = YES;
    // 是否滚动
//    scrollView.scrollEnabled = NO;
//    scrollView.showsHorizontalScrollIndicator = NO;
    // 设置indicator风格
//    scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    // 设置内容的边缘和Indicators边缘
//    scrollView.contentInset = UIEdgeInsetsMake(0, 50, 50, 0);
//    scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 50, 0, 0);
    // 提示用户,Indicators flash
    [scrollView flashScrollIndicators];
    // 是否同时运动,lock
    scrollView.directionalLockEnabled = YES;
    
    [self.view addSubview:scrollView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(320, 200, 320, 40)];
    label.backgroundColor = [UIColor yellowColor];
    label.text = @"学习scrolleview";
    [scrollView addSubview:label];
    [label release];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(320/2-140/2, 350, 140, 40)];
    [button addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)test
{
    [scrollView setContentOffset:CGPointMake(320, 0) animated:YES];
    [scrollView scrollRectToVisible:CGRectMake(320, 0, 320, 300) animated:YES];
}

- (void)dealloc
{
    [scrollView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
