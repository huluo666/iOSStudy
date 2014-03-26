//
//  ViewController1.m
//  「UI」UITabBarController
//
//  Created by cuan on 14-1-30.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "ViewController1.h"
#import "TB1ViewController.h"

@implementation ViewController1

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    UIButton *pushButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    pushButton.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMinY(self.view.frame) + 94);
    pushButton.bounds = CGRectMake(0, 0, 300, 40);
    [pushButton setTitle:@"PUSH" forState:UIControlStateNormal];
    pushButton.layer.borderWidth = 1.0f;
    pushButton.layer.borderColor = [UIColor greenColor].CGColor;
    [pushButton addTarget:self action:@selector(pushButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushButton];
    
    // 隐藏标签栏 method two
    NSLog(@"---%@", self.view.subviews);
    NSLog(@"===%@", self.view);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    // 恢复隐藏的标签栏
    NSArray *views = self.tabBarController.view.subviews;
    UIView *tabBar = views[views.count - 1];
    [UIView animateWithDuration:0.35f animations:^{
        tabBar.frame = CGRectMake(0, 519, 320, 49);
    }];
}

- (void)pushButtonPressed
{
    TB1ViewController *tb1v = [[TB1ViewController alloc] init];
    [self.navigationController pushViewController:tb1v animated:YES];
    [tb1v release];
}

@end
