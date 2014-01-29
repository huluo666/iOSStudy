//
//  DetailViewController.m
//  「UI」UINavigationController
//
//  Created by cuan on 14-1-29.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailNextViewController.h"

@interface DetailViewController ()

- (void)initializationUserInterface;
- (void)buttonClicked:(UIControl *)sender;

@end

@implementation DetailViewController

- (void)dealloc
{
    [_currentTitle release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializationUserInterface];
}

- (void)initializationUserInterface
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *clickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    clickButton.bounds = CGRectMake(0, 0, 300, 40);
    clickButton.tag = 100;
    clickButton.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMinY(self.view.bounds) + 80);
    [clickButton setTitle:@"有种你点我试试                             >" forState:UIControlStateNormal];
    [clickButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [clickButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [clickButton setContentEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
//    clickButton.layer.borderWidth = 1;
//    clickButton.layer.borderColor = [UIColor greenColor].CGColor;
    [clickButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    clickButton.backgroundColor = [UIColor colorWithWhite:0.873 alpha:1.000];
    [self.view addSubview:clickButton];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    backButton.bounds = CGRectMake(0, 0, 320, 40);
    backButton.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMaxY(clickButton.frame) + 20);
    backButton.tag = 101;
    [backButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    
    backButton.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:backButton];
    
    [self.navigationItem setTitle:@"DetailViewController"];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(buttonClicked:)];
    self.navigationItem.rightBarButtonItem  = rightItem;
    [rightItem release];
    
#pragma mark UINavigationController的正向和反向传值
    
    /*
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button1.bounds = CGRectMake(0, 0, 320, 40);
    button1.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMaxY(backButton.frame) + 40);
    button1.backgroundColor = [UIColor grayColor];
    [button1 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTitle:@"按钮一" forState:UIControlStateNormal];
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button2.bounds = CGRectMake(0, 0, 320, 40);
    button2.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMaxY(button1.frame) + 40);
    button2.backgroundColor = [UIColor grayColor];
    [button2 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button2 setTitle:@"按钮二" forState:UIControlStateNormal];
    [self.view addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button3.bounds = CGRectMake(0, 0, 320, 40);
    button3.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMaxY(button2.frame) + 40);
    button3.backgroundColor = [UIColor grayColor];
    [button3 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button3 setTitle:@"按钮三" forState:UIControlStateNormal];
    [self.view addSubview:button3];
    */
    
    NSArray *buttonTitles = [NSArray arrayWithObjects:@"反向传值按钮一", @"反向传值按钮二", @"反向传值按钮三", nil];
    for (int i = 0 ; i < buttonTitles.count; i++)
    {
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button1.bounds = CGRectMake(0, 0, 300, 40);
        NSArray *array = self.view.subviews;
        UIButton *lastButton = array[array.count - 1];
        button1.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMaxY(lastButton.frame) + 40);
//        button1.backgroundColor = [UIColor grayColor];
        [button1 addTarget:self action:@selector(titleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button1 setTitle:buttonTitles[i] forState:UIControlStateNormal];
        button1.layer.borderWidth = 1.0f;
        button1.layer.borderColor = [UIColor greenColor].CGColor;
        
        // 正向传值
        if ([_currentTitle isEqualToString:button1.currentTitle])
        {
            button1.selected = YES;
        }
        [button1 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [self.view addSubview:button1];
    }
    
}

- (void)titleButtonClicked:(UIButton *)btn
{
    NSString *title = btn.currentTitle;
    if ([_delegate respondsToSelector:@selector(sendButtonTitle:)])
    {
        [_delegate sendButtonTitle:title];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)buttonClicked:(UIControl *)sender
{
    if (100 == sender.tag)
    {
        DetailNextViewController *detailNextViewController = [[DetailNextViewController alloc] init];
        [self.navigationController pushViewController:detailNextViewController animated:YES];
        [detailNextViewController release];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

@end
