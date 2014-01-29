//
//  DetailNextViewController.m
//  「UI」UINavigationController
//
//  Created by cuan on 14-1-29.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "DetailNextViewController.h"
#import "LastViewController.h"

@interface DetailNextViewController ()

- (void)initializationUserInterface;
- (void)buttonClicked:(UIButton *)sender;

@end


@implementation DetailNextViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializationUserInterface];
}

- (void)initializationUserInterface
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeSystem];
    nextButton.bounds = CGRectMake(0, 0, 300, 30);
    nextButton.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMinY(self.view.bounds) + 80);
    [nextButton setTitle:@"下一页" forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    
    [self.navigationItem setTitle:@"DetailNextViewControllerDetailNextViewController"];
}

- (void)buttonClicked:(UIButton *)sender
{
    LastViewController *lastViewController = [[LastViewController alloc] init];
    [self.navigationController pushViewController:lastViewController animated:YES];
    [lastViewController release];
}

@end
