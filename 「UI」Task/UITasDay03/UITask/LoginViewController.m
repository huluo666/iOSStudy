//
//  LoginViewController.m
//  UITask
//
//  Created by cuan on 14-1-23.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "LoginViewController.h"
#import "ViewController.h"

#define USER_NAME @"admin"
#define PASS_WORD @"admin"
#define UserNameFiledTag 11
#define PasswordFiledTag 12
#define LoginInButtonTag 13
#define SwitchControlTag 14
#define ActivityIndicatorViewTag 15
#define AlertVieTag 16

@interface LoginViewController ()

- (void)initializeUserInteface;
- (void)processController:(UIControl *)sender;

@end

@implementation LoginViewController

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
	
    [self initializeUserInteface];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 事件处理方法

- (void)initializeUserInteface
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 用户名输入框
    UITextField *userNameField           = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 60, CGRectGetMinY(self.view.frame) + 40, 200, 30)];
    userNameField.tag                    = UserNameFiledTag;
    userNameField.borderStyle            = UITextBorderStyleRoundedRect;
    userNameField.layer.borderWidth      = 1.0f;
    userNameField.layer.borderColor      = [[UIColor greenColor] CGColor];
    userNameField.delegate               = self;
    userNameField.clearButtonMode        = UITextFieldViewModeWhileEditing;
    userNameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    [self.view addSubview:userNameField];
    [userNameField release];
    
    // 用户名
    UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(userNameField.frame) - 100, CGRectGetMinY(self.view.frame) + 40, 100, 30)];
    userNameLabel.textAlignment = NSTextAlignmentRight;
    userNameLabel.text = @"用户名：";
    [self.view addSubview:userNameLabel];
    [userNameLabel release];
    
    // 密码输入框
    UITextField *passwordField           = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 60, CGRectGetMaxY(userNameField.frame) + 20, 200, 30)];
    passwordField.tag                    = PasswordFiledTag;
    passwordField.borderStyle            = UITextBorderStyleRoundedRect;
    passwordField.layer.borderWidth      = 1.0f;
    passwordField.layer.borderColor      = [[UIColor greenColor] CGColor];
    passwordField.secureTextEntry        = YES;
    passwordField.delegate               = self;
    passwordField.clearButtonMode        = UITextFieldViewModeWhileEditing;
    passwordField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.view addSubview:passwordField];
    [passwordField release];
    
    // 密码
    UILabel *passwordLabel      = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(userNameField.frame) - 100, CGRectGetMaxY(userNameField.frame) + 20, 100, 30)];
    passwordLabel.textAlignment = NSTextAlignmentRight;
    passwordLabel.text          = @"密   码：";
    [self.view addSubview:passwordLabel];
    [passwordLabel release];
    
    // 登录按钮
    UIButton *loginInButton         = [UIButton buttonWithType:UIButtonTypeCustom];
    loginInButton.bounds            = CGRectMake(0, 0, 100, 30);
    loginInButton.tag               = LoginInButtonTag;
    loginInButton.layer.borderWidth = 1.0f;
    loginInButton.layer.borderColor = [[UIColor greenColor] CGColor];
    loginInButton.center            = CGPointMake(CGRectGetMaxX(self.view.frame) - 70, CGRectGetMaxY(passwordField.frame) + 30);
    [loginInButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginInButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginInButton addTarget:self action:@selector(processController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginInButton];
    
    // 开关
    UISwitch *switchControl = [[UISwitch alloc] initWithFrame:CGRectMake(CGRectGetMinX(loginInButton.frame) - 100, CGRectGetMaxY(passwordField.frame) + 15, 80, 30)];
    switchControl.tag       = SwitchControlTag;
    switchControl.tintColor = [UIColor grayColor]; // 主色调,边框
    [switchControl addTarget:self action:@selector(processController:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:switchControl];
    [switchControl release];
    
    // 进度指示器(俗称菊花)
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicatorView.bounds                   = CGRectMake(0, 0, 40, 40);
    activityIndicatorView.center                   = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMaxY(loginInButton.frame) + 50);
    activityIndicatorView.tag                      = ActivityIndicatorViewTag;
    [self.view addSubview:activityIndicatorView];
    [activityIndicatorView release];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 100, CGRectGetMaxY(switchControl.frame) + 100, 200, 0)];
    alertView.tag = AlertVieTag;
    [self.view addSubview:alertView];
    [alertView release];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 100, CGRectGetMaxY(switchControl.frame) + 20, 200, 30)];
    [self.view addSubview:slider];
    slider.value                 = 1;
    slider.minimumValue          = 0.2; // 最小值
    slider.maximumValue          = 1.0; // 最大值
    slider.minimumTrackTintColor = [UIColor redColor]; // 滑条最小进度指示色
    slider.maximumTrackTintColor = [UIColor grayColor]; // 滑条最大进度指示色
    [slider addTarget:self action:@selector(processController:) forControlEvents:UIControlEventValueChanged];
    [slider release];
    
//    self performSelector:(SEL) withObject:<#(id)#> afterDelay:<#(NSTimeInterval)#>
}

- (void)processController:(UIControl *)sender
{
    if ([sender isKindOfClass:[UISwitch class]])
    {
        UITextField *passwordField = (UITextField *)[self.view viewWithTag:PasswordFiledTag];
        passwordField.secureTextEntry =  passwordField.isSecureTextEntry == NO ? YES : NO;
    }
    else if ([sender isKindOfClass:[UISlider class]])
    {
        UISlider *slider = (UISlider *)sender;
        float value = slider.value;
        self.view.backgroundColor = [UIColor colorWithRed:(0.131 + value) green:(0.100 + value) blue:(0.107 + value) alpha:1.000];
        NSLog(@"slider value = % .2f", value);
    }
    else if ([sender isKindOfClass:[UIButton class]])
    {
        // 显示菊花
        UIActivityIndicatorView *activityIndicatorView = (UIActivityIndicatorView *)[self.view viewWithTag:15];
        [activityIndicatorView startAnimating];
        
        // 获取用户名和密码
        UITextField *userNameField = (UITextField *)[self.view viewWithTag:UserNameFiledTag];
        UITextField *passwordField = (UITextField *)[self.view viewWithTag:PasswordFiledTag];
        if ([userNameField.text isEqualToString:USER_NAME] && [passwordField.text isEqualToString:PASS_WORD])
        {
            // 登录成功
            ViewController *nextPageViewController = [[[ViewController alloc] init] autorelease];
            [self presentViewController:nextPageViewController animated:YES completion:^{
                NSLog(@"切换到下一页");
            }];
        }
        else
        {
            UIAlertView *alertView = (UIAlertView *)[self.view viewWithTag:AlertVieTag];
            [alertView show];
        }
    }
}

#pragma mark - <UITextFieldDelegate>

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    // 判断用户名
    if (textField.tag == 11)
    {
        if (!textField.text || textField.text.length < 5 || textField.text.length > 24)
        {
            ;// alert
        }
        
        if (textField.text )
        {
            ;
        }
    }
    
    //判断密码
    if (textField.tag == 12)
    {
        if (!textField.text || textField.text.length < 6)
        {
            ;//alert
        }
        
    }
}



@end
