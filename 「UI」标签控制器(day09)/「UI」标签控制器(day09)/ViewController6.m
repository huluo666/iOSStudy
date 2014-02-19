//
//  ViewController6.m
//  「UI」标签控制器(day09)
//
//  Created by 萧川 on 14-2-17.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "ViewController6.h"
#import "UIColor+Expand.h"

@interface ViewController6 () <UIAlertViewDelegate>

- (void)initUserInterface;
- (void)processLogin:(UIAlertView *)alert;
- (void)processLoginSucess:(UIAlertView *)alert;

@end

@implementation ViewController6

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"BookMarks";
     
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self initUserInterface];
}

- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor specialRandomColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.frame];
    label.font = [UIFont systemFontOfSize:24.0f];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = self.title;
    [self.view addSubview:label];
    [label release];
    
    UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
    login.bounds = CGRectMake(0, 0, 150, 30);
    login.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame) + 50);
    [login setTitle:@"Login" forState:UIControlStateNormal];
    [login addTarget:self action:@selector(Logined) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:login];
}

- (void)Logined
{
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.title = @"正在登录";
    alert.message = @"倒计时 \n 3";
    alert.delegate = self;
    [alert show];
    [alert release];
    
    [self performSelector:@selector(processLogin:) withObject:alert afterDelay:1.0f];
}

- (void)processLogin:(UIAlertView *)alert
{
    NSInteger count = [[alert.message substringFromIndex:alert.message.length -1] integerValue];

    if (--count == 0) {
        [self processLoginSucess:alert];
    } else {
        alert.message = [NSString stringWithFormat:@"倒计时 \n %ld", count];
        [self performSelector:_cmd withObject:alert afterDelay:1.0f];
    }
}

- (void)processLoginSucess:(UIAlertView *)alert
{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
    self.tabBarController.selectedIndex = 2;
}


@end
