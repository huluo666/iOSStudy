//
//  LoginViewController.m
//  绿地作业demo
//
//  Created by 张鹏 on 14-2-12.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "LoginViewController.h"
#import "RootViewController.h"
#import "AppDelegate.h"
#import "ZPHTTPManager.h"

static NSString * const kUserName = @"admin";
static NSString * const kUserPassword = @"123456";

@interface LoginViewController () {
    
    UITextField *_nameTextField;
    UITextField *_passwordTextField;
    UIActivityIndicatorView *_activityIndicatorView;
}

- (void)initializeUserInterface;
- (void)processControl:(UIControl *)sender;
- (void)processLogin;
- (void)processLoginSucess;

@end

@implementation LoginViewController

- (void)dealloc {
    
    [_nameTextField         release];
    [_passwordTextField     release];
    [_activityIndicatorView release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initializeUserInterface];
}

- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 70, 30)];
    nameLabel.text = @"用户名：";
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.textAlignment = NSTextAlignmentRight;
    nameLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:nameLabel];
    [nameLabel release];
    
    _nameTextField = [[UITextField alloc] init];
    _nameTextField.bounds = CGRectMake(0, 0, 200, 30);
    _nameTextField.center = CGPointMake(CGRectGetMaxX(nameLabel.frame) + 10 + CGRectGetMidX(_nameTextField.bounds),
                                        CGRectGetMidY(nameLabel.frame));
    _nameTextField.text = kUserName;
    _nameTextField.borderStyle = UITextBorderStyleLine;
    _nameTextField.font = [UIFont systemFontOfSize:15];
    _nameTextField.placeholder = @"Name";
    _nameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _nameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    _nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_nameTextField];
    
    UILabel *passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 150, 70, 30)];
    passwordLabel.text = @"密  码：";
    passwordLabel.font = [UIFont systemFontOfSize:15];
    passwordLabel.textAlignment = NSTextAlignmentRight;
    passwordLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:passwordLabel];
    [passwordLabel release];
    
    _passwordTextField = [[UITextField alloc] init];
    _passwordTextField.bounds = CGRectMake(0, 0, 200, 30);
    _passwordTextField.center = CGPointMake(CGRectGetMaxX(passwordLabel.frame) + 10 + CGRectGetMidX(_passwordTextField.bounds),
                                            CGRectGetMidY(passwordLabel.frame));
    _passwordTextField.text = kUserPassword;
    _passwordTextField.borderStyle = UITextBorderStyleLine;
    _passwordTextField.font = [UIFont systemFontOfSize:15];
    _passwordTextField.placeholder = @"Password";
    _passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _passwordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordTextField.secureTextEntry = YES;
    [self.view addSubview:_passwordTextField];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    loginButton.bounds = CGRectMake(0, 0, 50, 30);
    loginButton.center = CGPointMake(CGRectGetMinX(_passwordTextField.frame) + CGRectGetMidX(loginButton.bounds),
                                     CGRectGetMaxY(_passwordTextField.frame) + 20 + CGRectGetMidY(loginButton.bounds));
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(processControl:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    UISwitch *secureTextEntryControl = [[UISwitch alloc] init];
    secureTextEntryControl.bounds = CGRectMake(0, 0, 50, 30);
    secureTextEntryControl.center = CGPointMake(CGRectGetMaxX(_passwordTextField.frame) - CGRectGetMidX(secureTextEntryControl.bounds),
                                                CGRectGetMaxY(_passwordTextField.frame) + 20 + CGRectGetMidY(secureTextEntryControl.bounds));
    [secureTextEntryControl addTarget:self action:@selector(processControl:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:secureTextEntryControl];
    [secureTextEntryControl release];
    
    UISlider *slider = [[UISlider alloc] init];
    slider.bounds = CGRectMake(0, 0, 200, 30);
    slider.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidX(self.view.bounds) + 100);
    slider.minimumValue = 0.0;
    slider.maximumValue = 1.0;
    slider.value = 1.0;
    slider.minimumTrackTintColor = [UIColor redColor];
    [slider addTarget:self action:@selector(processControl:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    [slider release];
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicatorView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    [self.view addSubview:_activityIndicatorView];
}

- (void)processControl:(UIControl *)sender {
    
    if ([sender isKindOfClass:[UIButton class]]) {
        [self processLogin];
    }
    else if ([sender isKindOfClass:[UISwitch class]]) {
        UISwitch *switchControl = (UISwitch *)sender;
        _passwordTextField.secureTextEntry = !switchControl.isOn;
    }
    else {
        UISlider *slider = (UISlider *)sender;
        self.view.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0 - slider.value];
    }
}

- (void)processLogin {
    
    if (_nameTextField.text.length > 0     && [_nameTextField.text isEqualToString:kUserName] &&
        _passwordTextField.text.length > 0 && [_passwordTextField.text isEqualToString:kUserPassword]) {
        // 配置参数
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:@"Public" forKey:@"m"];
        [dict setObject:@"login" forKey:@"c"];
        [dict setObject:_nameTextField.text forKey:@"user_name"];
        [dict setObject:_passwordTextField.text forKey:@"password"];
        // 发起异步请求
        [ZPHTTPManager startAsynchronousRequestWithURLString:SERVER_URL
                                                      params:dict
                                           completionHandler:^(BOOL sucess, id content) {
            if (sucess) {
                [_activityIndicatorView startAnimating];
                [self performSelector:@selector(processLoginSucess) withObject:nil afterDelay:3];
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登录失败"
                                                                message:content
                                                               delegate:nil
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
                [alert show];
                [alert release];
            }
        }];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登录失败"
                                                        message:@"用户名或密码错误"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

- (void)processLoginSucess {
    
    [_activityIndicatorView stopAnimating];
    
    RootViewController *vc = (RootViewController *)[[[[UIApplication sharedApplication] delegate] window] rootViewController];
    vc.login = YES;
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
