//
//  DDFlipPageViewController.m
//  「Demo」FlipPage
//
//  Created by 萧川 on 14-4-2.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDFlipPageViewController.h"
#import "DDPageViewController.h"

#define kAnimationDuration 0.2

@interface DDFlipPageViewController ()

@property (nonatomic, assign) CGPoint pageViewCenterPointer;
@property (nonatomic, assign) CGPoint upPageViewCenterPointer;
@property (nonatomic, strong) NSMutableArray *pageViews;

@property (nonatomic, assign, getter = isProcessing) BOOL processing;

// pan gesture action
- (void)panGestureAction:(UIPanGestureRecognizer *)panGesture;

// up view go back
- (void)upViewTransformIdentity;
// up view appear
- (void)upViewTransformToAppear;

// appeared page view go back
- (void)appearedPageViewTransformIdentity;
// appeared page view go up
- (void)appearedPageViewTransformToUp;

// upview go to appeaerd view background
- (BOOL)sendUpPageViewToAppearedLocationBack;
// cancel sendUpPageViewToAppearedLocationBack
- (void)sendUpPageViewToAppearedLocationBackCanceled;

// prepared page view to up view location front
- (BOOL)bringPreparedPageViewToUpLocationFront;
// cancel bringPreparedPageViewToUpLocationFront
- (void)bringPreparedPageViewToUpLocationFrontCanceled;

@end

@implementation DDFlipPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    /* ios7 edges */
    UIView *view = [[UIView alloc] init];
    [self.view addSubview:view];
    
    // add pan gesture
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(panGestureAction:)];
    [self.view addGestureRecognizer:panGesture];
    
    // calculate bounds and centers
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect pageViewBounds = CGRectMake(0, 0, CGRectGetWidth(screenBounds),
                                       CGRectGetHeight(screenBounds) - 64);
    
    _pageViewCenterPointer = CGPointMake(CGRectGetMidX(pageViewBounds),
                                         CGRectGetMidY(pageViewBounds) + 64);
    _upPageViewCenterPointer = CGPointMake(CGRectGetMidX(pageViewBounds),
                                           -CGRectGetMidY(pageViewBounds) + 64);

    // init porperty
    _pageViews = [[NSMutableArray alloc] init];
    
    // gengrate page view
    for (int i = 0; i < 2; i++) {
        DDPageViewController *pageVC = [[DDPageViewController alloc] init];
        pageVC.view.bounds = pageViewBounds;
        pageVC.view.center = _pageViewCenterPointer;
   
        [self addChildViewController:pageVC];
        [self.view addSubview:pageVC.view];
        [pageVC didMoveToParentViewController:self];
        [_pageViews addObject:pageVC.view];
        
        pageVC.view.tag = 11 + i;
        
        if (0 == i) {
            pageVC.view.backgroundColor = [UIColor greenColor];
        } else {
            pageVC.view.backgroundColor = [UIColor redColor];
        }
    }
    
    DDPageViewController *upPageVC = [[DDPageViewController alloc] init];
    upPageVC.view.bounds = pageViewBounds;
    upPageVC.view.center = _upPageViewCenterPointer;
    upPageVC.view.tag = 13;
    [self addChildViewController:upPageVC];
    [self.view addSubview:upPageVC.view];
    [upPageVC didMoveToParentViewController:self];
    [_pageViews addObject:upPageVC.view];
    upPageVC.view.backgroundColor = [UIColor yellowColor];

    NSLog(@"%@", self.childViewControllers);
    NSLog(@"%@", self.view.subviews);
}

#pragma mark - pan gesture handler

- (void)panGestureAction:(UIPanGestureRecognizer *)panGesture {

    // calculate velocity
    CGPoint velocity = [panGesture velocityInView:self.view];
    
    switch (panGesture.state) {
        case UIGestureRecognizerStatePossible: {
            NSLog(@"panGesture StatePossible");
        }
            break;
        case UIGestureRecognizerStateBegan: {
            NSLog(@"panGesture StateBegan");
        }
            break;
        case UIGestureRecognizerStateChanged: {
            NSLog(@"panGesture StateChanged");
            
            // pan changed
            CGPoint translation = [panGesture translationInView:self.view];

            if (translation.y > 0) {
                // will silp down
                if ([self bringPreparedPageViewToUpLocationFront]) {
                    // slip down
                    UIView *upPageView = _pageViews[2];
                    upPageView.center = CGPointMake(_pageViewCenterPointer.x,
                                                    _upPageViewCenterPointer.y + translation.y);
                }
            } else {
                // will slip up
                if ([self sendUpPageViewToAppearedLocationBack]) {
                    // slip up
                    UIView *pageView = _pageViews[1];
                    pageView.center = CGPointMake(_pageViewCenterPointer.x,
                                                  _pageViewCenterPointer.y + translation.y);
                }
            }
        }
            break;
        case UIGestureRecognizerStateEnded: {
            NSLog(@"panGesture StateEnded");
            
            // pan end
            CGPoint translation = [panGesture translationInView:self.view];
            NSLog(@"!!!!!!!!!!!!!!!!!!!!!!!!translation.y = %f", translation.y);

            // slip down
            if (translation.y > 0) {
                if (velocity.y > 0) {
                    // wanna down
                    [self upViewTransformToAppear];
                } else {
                    // wanna cancel
                    [self upViewTransformIdentity];
                }
            } else {
                // slip up
                if (velocity.y < 0) {
                    // wanna up
                    [self appearedPageViewTransformToUp];
                } else {
                    // wanna cancel
                    [self appearedPageViewTransformIdentity];
                }
            }
        }
            break;
        case UIGestureRecognizerStateCancelled: {
            NSLog(@"panGesture StateCancelled");
        }
            break;
        case UIGestureRecognizerStateFailed: {
            NSLog(@"panGesture StateFailed");
        }
            break;
        default:
            break;
    }
}

#pragma mark - transform anctions

- (void)upViewTransformIdentity {
    
    if (self.isProcessing) {
        return;
    }
    self.processing = YES;
    
    UIView *upPageView = _pageViews[2];
    [UIView animateWithDuration:kAnimationDuration animations:^{
        upPageView.center = _upPageViewCenterPointer;
    } completion:^(BOOL finished) {
        [self bringPreparedPageViewToUpLocationFrontCanceled];
    }];
}

- (void)upViewTransformToAppear {
    
    if (self.isProcessing) {
        return;
    }
    self.processing = YES;
    
    UIView *upPageView = _pageViews[2];
    [UIView animateWithDuration:kAnimationDuration animations:^{
        upPageView.center = _pageViewCenterPointer;
    } completion:^(BOOL finished) {
        // adjust order
        UIView *needAdjustView = [_pageViews firstObject];
        [_pageViews removeObject:needAdjustView];
        [_pageViews addObject:needAdjustView];
        
        NSLog(@"\n_pageViews =\n %@", _pageViews);
        NSLog(@"<\n%@\n:%@>", NSStringFromSelector(_cmd), self.view.subviews);
        
        self.processing = NO;
    }];
}

- (void)appearedPageViewTransformIdentity {
    
    if (self.isProcessing) {
        return;
    }
    self.processing = YES;
    
    UIView *appearedPageView = _pageViews[1];
    [UIView animateWithDuration:kAnimationDuration animations:^{
        appearedPageView.center = _pageViewCenterPointer;
    } completion:^(BOOL finished) {
        [self sendUpPageViewToAppearedLocationBackCanceled];
    }];
}

- (void)appearedPageViewTransformToUp {
    
    if (self.isProcessing) {
        return;
    }
    self.processing = YES;
 
    UIView *appearedPageView = _pageViews[1];
    [UIView animateWithDuration:kAnimationDuration animations:^{
        appearedPageView.center = _upPageViewCenterPointer;
    } completion:^(BOOL finished) {
        // adjust order
        UIView *needAdjustView = [_pageViews lastObject];
        [_pageViews removeObject:needAdjustView];
        [_pageViews insertObject:needAdjustView atIndex:0];
    
        NSLog(@"22222");
        NSLog(@"\n_pageViews =\n %@", _pageViews);
        NSLog(@"<\n%@\n:%@>", NSStringFromSelector(_cmd), self.view.subviews);
        
        self.processing = NO;
    }];
}

- (BOOL)sendUpPageViewToAppearedLocationBack {

    BOOL invoke = NO;
    
    if (self.isProcessing) {
        return invoke;
    }
    self.processing = YES;
    
    UIView *upPageView = _pageViews[2];

    // this few statements will called repeatedly
    upPageView.center = _pageViewCenterPointer;
    [self.view sendSubviewToBack:upPageView];
    NSLog(@"<\n%@\n:%@>", NSStringFromSelector(_cmd), self.view.subviews);
    NSLog(@"准备");
    invoke = YES;
    
    self.processing = NO;
    return invoke;
}

- (void)sendUpPageViewToAppearedLocationBackCanceled {

    UIView *upPageView = _pageViews[2];
//    if (upPageView.center.y != _upPageViewCenterPointer.y) {
        upPageView.center = _upPageViewCenterPointer;
        [self.view bringSubviewToFront:upPageView];
        
        NSLog(@"<\n%@\n:%@>", NSStringFromSelector(_cmd), self.view.subviews);
//    }

    self.processing = NO;
}

- (BOOL)bringPreparedPageViewToUpLocationFront {

    BOOL invoke = NO;
    if (self.isProcessing) {
        return invoke;
    }
    self.processing = YES;

    // this few statements will called repeatedly
    UIView *prepatedPageView =  _pageViews[0];
    prepatedPageView.center = _upPageViewCenterPointer;
    [self.view bringSubviewToFront:prepatedPageView];
    
    NSLog(@"<\n%@\n:%@>", NSStringFromSelector(_cmd), self.view.subviews);
    invoke = YES;

    self.processing = NO;
    
    return invoke;
}

- (void)bringPreparedPageViewToUpLocationFrontCanceled {
    
    UIView *prepatedPageView =  _pageViews[0];
//    if (prepatedPageView.center.y != _pageViewCenterPointer.y) {
        prepatedPageView.center = _pageViewCenterPointer;
        [self.view sendSubviewToBack:prepatedPageView];
        
        NSLog(@"<\n%@\n:%@>", NSStringFromSelector(_cmd), self.view.subviews);
//    }
    self.processing = NO;
}

@end
