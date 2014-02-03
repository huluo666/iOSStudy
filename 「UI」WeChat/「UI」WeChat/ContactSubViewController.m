//
//  SubContactViewController.m
//  「UI」WeChat
//
//  Created by cuan on 14-2-2.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "ContactSubViewController.h"
#import "WeChatTabBarViewController.h"

@interface ContactSubViewController ()

@end

@implementation ContactSubViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    WeChatTabBarViewController *tabBarViewController = (WeChatTabBarViewController *)self.tabBarController;
    [tabBarViewController hiddenTabBar];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor grayColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
