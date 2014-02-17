//
//  ViewController.m
//  UITask
//
//  Created by cuan on 14-1-22.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "MainViewController.h"
#import "LoginViewController.h"
#import "PhotosViewController.h"
#import "HomePageViewController.h"
#import "SettingViewController.h"

@interface MainViewController ()

- (void)initializeUserInteface;
- (void)loadGestureRecognizer;
- (void)processGesture:(UISwipeGestureRecognizer *)swip;

@end

@implementation MainViewController

- (void)dealloc
{
    [_rightView release];
    [_leftView release];
    [_label release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}

- (id)init
{
    if (self = [super init]) {
        _leftView = [[UIView alloc] init];
        _rightView = [[UIView alloc] init];
        _label = [[UILabel alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeUserInteface];
    [self loadGestureRecognizer];
}

/*!
 *    初始化用户界面
 */
- (void)initializeUserInteface
{
    _leftView.bounds          = CGRectMake(0, 0, 200, self.view.frame.size.height);
    _leftView.center          = CGPointMake(-100, CGRectGetMidY(self.view.frame));
    _leftView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_leftView];
    
    _rightView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _rightView.backgroundColor = [UIColor blueColor];
    _rightView.layer.shadowColor = [UIColor blackColor].CGColor;
    _rightView.layer.shadowOffset = CGSizeMake(-3, -3);
    _rightView.layer.shadowOpacity = 0.5;
    [self.view addSubview:_rightView];
    
    _label.frame = CGRectMake(60, 259, 200, 50);
    _label.tag = 101;
//    _label.text          = SHOW_RED_VIEW;
    _label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_label];
    [_label release];
    
    _leftViewShow = NO;
    
}


/*!
 *    添加手势识别
 */
- (void)loadGestureRecognizer
{
    UISwipeGestureRecognizer *swipViewLeft = [[UISwipeGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(processGesture:)];
    swipViewLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipViewLeft];
    [swipViewLeft release];

    UISwipeGestureRecognizer *swipNaviLeft = [[UISwipeGestureRecognizer alloc]
                                              initWithTarget:self
                                              action:@selector(processGesture:)];
    swipNaviLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.navigationController.navigationBar addGestureRecognizer:swipNaviLeft];
    [swipNaviLeft release];
    

    UISwipeGestureRecognizer *swipViewRight = [[UISwipeGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(processGesture:)];
    swipViewRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipViewRight];
    [swipViewRight release];
    
    UISwipeGestureRecognizer *swipNaviRight = [[UISwipeGestureRecognizer alloc]
                                              initWithTarget:self
                                              action:@selector(processGesture:)];
    swipNaviRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.navigationController.navigationBar addGestureRecognizer:swipNaviRight];
    [swipNaviRight release];
}

/*!
 *    处理手势识别
 *
 *    @param swip 手势
 */
- (void)processGesture:(UISwipeGestureRecognizer *)swip
{
    if (swip.direction == UISwipeGestureRecognizerDirectionLeft) { // 向左滑动
        [UIView animateWithDuration:0.5f animations:^{
            _leftView.center = CGPointMake(-(_leftView.bounds.size.width/2),
                                           CGRectGetMidY(self.view.frame));
            _rightView.center = CGPointMake(CGRectGetMidX(self.view.frame),
                                            CGRectGetMidY(self.view.frame));
            self.navigationController.navigationBar.center = CGPointMake(CGRectGetMidX(self.view.frame), 20 + 44 / 2);
            self.tabBarController.tabBar.center = CGPointMake(CGRectGetMidX(self.view.frame), [[UIScreen mainScreen] bounds].size.height - 49 / 2);
            _rightView.userInteractionEnabled = YES;
            self.tabBarController.tabBar.userInteractionEnabled = YES;
        }];
    }
    
    if (swip.direction == UISwipeGestureRecognizerDirectionRight) {
        [UIView animateWithDuration:0.5f animations:^{
            _leftView.center = CGPointMake(_leftView.bounds.size.width/2,
                                           CGRectGetMidY(self.view.frame));
            _rightView.center = CGPointMake(CGRectGetMidX(self.view.frame) +
                                            _leftView.bounds.size.width,
                                            CGRectGetMidY(self.view.frame));
            self.navigationController.navigationBar.center = CGPointMake(CGRectGetMidX(self.view.frame) + _leftView.bounds.size.width, 20 + 44 / 2);
            self.tabBarController.tabBar.center = CGPointMake(CGRectGetMidX(self.view.frame) + _leftView.bounds.size.width, [[UIScreen mainScreen] bounds].size.height - 49 / 2);
            _rightView.userInteractionEnabled = NO;
            self.tabBarController.tabBar.userInteractionEnabled = NO;
        }];
    }
    
    _leftViewShow = !_leftViewShow;
    
//    _label.text = [_label.text isEqualToString:SHOW_RED_VIEW] ? SHOW_BLUE_VIEW : SHOW_RED_VIEW;
}

@end
