//
//  ViewController.m
//  UIDemo
//
//  Created by cuan on 14-1-24.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"

#define BULE_VIEW_SHOW @"Blue view showing"
#define RED_VIEW_SHOW @"Red view showing"

@interface ViewController ()
{
    UIView *_leftView;
    UIView *_rightView;
    UILabel *_stateDisplay;
    BOOL _leftViewShow;
}

- (void)initializationUserInterface;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initializationUserInterface];
}

- (void)initializationUserInterface
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect bounds = self.view.bounds;
    
    _leftView = [[UIView alloc] initWithFrame:bounds];
    self.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:_leftView];
    _leftViewShow = NO;
    
    _rightView = [[UIView alloc] initWithFrame:bounds];
    self.view.backgroundColor = [UIColor blueColor];
    _rightView.layer.shadowColor = [[UIColor blueColor] CGColor]; // 阴影颜色
    _rightView.layer.shadowOffset = CGSizeMake(-5, 5); // 阴影偏移
    _rightView.layer.shadowOpacity = 0.5; // 阴影透明度
    [self.view addSubview:_rightView];
    
    _stateDisplay = [[UILabel alloc] init];
    _stateDisplay.bounds = CGRectMake(0, 0, CGRectGetWidth(bounds), CGRectGetHeight(bounds));
    _stateDisplay.center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
    _stateDisplay.text = BULE_VIEW_SHOW;
    _stateDisplay.textColor = [UIColor whiteColor];
    _stateDisplay.font = [UIFont systemFontOfSize:20];
    _stateDisplay.textAlignment = NSTextAlignmentCenter;
    _stateDisplay.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_stateDisplay];

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _rightView.center = _leftViewShow ? CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds)) : CGPointMake(CGRectGetMaxX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    _stateDisplay.text = _leftViewShow ? BULE_VIEW_SHOW : RED_VIEW_SHOW;
    _leftViewShow = !_leftViewShow;
}

- (void)viewDidAppear:(BOOL)animated
{
//    LoginViewController *loginViewController = [[[LoginViewController alloc] init] autorelease];
//    [self presentViewController:loginViewController animated:YES completion:nil];
}

- (void)dealloc
{
    [_rightView release];
    [_rightView release];
    [_stateDisplay release];
    [super dealloc];
}

@end
