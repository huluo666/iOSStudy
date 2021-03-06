//
//  LoginViewController.m
//  「UI」UITest
//
//  Created by 萧川 on 14-2-20.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "LoginViewController.h"
#import "HomePageViewController.h"
#import "AppDelegate.h"
#import "AudioPlayer.h"

@interface LoginViewController () <
    NSURLConnectionDataDelegate,
    NSURLConnectionDelegate,
    UIAlertViewDelegate,
    UITextFieldDelegate>

// 初始化用户界面
- (void)initUserInterface;
// 处理登录事件
- (void)processController:(UIButton *)sender;
// 播放背景音乐
- (void)playBackgroundMusic;
// 提示用户错误信息
- (void)showAlertWithMessage:(NSString *)message;

// 检查登录
- (void)checkLogin;

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
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
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:self.view.frame];
    bgView.image = [UIImage imageNamed:@"bg"];
    [self.view addSubview:bgView];
    [bgView release];
    
    // 进度指示器
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] init];
    indicator.bounds = CGRectMake(0, 0, 40, 40);
    indicator.center = self.view.center;
    indicator.tag = INDICATOR_TAG;
    [self.view addSubview:indicator];
    [indicator release];
    
    // 用户名输入框
    UITextField *userNameField = [[UITextField alloc]
                                  initWithFrame:CGRectMake(
                                    CGRectGetMidX(self.view.frame) - 60,
                                    CGRectGetMinY(self.view.frame) + 140,
                                    200,
                                    30)];
    userNameField.tag = UserNameFiledTag;
    userNameField.borderStyle = UITextBorderStyleRoundedRect;
    userNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    userNameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    userNameField.text = USER_NAME;
    [self.view addSubview:userNameField];
    [userNameField release];
    
    // 用户名显示标签
    UILabel *userNameLabel = [[UILabel alloc]
                              initWithFrame:CGRectMake(
                                CGRectGetMinX(userNameField.frame) - 100,
                                CGRectGetMinY(self.view.frame) + 140,
                                100,
                                30)];
    userNameLabel.textAlignment = NSTextAlignmentRight;
    userNameField.delegate = self;
    userNameLabel.text = @"用户名：";
    userNameLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:userNameLabel];
    [userNameLabel release];
    
    // 密码输入框
    UITextField *passwordField = [[UITextField alloc]
                                  initWithFrame:CGRectMake(
                                    CGRectGetMidX(self.view.frame) - 60,
                                    CGRectGetMaxY(userNameField.frame) + 20,
                                    200,
                                    30)];
    passwordField.tag  = PasswordFiledTag;
    passwordField.delegate = self;
    passwordField.borderStyle   = UITextBorderStyleRoundedRect;
    passwordField.secureTextEntry  = YES;
    passwordField.clearButtonMode   = UITextFieldViewModeWhileEditing;
    passwordField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    passwordField.text   = PASSWORD;
    [self.view addSubview:passwordField];
    [passwordField release];
    
    // 密码显示标签
    UILabel *passwordLabel  = [[UILabel alloc]
                                   initWithFrame:CGRectMake(
                                     CGRectGetMinX(userNameField.frame) - 100,
                                    CGRectGetMaxY(userNameField.frame) + 20,
                                    100,
                                    30)];
    passwordLabel.textAlignment = NSTextAlignmentRight;
    passwordLabel.text          = @"密   码：";
    passwordLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:passwordLabel];
    [passwordLabel release];
    
    // 登录按钮
    UIButton *loginInButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginInButton.bounds = CGRectMake(0, 0, 100, 30);
    loginInButton.tag = LoginInButtonTag;
    loginInButton.center = CGPointMake(CGRectGetMaxX(self.view.frame) - 200,
                                      CGRectGetMaxY(passwordField.frame) + 30);
    [loginInButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginInButton addTarget:self
                      action:@selector(processController:)
            forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginInButton];
}

- (void)processController:(UIButton *)sender
{
    // 开启进度条
    UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)[self.view viewWithTag:INDICATOR_TAG];
    [indicator startAnimating];

    // 延迟检查登录
    [self performSelector:@selector(checkLogin) withObject:nil afterDelay:0.5f];
}

- (void)checkLogin
{
    // 获取用户名和密码
    UITextField *userNameField = (UITextField *)[self.view viewWithTag:UserNameFiledTag];
    UITextField *passwordField = (UITextField *)[self.view viewWithTag:PasswordFiledTag];
    
    // 去掉前后空格
    NSString *userName = [userNameField.text stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [passwordField.text stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    // 排除不合格输入
    if (!userName || userName.length == 0) {
        [self showAlertWithMessage:@"用户名格式错误"];
        return;
    }
    if (!password || password.length == 0) {
        [self showAlertWithMessage:@"密码格式错误"];
        return;
    }
    
    // 验证登录
    if ([userName isEqualToString:USER_NAME] && [password isEqualToString:PASSWORD]) {
        HomePageViewController *homePageVC =
        [[(AppDelegate *)[[UIApplication sharedApplication] delegate] window] rootViewController].childViewControllers[0];
        [homePageVC setLogined:YES];
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        AudioPlayer *audioPlayer = [AudioPlayer sharedSingleton];
        [audioPlayer loadNameList:@[@"music_success", @"music"]];
        [audioPlayer playAudioName:@"music_success" type:@"caf"];
        [self performSelector:@selector(playBackgroundMusic) withObject:Nil afterDelay:0.3f];
    }
    else {
        [self showAlertWithMessage:@"登录失败!"];
        AudioPlayer *audioPlayer = [AudioPlayer sharedSingleton];
        [audioPlayer loadNameList:@[@"music_fail"]];
        [audioPlayer playAudioName:@"music_fail" type:@"mp3"];
    }

    UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)[self.view viewWithTag:INDICATOR_TAG];
    [indicator stopAnimating];
}

- (void)playBackgroundMusic
{
    AudioPlayer *audioPlayer = [AudioPlayer sharedSingleton];
    [audioPlayer playAudioName:@"music" type:@"mp3"];
}

- (void)showAlertWithMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"温馨提示"
                              message:message
                              delegate:self
                              cancelButtonTitle:@"返回重试"
                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
    
    UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)[self.view viewWithTag:INDICATOR_TAG];
    [indicator stopAnimating];
}

// 点击空白处收起键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate
// 按回车自动登录
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    [self checkLogin];
    return YES;
}

#pragma mark - UIAlertViewDelegate
// 返回重试
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        UIActivityIndicatorView *activityIndicatorView =
            (UIActivityIndicatorView *)[self.view viewWithTag:15];
        [activityIndicatorView stopAnimating];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
    
    [[AudioPlayer sharedSingleton] stop];
}

@end
