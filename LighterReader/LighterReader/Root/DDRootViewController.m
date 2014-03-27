//
//  DDRootViewController.m
//  LighterReader
//
//  Created by 萧川 on 14-3-26.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDRootViewController.h"
#import "DDMainUIViewController.h"
#import "DDMenuView.h"

@interface DDRootViewController () <UIGestureRecognizerDelegate>

@property (retain, nonatomic) UIPanGestureRecognizer *panGesture;
@property (retain, nonatomic) DDMenuView *menu;
@property (assign, nonatomic, getter = isMenuShow) BOOL menuShow;
@property (retain, nonatomic) UIView *backgroundView;

@end

@implementation DDRootViewController

- (void)dealloc
{
    [_panGesture release];
    [_menu release];
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
    UINavigationController *navi = [[UINavigationController alloc]
                                    initWithRootViewController:mainUIVC];
    navi.navigationBar.barTintColor = [UIColor whiteColor];
    navi.navigationBar.tintColor = [UIColor lightGrayColor];
    mainUIVC.handleMenuBarItemAction = ^{
        [self processMenu];
    };
    [mainUIVC release];
    [self addChildViewController:navi];
    [navi release];
    
    [self.view addSubview:navi.view];
    
    _menu = [[DDMenuView alloc] init];
    
    // init background view
    _backgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
    _backgroundView.alpha = 0;
    _backgroundView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_backgroundView];
}

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

- (void)processMenu
{
    // init
    __block DDMenuView *menu = _menu;
    menu.center = CGPointMake(-2 * CGRectGetMidX(self.view.frame),
                              CGRectGetMidY(self.view.frame) + 10);
    
    // show
    [UIView animateWithDuration:1
                     animations:^{
        menu.center = CGPointMake(CGRectGetMidX(self.view.frame) - 20,
                                  CGRectGetMidY(self.view.frame) + 10);
        // add background view
         _backgroundView.alpha = 0.5;
                         
    }
                     completion:^(BOOL finished) {
                         _menuShow = YES;
                         [_panGesture removeTarget:self
                                            action:@selector(panGestureAction:)];
                     }];
    
    // disappear
    menu.handleLeftSwip = ^{
        if (_menuShow) {
            [UIView animateWithDuration:1
                             animations:^{
                                 menu.center = CGPointMake(-2 * CGRectGetMidX(self.view.frame),
                                                           CGRectGetMidY(self.view.frame) + 10);
                                 _backgroundView.alpha = 0;
                             }
                             completion:^(BOOL finished) {
                                 _menuShow = NO;
                                 [_panGesture addTarget:self
                                                 action:@selector(panGestureAction:)];
                             }];
        }
    };
    
    [self.view addSubview:menu];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:_backgroundView];
    if (point.x > CGRectGetWidth(self.view.bounds) - 40) {
        // close menu
        [_menu swipLeftAction];
    }

}


@end
