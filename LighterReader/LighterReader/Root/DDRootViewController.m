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
@interface DDRootViewController ()

@property (assign, nonatomic, getter = isMenuShow) BOOL menuShow;
@property (strong, nonatomic) UIView *backgroundView;

@end

@implementation DDRootViewController


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

    /* very import */
    DDAppDelegate *ddDelegate = [[UIApplication sharedApplication] delegate];
    ddDelegate.rootVC = self;
    
    _rightSwipGesture = [[UISwipeGestureRecognizer  alloc]
                     initWithTarget:self
                     action:@selector(rightSwipGestureAction:)];
    _rightSwipGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:_rightSwipGesture];

    // add main UI view controller
    DDMainUIViewController *mainUIVC = [[DDMainUIViewController alloc] init];
    mainUIVC.handleMenuBarItemAction = ^{
        [self processMenu];
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

- (void)swipRightAction
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)rightSwipGestureAction:(UISwipeGestureRecognizer *)rightSwipGesture {

     NSLog(@"%@", NSStringFromSelector(_cmd));
    if ([rightSwipGesture locationInView:self.view].x < 30 &&
        _menuShow == NO) {
        [self processMenu];
    }
}

- (void)processMenu {
    
//    _login = YES;
    if (_login) {
        /* show navi menu */
        // init
        DDNaviMenuView *naviMenuViewStrong = [[DDNaviMenuView alloc]
                                                initWithFrame:CGRectZero];
        __weak DDNaviMenuView *naviMenuView = naviMenuViewStrong;
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
            [self.view removeGestureRecognizer:_rightSwipGesture];
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
                    [self.view addGestureRecognizer:_rightSwipGesture];
                    [naviMenuView removeFromSuperview];
                }];
            }
        };
        
        [self.view addSubview:naviMenuView];
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
        [UIView animateWithDuration:1  animations:^{
             signMenuView.center = CGPointMake(CGRectGetMidX(self.view.frame) - 20,
                                       CGRectGetMidY(self.view.frame) + 10);
             // add background view
             _backgroundView.alpha = 0.5;
            
         } completion:^(BOOL finished) {
             _menuShow = YES;
            [self.view removeGestureRecognizer:_rightSwipGesture];
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
                     [self.view addGestureRecognizer:_rightSwipGesture];
                     [signMenuView removeFromSuperview];
                }];
            }
        };
        
        [self.view addSubview:signMenuView];
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
