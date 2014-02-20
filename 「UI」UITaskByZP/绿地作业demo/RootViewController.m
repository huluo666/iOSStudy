//
//  RootViewController.m
//  绿地作业demo
//
//  Created by 张鹏 on 14-2-12.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "RootViewController.h"
#import "LoginViewController.h"
#import "AlbumViewController.h"
#import "MainViewController.h"
#import "SettingViewController.h"
#import "MusicListViewController.h"

#define BUTTON_TAG 10

@interface RootViewController () {
    
    UIView *_leftView;
    UIView *_rightView;
    BOOL _rightViewShow;
    
    UITabBarController *_tabBarController;
}

- (void)initializeUserInterface;
- (void)processSwipeGesture:(UISwipeGestureRecognizer *)swipe;
- (void)positionAnimationWithSwipeDirection:(UISwipeGestureRecognizerDirection)direction;

@end

@implementation RootViewController

- (void)dealloc {
    
    [_leftView     release];
    [_rightView    release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initializeUserInterface];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
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
    _leftView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_leftView];
    
    // 主页
    MainViewController *mainVC = [[MainViewController alloc] init];
    UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController:mainVC];
    mainNav.navigationBar.tintColor = [UIColor redColor];
    [mainVC release];
    // 相册
    AlbumViewController *albumVC = [[AlbumViewController alloc] init];
    UINavigationController *albumNav = [[UINavigationController alloc] initWithRootViewController:albumVC];
    albumNav.navigationBar.tintColor = [UIColor redColor];
    [albumVC release];
    // 设置
    SettingViewController *settingVC = [[SettingViewController alloc] init];
    UINavigationController *settingNav = [[UINavigationController alloc] initWithRootViewController:settingVC];
    settingNav.navigationBar.tintColor = [UIColor redColor];
    [settingVC release];
    // 音乐
    MusicListViewController *musicVC = [[MusicListViewController alloc] init];
    UINavigationController *musicNav = [[UINavigationController alloc] initWithRootViewController:musicVC];
    musicNav.navigationBar.tintColor = [UIColor redColor];
    [musicVC release];

    _tabBarController = [[UITabBarController alloc] init];
    _tabBarController.viewControllers = @[mainNav, albumNav, settingNav, musicNav];
    for (int i = 0; i < 4; i++) {
        [(UITabBarItem *)_tabBarController.tabBar.items[i]
         setTitleTextAttributes:@{
                            NSFontAttributeName: [UIFont systemFontOfSize:15],
                            NSForegroundColorAttributeName: [UIColor colorWithPatternImage:[UIImage imageNamed:@"backS.png"]]
                          }
         forState:UIControlStateNormal];
    }
    [self addChildViewController:_tabBarController];
    
    [mainNav    release];
    [albumNav   release];
    [settingNav release];
    [musicNav   release];
    
    _rightView = [_tabBarController.view retain];
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointZero];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(_rightView.bounds), CGRectGetMaxY(_rightView.bounds))];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMaxX(_rightView.bounds), CGRectGetMaxY(_rightView.bounds))];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMaxX(_rightView.bounds), CGRectGetMinY(_rightView.bounds))];
    _rightView.layer.shadowRadius = 5.0;
    _rightView.layer.shadowOffset = CGSizeMake(-3, 3);
    _rightView.layer.shadowOpacity = 0.5;
    _rightView.layer.shadowPath = bezierPath.CGPath;
    [bezierPath closePath];
    [self.view addSubview:_rightView];
    
    _rightViewShow = YES;
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(processSwipeGesture:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipe];
    [leftSwipe release];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc]
                                            initWithTarget:self
                                            action:@selector(processSwipeGesture:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipe];
    [rightSwipe release];
}

#pragma mark - Process gesture recognizer / Animations methods

- (void)processSwipeGesture:(UISwipeGestureRecognizer *)swipe {
    
    [self positionAnimationWithSwipeDirection:swipe.direction];
}

- (void)positionAnimationWithSwipeDirection:(UISwipeGestureRecognizerDirection)direction {
    
    if (direction == UISwipeGestureRecognizerDirectionLeft && !_rightViewShow) {
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _rightView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
        } completion:^(BOOL finished) {
            _rightViewShow = YES;
        }];
    }
    else if (direction == UISwipeGestureRecognizerDirectionRight && _rightViewShow) {
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _rightView.center = CGPointMake(CGRectGetMaxX(self.view.bounds) + 100, CGRectGetMidY(self.view.bounds));
        } completion:^(BOOL finished) {
            _rightViewShow = NO;
        }];
    }
}


@end
