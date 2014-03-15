//
//  DDLogin.m
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-7.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDLogin.h"
#import "DDAppDelegate.h"
#import "DDRootViewController.h"

@interface DDLogin ()

// 快速创建文本域
- (UITextField *)textField;
// 处理登录
- (void)processLogin:(UIButton *)sender;
// 处理记住密码
- (void)processRemember:(UIButton *)sender;

@end

@implementation DDLogin

- (void)dealloc
{
    NSLog(@"%@ is dealloced", [self class]);
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor orangeColor];
        // 登录背景
        UIImage *backgroundImage = [UIImage imageNamed:@"Default-Landscape"];
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
        backgroundImageView.tag = kBackgroundImageViewTag;
        backgroundImageView.frame = CGRectMake(0, 0, kRootViewWidth, kRootViewHeight);
        backgroundImageView.userInteractionEnabled = YES;
        [self addSubview:backgroundImageView];
        [backgroundImageView release];
        
        // 灰色背景视图
        UIView *backgroundView = [[UIView alloc] initWithFrame:backgroundImageView.frame];
        backgroundView.alpha = 0.0f;
        [backgroundImageView addSubview:backgroundView];
        [backgroundView release];
        
        // 加载登录框
        UIImage *loginBackgroundImage = [UIImage imageNamed:@"登录框_03"];
        UIImageView *loginImageView = [[UIImageView alloc]
                                       initWithImage:loginBackgroundImage];
        loginImageView.bounds = CGRectMake(0, 0, 400, 500);
        loginImageView.center = CGPointMake(1024 / 2,
                                            kRootViewHeight + CGRectGetHeight(loginImageView.bounds));
        loginImageView.userInteractionEnabled = YES;
        loginImageView.contentMode = UIViewContentModeScaleAspectFit;
        [backgroundImageView addSubview:loginImageView];
        [loginImageView release];
        
        // 用户名输入框
        UITextField *userName = [self textField];
        [userName becomeFirstResponder];
        userName.center = CGPointMake(CGRectGetMidX(loginImageView.bounds),
                                      CGRectGetMidY(loginImageView.bounds) - 111);
        userName.text = @"khjl001";
        [userName performSelector:@selector(becomeFirstResponder)
                       withObject:nil
                       afterDelay:kAnimateDuration / 2];
        [loginImageView addSubview:userName];
        
        // 密码输入框
        UITextField *password = [self textField];
        password.center = CGPointMake(CGRectGetMidX(loginImageView.bounds),
                                      CGRectGetMidY(loginImageView.bounds) + 10);
        password.secureTextEntry = YES;
        password.text = @"123456";
        [loginImageView addSubview:password];
        
        // 登录按钮
        UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        loginButton.bounds = CGRectMake(0, 0, 150, 50);
        loginButton.center = CGPointMake(CGRectGetMaxX(loginImageView.bounds) - CGRectGetMidY(loginButton.bounds) - 100,
                                         CGRectGetMaxY(loginImageView.bounds) - CGRectGetMidX(loginButton.bounds) - 95);
        [loginButton setBackgroundImage:[UIImage imageNamed:@"登录_03"]
                               forState:UIControlStateNormal];
        [loginButton addTarget:self
                        action:@selector(processLogin:)
              forControlEvents:UIControlEventTouchUpInside];
        [loginImageView addSubview:loginButton];
        
        // 记住密码
        UIButton *remember = [UIButton buttonWithType:UIButtonTypeCustom];
        remember.bounds = CGRectMake(0, 0, 30, 30);
        remember.center = CGPointMake(CGRectGetMaxX(loginButton.frame) - 296,
                                      CGRectGetMidY(loginButton.frame));
        [remember setBackgroundImage:[UIImage imageNamed:@"记住密码未点击_03"]
                            forState:UIControlStateNormal];
        [remember setBackgroundImage:[UIImage imageNamed:@"记住密码点击_03"]
                            forState:UIControlStateSelected];
        [remember addTarget:self
                     action:@selector(processRemember:)
           forControlEvents:UIControlEventTouchUpInside];
        [loginImageView addSubview:remember];
        
        // 等一秒后背景变灰，出现登录框
        [UIView animateWithDuration:kAnimateDuration / 2
                         animations:^{
                             backgroundView.alpha = 0.5f;
                             backgroundView.backgroundColor = [UIColor blackColor];
                             loginImageView.center = CGPointMake(backgroundImageView.center.x,
                                                                 backgroundImageView.center.y - 40);
                         }];
    }
    return self;
}

- (UITextField *)textField
{
    UITextField *textField = [[[UITextField alloc] init] autorelease];
    textField.bounds = CGRectMake(0, 0, 320, 50);
    textField.textAlignment = NSTextAlignmentLeft;
    textField.font = [UIFont systemFontOfSize:24.0f];
    textField.backgroundColor = [UIColor clearColor];
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.keyboardAppearance = UIKeyboardAppearanceDefault;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    return textField;
}

- (void)processLogin:(UIButton *)sender
{
    // 登录成功
    [UIView animateWithDuration:kAnimateDuration animations:^{
        CGPoint center = self.center;
        self.center = CGPointMake(center.x, center.y * 3);
    } completion:^(BOOL finished) {
//        DDRootViewController *rootVC = (DDRootViewController *)kRootViewController;
//        rootVC.logined = YES;
        [self removeFromSuperview];
    }];
}

- (void)processRemember:(UIButton *)sender
{
    sender.selected = sender.isSelected ? NO : YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

@end