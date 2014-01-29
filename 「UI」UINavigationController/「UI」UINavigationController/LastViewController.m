//
//  LastViewController.m
//  「UI」UINavigationController
//
//  Created by cuan on 14-1-29.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "LastViewController.h"

@interface LastViewController ()

- (void)buttonClicked:(UIButton *)sender;

@end

@implementation LastViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor purpleColor];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    backButton.bounds = CGRectMake(0, 0, 300, 40);
    backButton.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMinY(self.view.bounds) + 90);
    backButton.tag = 101;
    [backButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitle:@"pop到DetailViewController" forState:UIControlStateNormal];
    
    [self.view addSubview:backButton];
    
    [self.navigationItem setTitle:@"LastViewController"];

}

- (void)buttonClicked:(UIButton *)sender
{
    // 跳转到指定的视图控制器
    NSArray *viewControllers = self.navigationController.viewControllers;
    [self.navigationController popToViewController:viewControllers[1] animated:YES];
}

@end
