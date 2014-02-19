//
//  ViewController.m
//  UITask
//
//  Created by cuan on 14-1-22.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "RootViewController.h"
#import "LoginViewController.h"
#import "PhotosViewController.h"
#import "HomePageViewController.h"
#import "SettingViewController.h"
#import "AboutViewController.h"

@interface RootViewController ()

- (void)initializeUserInteface;
- (void)initTabBarController;
- (void)loadGestureRecognizer;
- (void)processGesture:(UISwipeGestureRecognizer *)swip;

@end

@implementation RootViewController

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
    [self initTabBarController];
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
    
    _rightView.frame = CGRectMake(0, 0, self.view.frame.size.width,
                                  self.view.frame.size.height);
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

- (void)initTabBarController
{
    PhotosViewController *photoVC = [[PhotosViewController alloc] init];
    UINavigationController *photoNavi = [[UINavigationController alloc]
                                         initWithRootViewController:photoVC];
    photoNavi.tabBarItem.image = [UIImage imageNamed:@"photoNavi"];
    [photoVC release];
    
    HomePageViewController *homePageVC = [[HomePageViewController alloc] init];
    UINavigationController *homePageNavi = [[UINavigationController alloc]
                                            initWithRootViewController:homePageVC];
    homePageNavi.tabBarItem.image = [UIImage imageNamed:@"homePageNavi"];
    [homePageVC release];
    
    SettingViewController *settingVC = [[SettingViewController alloc] init];
    UINavigationController *settingNavi = [[UINavigationController alloc]
                                           initWithRootViewController:settingVC];
    settingNavi.tabBarItem.image = [UIImage imageNamed:@"settingNavi"];
    [settingVC release];
    
    AboutViewController *aboutVC = [[AboutViewController alloc] init];
    UINavigationController *aboutNavi = [[UINavigationController alloc]
                                         initWithRootViewController:aboutVC];
    
    aboutNavi.tabBarItem.image = [UIImage imageNamed:@"aboutNavi"];
    [aboutVC release];
    
    NSArray *controllers = @[photoNavi, homePageNavi, settingNavi, aboutNavi];
    [photoNavi release];
    [homePageNavi release];
    [settingNavi release];
    [aboutNavi release];
    
    for (UINavigationController *controller in controllers) {
        [controller.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_ios7"]
                                       forBarMetrics:UIBarMetricsDefault];
        [controller.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                           NSFontAttributeName:[UIFont systemFontOfSize:20]}];
        controller.navigationBar.tintColor = [UIColor whiteColor];
    }
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.tabBar.barTintColor = [UIColor colorWithRed:0.500 green:0.461 blue:0.336 alpha:1.000];
    tabBarController.viewControllers = controllers;
    tabBarController.tabBar.tintColor = [UIColor colorWithRed:1.000 green:0.458 blue:0.353 alpha:1.000];
    tabBarController.selectedIndex = 1;
    [_rightView addSubview:tabBarController.view];
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

    UISwipeGestureRecognizer *swipViewRight = [[UISwipeGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(processGesture:)];
    swipViewRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipViewRight];
    [swipViewRight release];
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
            _rightView.userInteractionEnabled = NO;
            self.tabBarController.tabBar.userInteractionEnabled = NO;
        }];
    }
    
    _leftViewShow = !_leftViewShow;
    
//    _label.text = [_label.text isEqualToString:SHOW_RED_VIEW] ? SHOW_BLUE_VIEW : SHOW_RED_VIEW;
}

@end
