//
//  ChatViewController.m
//  「UI」WeChat
//
//  Created by cuan on 14-2-1.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "ChatViewController.h"
#import "FirstChatViewController.h"

@interface ChatViewController ()

@end

@implementation ChatViewController

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
    
    UIButton *pushButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    pushButton.bounds = CGRectMake(0, 0, 320, 40);
    pushButton.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMinY(self.view.frame) + 20 + 44 + 35 + 20 + 5);
    [pushButton setTitle:@"PUSH" forState:UIControlStateNormal];
    pushButton.layer.borderWidth = 1.0f;
    pushButton.layer.borderColor = [UIColor colorWithWhite:0.721 alpha:1.000].CGColor;
    [pushButton addTarget:self action:@selector(pushVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushButton];
    
   
}

- (void)pushVC:(UIButton *)sender
{
    // 自定义返回按钮
    UIBarButtonItem *back = [[UIBarButtonItem alloc] init];
    back.title = @"返回-";
    back.tintColor = [UIColor colorWithRed:1.000 green:0.181 blue:0.597 alpha:1.000]; // invalid
    self.navigationItem.backBarButtonItem = back;
    [back release];
    
    FirstChatViewController *firstCVC = [[FirstChatViewController alloc] init];
    [self.navigationController pushViewController:firstCVC animated:YES];
    [firstCVC release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
