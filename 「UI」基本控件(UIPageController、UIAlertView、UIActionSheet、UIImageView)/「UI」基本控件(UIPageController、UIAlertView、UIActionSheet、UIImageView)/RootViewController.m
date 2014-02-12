//
//  RootViewController.m
//  「UI」基本控件(UIPageController、UIAlertView、UIActionSheet、UIImageView)
//
//  Created by cuan on 14-1-31.
//  Copyright (c) 2014年 cuan. All rights reserved.
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
#pragma mark 分页控件
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    [pageControl setBounds:CGRectMake(0, 0, 320, 40)];
    [pageControl setCenter:CGPointMake(160, 50)];
    [pageControl setBackgroundColor:[UIColor grayColor]];
    pageControl.numberOfPages = 10;
    pageControl.currentPage = 2;
//    pageControl.enabled = NO;
//    pageControl.hidesForSinglePage = YES;
    [pageControl addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:pageControl];
    [pageControl release];
 
#pragma mark 警告视图
    // AlertView
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftButton.bounds = CGRectMake(0, 0, 140, 40);
    leftButton.center = CGPointMake(CGRectGetMidX(self.view.frame) / 2, 50 + 20 + 40);
    leftButton.tag = 101;
    [leftButton setTitle:@"左边按钮" forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(showAlertView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];

    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    rightButton.bounds = CGRectMake(0, 0, 140, 40);
    rightButton.center = CGPointMake(CGRectGetMidX(self.view.frame) / 2 * 3, 50 + 20 + 40);
    rightButton.tag = 102;
    [rightButton setTitle:@"右边按钮" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(showAlertView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
 
    // ActionSheet
    UIButton *centerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    centerButton.bounds = CGRectMake(0, 0, 140, 40);
    centerButton.center = CGPointMake(CGRectGetMidX(self.view.frame), 50 + 20 + 40 + 40);
    centerButton.tag = 103;
    [centerButton setTitle:@"中间按钮" forState:UIControlStateNormal];
    [centerButton addTarget:self action:@selector(showActionView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:centerButton];
    
}

- (void)showActionView
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"销毁" otherButtonTitles:@"其他", nil];
    [actionSheet showInView:self.view];
    [actionSheet release];
}

- (void)showAlertView:(UIButton *)sender
{
    if (101 == sender.tag)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名或者密码错误" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的操作有误" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:@"取消操作", @"发送错误信息", nil];
        [alertView show];
        [alertView release];
    }
}

- (void)valueChanged:(UIPageControl *)sender
{
    NSLog(@"UIPageControl");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark <UIAlertViewDelegate>

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%d", buttonIndex);
}

@end
