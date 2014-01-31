//
//  AccountSettingViewController.m
//  「UI」TabBar、Navi联合
//
//  Created by cuan on 14-1-31.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "AccountSettingViewController.h"

@interface AccountSettingViewController ()

@end

@implementation AccountSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
