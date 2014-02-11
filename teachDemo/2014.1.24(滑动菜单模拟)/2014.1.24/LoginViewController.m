//
//  LoginViewController.m
//  2014.1.24
//
//  Created by 张鹏 on 14-1-24.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "LoginViewController.h"
#import "ViewController.h"
#import "AppDelegate.h"

@interface LoginViewController ()

- (void)initializeUserInterface;
- (void)buttonPressed:(UIButton *)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // 在任何位置访问AppDelegate或者程序根控制器rootViewController
//    [[[UIApplication sharedApplication] delegate] window].rootViewController
    
    [self initializeUserInterface];
}

- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor colorWithRed:237.0 / 255
                                                green:212.0 / 255
                                                 blue:182.0 / 255
                                                alpha:1.0f];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.bounds = CGRectMake(0, 0, 80, 30);
    button.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    [button setTitle:@"Back" forState:UIControlStateNormal];
    [button addTarget:self
               action:@selector(buttonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)buttonPressed:(UIButton *)sender {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
    [(ViewController *)[(AppDelegate *)[[UIApplication sharedApplication] delegate] window].rootViewController setLogin:YES];
}

@end













