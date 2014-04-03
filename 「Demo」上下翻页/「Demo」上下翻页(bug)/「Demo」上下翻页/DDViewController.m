//
//  DDViewController.m
//  「Demo」上下翻页
//
//  Created by 萧川 on 14-4-1.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDViewController.h"
#import "PBExampleViewController.h"

@interface DDViewController ()

@end

@implementation DDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	PBExampleViewController *VC = [[PBExampleViewController alloc] init];
    [self addChildViewController:VC];
    [self.view addSubview:VC.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
