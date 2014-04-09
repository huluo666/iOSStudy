//
//  DDRootViewController.m
//  LighterReader
//
//  Created by 萧川 on 14-3-26.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDRootViewController.h"
#import "DDMainUIViewController.h"
#import "DDSignMenuView.h"
#import "DDMainUINaviController.h"
#import "DDNaviMenuView.h"
#import "DDAppDelegate.h"
#import "DDSearchMenuView.h"

#define kSwipAnimationDuration 0.8

@interface DDRootViewController ()

@property (assign, nonatomic, getter = isMenuShow) BOOL menuShow;
@property (strong, nonatomic) UIView *backgroundView;

- (void)swipRightGestureAction:(UISwipeGestureRecognizer *)swipRightGesture;
- (void)processMenu;

- (void)showSearchView;
- (void)swipLeftGestureAction:(UISwipeGestureRecognizer *)swipLeftGesture;

@end

@implementation DDRootViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    /* very import */
    DDAppDelegate *ddDelegate = [[UIApplication sharedApplication] delegate];
    ddDelegate.rootVC = self;
    
    // gesture
    _swipRightGesture = [[UISwipeGestureRecognizer  alloc]
                         initWithTarget:self
                         action:@selector(swipRightGestureAction:)];
    _swipRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:_swipRightGesture];
    
    _swipLeftGesture = [[UISwipeGestureRecognizer alloc]
                        initWithTarget:self
                        action:@selector(swipLeftGestureAction:)];
    _swipLeftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:_swipLeftGesture];

    // add main UI view controller
    DDMainUIViewController *mainUIVC = [[DDMainUIViewController alloc] init];
    mainUIVC.handleMenuBarItemAction = ^{
        [self processMenu];
    };
    mainUIVC.handleSearchBarItemAction = ^{
        [self showSearchView];
    };
    DDMainUINaviController *navi = [[DDMainUINaviController alloc]
                                    initWithRootViewController:mainUIVC];
    [self addChildViewController:navi];
    [self.view addSubview:navi.view];
    
    // init background view
    _backgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
    _backgroundView.alpha = 0;
    _backgroundView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_backgroundView];
}

#pragma mark - private messages

- (void)swipRightGestureAction:(UISwipeGestureRecognizer *)swipRightGesture {

    if ([swipRightGesture locationInView:self.view].x < 30 &&
        _menuShow == NO) {
        [self processMenu];
    }
}

- (void)swipLeftGestureAction:(UISwipeGestureRecognizer *)swipLeftGesture {
    
    if ([swipLeftGesture locationInView:self.view].x >
        (CGRectGetWidth(self.view.bounds) - 30) &&
        _menuShow == NO) {
        [self showSearchView];
    }
}

- (void)processMenu {
    
    _login = YES;
    if (_login) {
        /* show navi menu */
        // init
        BOOL isExist = NO;
        DDNaviMenuView *naviMenuViewStrong = nil;
        
        for (UIView *view in self.view.subviews) {
            if ([view isKindOfClass:[DDNaviMenuView class]]) {
                isExist = YES;
                naviMenuViewStrong = (DDNaviMenuView *)view;
            }
        }

        if (!isExist) {
            naviMenuViewStrong = [[DDNaviMenuView alloc] initWithFrame:CGRectZero];
            [self.view addSubview:naviMenuViewStrong];
        }

        __weak DDNaviMenuView *naviMenuView = naviMenuViewStrong;
        naviMenuView.tag = kNaviMenuViewTag;
        naviMenuView.center = CGPointMake(-2 * CGRectGetMidX(self.view.frame),
                                          CGRectGetMidY(self.view.frame) + 10);
        // show
        [UIView animateWithDuration:kSwipAnimationDuration animations:^{
            naviMenuView.center = CGPointMake(CGRectGetMidX(self.view.frame) - 20,
                                              CGRectGetMidY(self.view.frame) + 10);
            // add background view
            _backgroundView.alpha = 0.5;
        } completion:^(BOOL finished) {
            _menuShow = YES;
            [self.view removeGestureRecognizer:_swipRightGesture];
        }];
        
        // disappear
        naviMenuView.handleSwipLeft = ^{
            if (_menuShow) {
                [UIView animateWithDuration:kSwipAnimationDuration animations:^{
                    naviMenuView.center = CGPointMake(-2 * CGRectGetMidX(self.view.frame),
                                                      CGRectGetMidY(self.view.frame) + 10);
                    _backgroundView.alpha = 0;
                } completion:^(BOOL finished) {
                    _menuShow = NO;
                    [self.view addGestureRecognizer:_swipRightGesture];
                    if (!self.isLogin) {
                        [naviMenuView removeFromSuperview];
                    }
                }];
            }
        };
        
        
    } else {
        /* show sign */
        // init
        DDSignMenuView *signMenuViewStrong = [[DDSignMenuView alloc]
                                                initWithFrame:CGRectZero];
        __weak DDSignMenuView *signMenuView = signMenuViewStrong;
        signMenuView.tag = kSignMenuViewTag;
        signMenuView.center = CGPointMake(-2 * CGRectGetMidX(self.view.frame),
                                          CGRectGetMidY(self.view.frame) + 10);
        
        // show
        [UIView animateWithDuration:kSwipAnimationDuration animations:^{
             signMenuView.center = CGPointMake(CGRectGetMidX(self.view.frame) - 20,
                                               CGRectGetMidY(self.view.frame) + 10);
             // add background view
             _backgroundView.alpha = 0.5;
            
         } completion:^(BOOL finished) {
             _menuShow = YES;
            [self.view removeGestureRecognizer:_swipRightGesture];
         }];
        
        // disappear
        signMenuView.handleLeftSwip = ^{
            if (_menuShow) {
                [UIView animateWithDuration:kSwipAnimationDuration animations:^{
                    signMenuView.center = CGPointMake(-2 * CGRectGetMidX(self.view.frame),
                                                      CGRectGetMidY(self.view.frame) + 10);
                    _backgroundView.alpha = 0;
                } completion:^(BOOL finished) {
                     _menuShow = NO;
                     [self.view addGestureRecognizer:_swipRightGesture];
                     [signMenuView removeFromSuperview];
                }];
            }
        };
        
        [self.view addSubview:signMenuView];
    }
}

- (void)showSearchView {
    
    DDSearchMenuView *searchMenuViewStrong = [[DDSearchMenuView alloc] initWithFrame:CGRectZero];
    searchMenuViewStrong.userInteractionEnabled = YES;
    __weak DDSearchMenuView *searchMenuView = searchMenuViewStrong;
    searchMenuView.tag = kSearchMenuViewTag;
    searchMenuView.center = CGPointMake(3 * CGRectGetMidX(self.view.frame),
                                        CGRectGetMidY(self.view.frame) + 10);
    // show
    [UIView animateWithDuration:kSwipAnimationDuration animations:^{
        searchMenuView.center = CGPointMake(CGRectGetMidX(self.view.frame) + 20,
                                            CGRectGetMidY(self.view.frame) + 10);
        _backgroundView.alpha = 0.5;
    } completion:^(BOOL finished) {
        _menuShow = YES;
        [self.view removeGestureRecognizer:_swipRightGesture];
    }];
    
    // disappear
    searchMenuView.handleSwipRight = ^{
        if (_menuShow) {
            [UIView animateWithDuration:kSwipAnimationDuration animations:^{
                searchMenuView.center = CGPointMake(3 * CGRectGetMidX(self.view.frame),
                                                    CGRectGetMidY(self.view.frame) + 10);
                _backgroundView.alpha = 0;
            } completion:^(BOOL finished) {
                _menuShow = NO;
                [self.view addGestureRecognizer:_swipRightGesture];
                [searchMenuView removeFromSuperview];
            }];
        }
    };
    
    [self.view addSubview:searchMenuView];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:_backgroundView];
    if (point.x > CGRectGetWidth(self.view.bounds) - 40) {
        // close sign menu
        DDSignMenuView *signMenuView = (DDSignMenuView *)[self.view viewWithTag:kSignMenuViewTag];
        [signMenuView swipLeftAction];
        
        // close navi menu
        DDNaviMenuView *naviMenuView = (DDNaviMenuView *)[self.view viewWithTag:kNaviMenuViewTag];
        [naviMenuView swipLeftAction];
    }
    
    if (point.x < 40) {
        DDSearchMenuView *searchMenuView = (DDSearchMenuView *)[self.view viewWithTag:kSearchMenuViewTag];
        [searchMenuView swipRightAction];
    }
}

@end
