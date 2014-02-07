//
//  RootViewController.m
//  「UI」Demo
//
//  Created by cuan on 14-2-7.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@property (retain, nonatomic, readonly) UIView *leftView;
@property (retain, nonatomic, readonly) UIView *rightView;
@property (retain, nonatomic, readonly) UILabel *stateDisplay;
@property (assign,nonatomic, readonly, getter = isLeftViewShow) BOOL leftViewShow;

@end

@implementation RootViewController

- (void)dealloc
{
    [_leftView release];
    [_rightView release];
    [_stateDisplay release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    if (self = [super init])
    {
        _leftView = [[UIView alloc] init];
        _rightView = [[UIView alloc] init];
        _stateDisplay = [[UILabel alloc] init];
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
    self.view.backgroundColor = [UIColor whiteColor];
    _leftView.bounds = CGRectMake(0, 0, 200, self.view.frame.size.height);
    _leftView.center = CGPointMake(-100, CGRectGetMidY(self.view.frame));
    _leftView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_leftView];


    _rightView.frame = self.view.frame;
    _rightView.backgroundColor = [UIColor blueColor];
    // 设置阴影颜色
    _rightView.layer.shadowColor = [UIColor blackColor].CGColor;
    // 设置阴影偏移
    _rightView.layer.shadowOffset = CGSizeMake(-5, 5);
    // 设置阴影透明度
    _rightView.layer.shadowOpacity = 0.5;
    [self.view addSubview:_rightView];
    
    _stateDisplay.frame = self.view.frame;
    _stateDisplay.text = RED_VIEW_SHOW;
    _stateDisplay.textColor = [UIColor whiteColor];
    _stateDisplay.font = [UIFont systemFontOfSize:20];
    _stateDisplay.textAlignment = NSTextAlignmentCenter;
    _stateDisplay.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_stateDisplay];
    
    _leftViewShow = NO;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_leftViewShow)
    {
        [UIView animateWithDuration:0.35f animations:^{
            _leftView.center = CGPointMake(-100, CGRectGetMidY(self.view.frame));
            _rightView.center = self.view.center;
        }];
    }
    else
    {
        [UIView animateWithDuration:0.35f animations:^{
            _leftView.center = CGPointMake(100, CGRectGetMidY(self.view.frame));
            _rightView.center = CGPointMake(360, CGRectGetMidY(self.view.frame));
        }];
    }
    _leftViewShow = !_leftViewShow;
    _stateDisplay.text = _leftViewShow ? BLUE_VIEW_SHOW : RED_VIEW_SHOW;
}

@end
