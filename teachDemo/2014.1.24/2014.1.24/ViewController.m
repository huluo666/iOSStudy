//
//  ViewController.m
//  2014.1.24
//
//  Created by 张鹏 on 14-1-24.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"

#define BLUE_VIEW_SHOW @"Blue View Showing"
#define RED_VIEW_SHOW  @"Red View Showing"

@interface ViewController () {
    
    UIView *_leftView;
    UIView *_rightView;
    UILabel *_stateDisplay;
    
    BOOL _leftViewShow;
}

- (void)initializeUserInterface;
- (void)buttonPressed:(UIButton *)sender;

@end

@implementation ViewController

- (void)dealloc {
    
    [_leftView     release];
    [_rightView    release];
    [_stateDisplay release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initializeUserInterface];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    if (!_login) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self presentViewController:loginVC animated:YES completion:nil];
        [loginVC release];
    }
}

- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect bounds = self.view.bounds;
    
    _leftView = [[UIView alloc] initWithFrame:bounds];
    _leftView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_leftView];
    
    _rightView = [[UIView alloc] initWithFrame:bounds];
    _rightView.backgroundColor = [UIColor blueColor];
    // 设置阴影颜色
    _rightView.layer.shadowColor = [UIColor blackColor].CGColor;
    // 设置阴影偏移
    _rightView.layer.shadowOffset = CGSizeMake(-5, 5);
    // 设置阴影透明度
    _rightView.layer.shadowOpacity = 0.5;
    [self.view addSubview:_rightView];
    
    _stateDisplay = [[UILabel alloc] init];
    _stateDisplay.bounds = CGRectMake(0, 0, CGRectGetWidth(bounds), 50);
    _stateDisplay.center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
    _stateDisplay.text = BLUE_VIEW_SHOW;
    _stateDisplay.textColor = [UIColor whiteColor];
    _stateDisplay.font = [UIFont systemFontOfSize:20];
    _stateDisplay.textAlignment = NSTextAlignmentCenter;
    _stateDisplay.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_stateDisplay];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = bounds;
    [button addTarget:self
               action:@selector(buttonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    _leftViewShow = NO;
    _login = NO;
}

- (void)buttonPressed:(UIButton *)sender {
    
    _rightView.center = _leftViewShow ? CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds)) : CGPointMake(CGRectGetMaxX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    _stateDisplay.text = _leftViewShow ? BLUE_VIEW_SHOW : RED_VIEW_SHOW;
    _leftViewShow = !_leftViewShow;
}

@end














