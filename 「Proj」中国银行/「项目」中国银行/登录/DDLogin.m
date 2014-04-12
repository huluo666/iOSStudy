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
#import "DDAppDelegate.h"
#import "DDIndex.h"

@interface DDLogin ()
{
    UITextField *_userName;
    UITextField *_password;
}

// 快速创建文本域
- (UITextField *)textField;
// 处理登录
- (void)processLogin:(UIButton *)sender;
// 处理记住密码
- (void)processRemember:(UIButton *)sender;

// 温馨提示
- (void)showAlertWithMessage:(NSString *)message;

@end

@implementation DDLogin

- (void)dealloc
{
    NSLog(@"%@ dealloced", [self class]);
    _userName = nil;
    _password = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor orangeColor];
        // 登录背景
        UIImage *backgroundImage = kImageWithNameHaveSuffix(@"Default-Landscape.png");
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
        UIImage *loginBackgroundImage = kImageWithNameHaveSuffix(@"登录框_03.png");
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
        _userName = [self textField];
        [_userName becomeFirstResponder];
        _userName.center = CGPointMake(CGRectGetMidX(loginImageView.bounds),
                                      CGRectGetMidY(loginImageView.bounds) - 111);
        _userName.text = @"khjl001";
        [_userName performSelector:@selector(becomeFirstResponder)
                       withObject:nil
                       afterDelay:kAnimateDuration / 2];
        [loginImageView addSubview:_userName];
        
        // 密码输入框
        _password = [self textField];
        _password.center = CGPointMake(CGRectGetMidX(loginImageView.bounds),
                                      CGRectGetMidY(loginImageView.bounds) + 10);
        _password.secureTextEntry = YES;
        _password.text = @"123456";
        [loginImageView addSubview:_password];
        
        // 登录按钮
        UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        loginButton.bounds = CGRectMake(0, 0, 150, 50);
        loginButton.center = CGPointMake(CGRectGetMaxX(loginImageView.bounds) -
                                         CGRectGetMidY(loginButton.bounds) - 100,
                                         CGRectGetMaxY(loginImageView.bounds) -
                                         CGRectGetMidX(loginButton.bounds) - 95);
        [loginButton setBackgroundImage:kImageWithNameHaveSuffix(@"登录_03.png")
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
        [remember setBackgroundImage:kImageWithNameHaveSuffix(@"记住密码未点击_03.png")
                            forState:UIControlStateNormal];
        [remember setBackgroundImage:kImageWithNameHaveSuffix(@"记住密码点击_03.png")
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
    // 获取用户输入用户名和密码
    NSString *username = _userName.text;
    NSString *password = _password.text;
    
    // 去掉前后空格
    username = [username stringByTrimmingCharactersInSet:
                [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    password = [password stringByTrimmingCharactersInSet:
                [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    // 排除不合格输入
    if (!username || username.length == 0) {
        [self showAlertWithMessage:@"用户名格式错误"];
        return;
    }
    if (!password || password.length == 0) {
        [self showAlertWithMessage:@"密码格式错误"];
        return;
    }
    
    // 请求登录
    sender.enabled = NO;
    __block DDLogin *this = self;
    [DDHTTPManager sendRequstWithUsername:username
                                 password:password
                        completionHandler:^(id content, NSString *resultCode) {
        if (![resultCode intValue] &&
            content &&
            [content isKindOfClass:[NSMutableDictionary class] ]) {
            // 登录成功
            [UIView animateWithDuration:kAnimateDuration animations:^{
                CGPoint center = this.center;
                this.center = CGPointMake(center.x, center.y * 3);
            } completion:^(BOOL finished) {
                // 移除当前视图
                [this removeFromSuperview];
                
                // 保存用户数据字典
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setValuesForKeysWithDictionary:content];
                [userDefaults synchronize];
                
                // 加载用户信息
                DDRootViewController *root = (DDRootViewController *)kRootViewController;
                root.nameLabel.text = [userDefaults objectForKey:kUserInfoUsername];
                root.realNameLabel.text = [userDefaults objectForKey:kUserInfoRealname];
            }];
        } else {
            // 登录失败
            [this showAlertWithMessage:@"用户名或者密码错误"];
        }
    }];
}

- (void)showAlertWithMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"温馨提示"
                              message:message
                              delegate:nil
                              cancelButtonTitle:nil
                              otherButtonTitles:nil];

    [alertView show];
    [alertView release];
    
    // 等一秒移除
    NSMethodSignature *signature = [UIAlertView instanceMethodSignatureForSelector:
                                    @selector(dismissWithClickedButtonIndex:animated:)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:alertView];
    [invocation setSelector:@selector(dismissWithClickedButtonIndex:animated:)];
    NSInteger index = 0;
    [invocation setArgument:&index atIndex:2];
    BOOL animated = YES;
    [invocation setArgument:&animated atIndex:3];
    [invocation retainArguments];
    [invocation performSelector:@selector(invoke) withObject:nil afterDelay:2];
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