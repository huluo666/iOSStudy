//
//  DDHomeViewController.m
//  面试职通车
//
//  Created by 萧川 on 14-4-16.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDHomeViewController.h"
#import "DDInterviewScheduleViewController.h"

@interface DDHomeViewController () <UIViewControllerTransitioningDelegate>

@end

@implementation DDHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"面试职通车";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 100, 40);
    button.backgroundColor = [UIColor redColor];
    button.center = self.view.center;
    [button setTitle:@"tap" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonAction {
    
    DDInterviewScheduleViewController *schedule = [[DDInterviewScheduleViewController alloc] init];
    [self.navigationController pushViewController:schedule animated:YES];
}

@end
