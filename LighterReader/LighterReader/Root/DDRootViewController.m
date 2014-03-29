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

@interface DDRootViewController () <
    UIGestureRecognizerDelegate
>

@property (retain, nonatomic) UIPanGestureRecognizer *panGesture;
@property (assign, nonatomic, getter = isMenuShow) BOOL menuShow;
@property (retain, nonatomic) UIView *backgroundView;

@end

@implementation DDRootViewController

- (void)dealloc
{
    [_panGesture release];
    [_backgroundView release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor grayColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _panGesture = [[UIPanGestureRecognizer alloc]
                   initWithTarget:self
                   action:@selector(panGestureAction:)];
    _panGesture.delegate = self;
    [self.view addGestureRecognizer:_panGesture];

    // add main UI view controller
    DDMainUIViewController *mainUIVC = [[DDMainUIViewController alloc] init];
    mainUIVC.handleMenuBarItemAction = ^{
        [self processMenu];
    };
    DDMainUINaviController *navi = [[DDMainUINaviController alloc]
                                    initWithRootViewController:mainUIVC];
    [mainUIVC release];
    [self addChildViewController:navi];
    [self.view addSubview:navi.view];
    [navi release];
    
    // init background view
    _backgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
    _backgroundView.alpha = 0;
    _backgroundView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_backgroundView];
}

#pragma mark - private messages

- (void)swipRightAction
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)panGestureAction:(UIPanGestureRecognizer *)panGesture
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    if ([panGesture locationInView:self.view].x < 30
        && _menuShow == NO) {
        NSLog(@"pan gesture action should execute");
        [self processMenu];
    }
}

- (void)processMenu {
    
    _login = YES;
    if (_login) {
        /* show navi menu */
        // init
        __block DDNaviMenuView *naviMenuView = [[DDNaviMenuView alloc] initWithFrame:CGRectZero];
        naviMenuView.tag = kNaviMenuViewTag;
        naviMenuView.center = CGPointMake(-2 * CGRectGetMidX(self.view.frame),
                                  CGRectGetMidY(self.view.frame) + 10);
        // show
        [UIView animateWithDuration:1 animations:^{
            naviMenuView.center = CGPointMake(CGRectGetMidX(self.view.frame) - 20,
                                      CGRectGetMidY(self.view.frame) + 10);
            // add background view
            _backgroundView.alpha = 0.5;
        } completion:^(BOOL finished) {
            _menuShow = YES;
            [self.view removeGestureRecognizer:_panGesture];
        }];
        
        // disappear
        naviMenuView.handleLeftSwip = ^{
            if (_menuShow) {
                [UIView animateWithDuration:1 animations:^{
                    naviMenuView.center = CGPointMake(-2 * CGRectGetMidX(self.view.frame),
                                                      CGRectGetMidY(self.view.frame) + 10);
                    _backgroundView.alpha = 0;
                } completion:^(BOOL finished) {
                    _menuShow = NO;
                    [self.view addGestureRecognizer:_panGesture];
                    [naviMenuView removeFromSuperview];
                }];
            }
        };
        
        [self.view addSubview:naviMenuView];
        [naviMenuView release];
    } else {
        /* show sign */
        // init
        __block DDSignMenuView *signMenuView = [[DDSignMenuView alloc] initWithFrame:CGRectZero];
        signMenuView.tag = kSignMenuViewTag;
        signMenuView.center = CGPointMake(-2 * CGRectGetMidX(self.view.frame),
                                  CGRectGetMidY(self.view.frame) + 10);
        
        // show
        [UIView animateWithDuration:1  animations:^{
             signMenuView.center = CGPointMake(CGRectGetMidX(self.view.frame) - 20,
                                       CGRectGetMidY(self.view.frame) + 10);
             // add background view
             _backgroundView.alpha = 0.5;
            
         } completion:^(BOOL finished) {
             _menuShow = YES;
            [self.view removeGestureRecognizer:_panGesture];
         }];
        
        // disappear
        signMenuView.handleLeftSwip = ^{
            if (_menuShow) {
                [UIView animateWithDuration:1 animations:^{
                    signMenuView.center = CGPointMake(-2 * CGRectGetMidX(self.view.frame),
                                              CGRectGetMidY(self.view.frame) + 10);
                    _backgroundView.alpha = 0;
                } completion:^(BOOL finished) {
                     _menuShow = NO;
                     [self.view addGestureRecognizer:_panGesture];
                     [signMenuView removeFromSuperview];
                }];
            }
        };
        
        [self.view addSubview:signMenuView];
        [signMenuView release];
    }
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
}

@end
