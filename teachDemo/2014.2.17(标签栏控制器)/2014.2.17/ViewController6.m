//
//  ViewController6.m
//  2014.2.17
//
//  Created by 张鹏 on 14-2-17.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "ViewController6.h"

@interface ViewController6 ()

- (void)buttonPressed:(UIButton *)sender;
- (void)processLogin:(UIAlertView *)alertView;
- (void)processLoginSuccess:(UIAlertView *)alertView;

@end

@implementation ViewController6

- (id)init
{
    self = [super init];
    if (self) {
        
        self.title = @"Login";
        UITabBarItem *tabBarItem = [[UITabBarItem alloc]
                                    initWithTitle:@"Login"
                                    image:[UIImage imageNamed:@"1.png"]
                                    tag:5];
        self.tabBarItem = tabBarItem;
        [tabBarItem release];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initializeUserInterface];
}

- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor specialRandomColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.text = self.title;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:30];
    label.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label];
    [label release];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 100, 30);
    button.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMaxY(self.view.bounds) - 200);
    [button setTitle:@"Login Now!" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self
               action:@selector(buttonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonPressed:(UIButton *)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                    message:@"登录成功，即将进行页面跳转！\n3"
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
    
    [self performSelector:@selector(processLogin:) withObject:alert afterDelay:1];
}

- (void)processLogin:(UIAlertView *)alertView {
    
    NSInteger count = [[alertView.message substringFromIndex:alertView.message.length - 1] integerValue];
    if (--count == 0) {
        [self processLoginSuccess:alertView];
    }
    else {
        alertView.message = [NSString stringWithFormat:@"登录成功，即将进行页面跳转！\n%d", count];
        [self performSelector:_cmd withObject:alertView afterDelay:1];
    }
}

- (void)processLoginSuccess:(UIAlertView *)alertView {
    
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
    self.tabBarController.selectedIndex = 2;
}

@end

























