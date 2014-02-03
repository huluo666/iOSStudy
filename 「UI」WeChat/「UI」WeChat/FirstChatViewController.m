//
//  FirstChatViewController.m
//  「UI」WeChat
//
//  Created by cuan on 14-2-1.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "FirstChatViewController.h"
#import "WeChatTabBarViewController.h"

@interface FirstChatViewController ()

@end

@implementation FirstChatViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    
//    NSArray *fonts = [UIFont familyNames];
//    NSLog(@"%@", fonts);
 
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    WeChatTabBarViewController *tabBarViewController = (WeChatTabBarViewController *)self.tabBarController;
    [tabBarViewController hiddenTabBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
