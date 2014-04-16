//
//  DDInterviewScheduleViewController.m
//  面试职通车
//
//  Created by 萧川 on 14-4-16.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDInterviewScheduleViewController.h"
#import "DDMoreOptionsViewController.h"

@interface DDInterviewScheduleViewController ()

@end

@implementation DDInterviewScheduleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"面试日程";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 100, 40);
    button.center = self.view.center;
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"tap" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonAction {

    DDMoreOptionsViewController *more = [[DDMoreOptionsViewController alloc] init];
    [self.navigationController pushViewController:more animated:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
