//
//  SettingViewController.m
//  「UI」TabBar、Navi联合
//
//  Created by cuan on 14-1-31.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "SettingViewController.h"
#import "AccountSettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

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
    
    self.navigationItem.title = @"设置";
    
    self.clearsSelectionOnViewWillAppear = YES;
    
    NSLog(@"%@", self.view);
    
    UIButton *accountButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [accountButton setCenter:CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMinY(self.view.frame) + 2)];
    [accountButton setBounds:CGRectMake(0, 0, 320, 44)];
    [accountButton setTitle:@"帐号设置                                                 >" forState:UIControlStateNormal];
//    [accountButton setTitle:@"帐号设置" forState:UIControlStateHighlighted];
//    [accountButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
//    [accountButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [accountButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [accountButton setContentEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    [accountButton addTarget:self action:@selector(pushButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:accountButton];
    
    UIButton *messageButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [messageButton setCenter:CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMaxY(accountButton.frame) + 22)];
    [messageButton setBounds:CGRectMake(0, 0, 320, 44)];
    [messageButton setTitle:@"消息设置                                                 >" forState:UIControlStateNormal];
    [messageButton setBackgroundImage:[UIImage imageNamed:@"background"] forState:UIControlStateHighlighted];
    [messageButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [messageButton setContentEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    [self.view addSubview:messageButton];

    
    UIButton *privaceButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [privaceButton setCenter:CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMaxY(messageButton.frame) + 22)];
    [privaceButton setBounds:CGRectMake(0, 0, 320, 44)];
    [privaceButton setTitle:@"隐身设置                                                 >" forState:UIControlStateNormal];
    [privaceButton setBackgroundImage:[UIImage imageNamed:@"background"] forState:UIControlStateHighlighted];
    [privaceButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [privaceButton setContentEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    [self.view addSubview:privaceButton];

    UILabel *label = [[UILabel alloc] init];
    [label setBackgroundColor:[UIColor colorWithWhite:0.963 alpha:1.000]];
    [label setCenter:CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMaxY(privaceButton.frame) + 22)];
    [label setBounds:CGRectMake(0, 0, 320, 42)];
    [self.view addSubview:label];
    [label release];
    
    
    UIButton *aboutUsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [aboutUsButton setCenter:CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMaxY(label.frame) + 22)];
    [aboutUsButton setBounds:CGRectMake(0, 0, 320, 44)];
    [aboutUsButton setTitle:@"关于我们                                                 >" forState:UIControlStateNormal];
    [accountButton setBackgroundImage:[UIImage imageNamed:@"background"] forState:UIControlStateHighlighted];
    [aboutUsButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [aboutUsButton setContentEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    [self.view addSubview:aboutUsButton];

    UIButton *feedBackButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [feedBackButton setCenter:CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMaxY(aboutUsButton.frame) + 22)];
    [feedBackButton setBounds:CGRectMake(0, 0, 320, 44)];
    [feedBackButton setTitle:@"反馈                                                        >" forState:UIControlStateNormal];
    [feedBackButton setBackgroundImage:[UIImage imageNamed:@"background"] forState:UIControlStateHighlighted];
    [feedBackButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [feedBackButton setContentEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    [self.view addSubview:feedBackButton];
  
    UIButton *updateButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [updateButton setCenter:CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMaxY(feedBackButton.frame) + 22)];
    [updateButton setBounds:CGRectMake(0, 0, 320, 44)];
    [updateButton setTitle:@"更新                                                        >" forState:UIControlStateNormal];
    [updateButton setBackgroundImage:[UIImage imageNamed:@"background"] forState:UIControlStateHighlighted];
    [updateButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [updateButton setContentEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    [self.view addSubview:updateButton];
    
}

- (void)pushButtonPressed
{
    AccountSettingViewController *accountSettingViewController = [[AccountSettingViewController alloc] init];
    [self.navigationController pushViewController:accountSettingViewController animated:YES];
    [accountSettingViewController release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
