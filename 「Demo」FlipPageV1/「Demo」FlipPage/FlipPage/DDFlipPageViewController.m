//
//  DDFlipPageViewController.m
//  「Demo」上下翻页
//
//  Created by 萧川 on 14-4-2.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDFlipPageViewController.h"
#import "DDPageView.h"

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
- (void)sendUpPageViewToAppearedLocationBack;
// cancel sendUpPageViewToAppearedLocationBack
- (void)sendUpPageViewToAppearedLocationBackCanceled;

// prepared page view to up view location front
- (void)bringPreparedPageViewToUpLocationFront;
// cancel bringPreparedPageViewToUpLocationFront
- (void)bringPreparedPageViewToUpLocationFrontCanceled;

// swip gesture action
- (void)swipGestureAction:(UISwipeGestureRecognizer *)swipGestureRecognizer;

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
    
    // add pan gesture
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(panGestureAction:)];
    [self.view addGestureRecognizer:panGesture];

    // add swip gesture
    UISwipeGestureRecognizer *swipUp = [[UISwipeGestureRecognizer alloc]
                                        initWithTarget:self
                                        action:@selector(swipGestureAction:)];
    swipUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipUp];
    
    UISwipeGestureRecognizer *swipDown = [[UISwipeGestureRecognizer alloc]
                                        initWithTarget:self
                                        action:@selector(swipGestureAction:)];
    swipDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipDown];
    
    // require swip fail
    [panGesture requireGestureRecognizerToFail:swipUp];
    [panGesture requireGestureRecognizerToFail:swipDown];
    
    // calculate bounds and centers
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect pageViewBounds = CGRectMake(0, 0, CGRectGetWidth(screenBounds),
                                       CGRectGetHeight(screenBounds) - 64);
    
    _pageViewCenterPointer = CGPointMake(CGRectGetMidX(pageViewBounds),
                                         CGRectGetMidY(screenBounds) + 32);
    _upPageViewCenterPointer = CGPointMake(CGRectGetMidX(pageViewBounds),
                                           -CGRectGetMidY(pageViewBounds) + 32);

    // init porperty
    _pageViews = [[NSMutableArray alloc] init];
    
    // gengrate page view
    for (int i = 0; i < 2; i++) {
        DDPageView *pageView = [[DDPageView alloc] init];
        pageView.bounds = pageViewBounds;
        pageView.center = _pageViewCenterPointer;
        [self.view addSubview:pageView];
        
        [_pageViews addObject:pageView];
        pageView.tag = 11 + i;
        if (0 == i) {
            pageView.backgroundColor = [UIColor yellowColor];
        } else {
            pageView.backgroundColor = [UIColor greenColor];
        }
    }
    
    DDPageView *upPageView = [[DDPageView alloc] init];
    upPageView.bounds = pageViewBounds;
    upPageView.center = _upPageViewCenterPointer;
    [self.view addSubview:upPageView];
    [_pageViews addObject:upPageView];
    upPageView.tag = 13;
    upPageView.backgroundColor = [UIColor redColor];
    
    NSLog(@"%@", self.view.subviews);
}

#pragma mark - pan gesture handler

- (void)panGestureAction:(UIPanGestureRecognizer *)panGesture {

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
                [self bringPreparedPageViewToUpLocationFront];
                
                // slip down
                DDPageView *upPageView = _pageViews[2];
                upPageView.center = CGPointMake(_pageViewCenterPointer.x,
                                                _upPageViewCenterPointer.y + translation.y);
            } else {
                // will slip up
                [self sendUpPageViewToAppearedLocationBack];
                
                // slip up
                DDPageView *pageView = _pageViews[1];
                pageView.center = CGPointMake(_pageViewCenterPointer.x,
                                              _pageViewCenterPointer.y + translation.y);
            }
        }
            break;
        case UIGestureRecognizerStateEnded: {
            NSLog(@"panGesture StateEnded");
            
            // pan end
            CGPoint translation = [panGesture translationInView:self.view];

            if (translation.y > 0) {
                // slip down
                DDPageView *upPageView = _pageViews[2];
                if (upPageView.center.y < 0) {
                    [self upViewTransformIdentity];
                } else {
                    [self upViewTransformToAppear];
                }
            } else {
                // slip up
                DDPageView *appearedPageView = _pageViews[1];
                if (appearedPageView.center.y > 0) {
                    [self appearedPageViewTransformIdentity];
                } else {
                    [self appearedPageViewTransformToUp];
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
    
    DDPageView *upPageView = _pageViews[2];
    [UIView animateWithDuration:0.3 animations:^{
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
    
    DDPageView *upPageView = _pageViews[2];
    [UIView animateWithDuration:0.3 animations:^{
        upPageView.center = _pageViewCenterPointer;
    } completion:^(BOOL finished) {
        // adjust order
        DDPageView *needAdjustView = [_pageViews firstObject];
        [_pageViews removeObject:needAdjustView];
        [_pageViews addObject:needAdjustView];
    
        self.processing = NO;
        
        NSLog(@"\n_pageViews =\n %@", _pageViews);
        NSLog(@"<\n%@\n:%@>", NSStringFromSelector(_cmd), self.view.subviews);
    }];
}

- (void)appearedPageViewTransformIdentity {
    
    if (self.isProcessing) {
        return;
    }
    self.processing = YES;
    
    DDPageView *appearedPageView = _pageViews[1];
    [UIView animateWithDuration:0.3 animations:^{
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
    
    DDPageView *appearedPageView = _pageViews[1];
    [UIView animateWithDuration:0.3 animations:^{
        appearedPageView.center = _upPageViewCenterPointer;
    } completion:^(BOOL finished) {
        // adjust order
        DDPageView *needAdjustView = [_pageViews lastObject];
        [_pageViews removeObject:needAdjustView];
        [_pageViews insertObject:needAdjustView atIndex:0];
        
        self.processing = NO;
        
        NSLog(@"\n_pageViews =\n %@", _pageViews);
        NSLog(@"<\n%@\n:%@>", NSStringFromSelector(_cmd), self.view.subviews);
    }];
}

- (void)sendUpPageViewToAppearedLocationBack {
    
    if (self.isProcessing) {
        return;
    }
    self.processing = YES;
    
    DDPageView *upPageView = _pageViews[2];
    if (upPageView.center.y != _pageViewCenterPointer.y) {
        upPageView.center = _pageViewCenterPointer;
        [self.view sendSubviewToBack:upPageView];
        
        NSLog(@"<\n%@\n:%@>", NSStringFromSelector(_cmd), self.view.subviews);
    }
    
    self.processing = NO;
}

- (void)sendUpPageViewToAppearedLocationBackCanceled {
    
    DDPageView *upPageView = _pageViews[2];
    if (upPageView.center.y != _upPageViewCenterPointer.y) {
        upPageView.center = _upPageViewCenterPointer;
        [self.view bringSubviewToFront:upPageView];
        
        NSLog(@"<\n%@\n:%@>", NSStringFromSelector(_cmd), self.view.subviews);
    }

    self.processing = NO;
}

- (void)bringPreparedPageViewToUpLocationFront {
    
    if (self.isProcessing) {
        return;
    }
    self.processing = YES;
    
    DDPageView *prepatedPageView =  _pageViews[0];
    if (prepatedPageView.center.y != _upPageViewCenterPointer.y) {
        prepatedPageView.center = _upPageViewCenterPointer;
        [self.view bringSubviewToFront:prepatedPageView];
        
        NSLog(@"<\n%@\n:%@>", NSStringFromSelector(_cmd), self.view.subviews);
    }
    self.processing = NO;
}

- (void)bringPreparedPageViewToUpLocationFrontCanceled {

    DDPageView *prepatedPageView =  _pageViews[0];
    if (prepatedPageView.center.y != _pageViewCenterPointer.y) {
        prepatedPageView.center = _pageViewCenterPointer;
        [self.view sendSubviewToBack:prepatedPageView];
        
        NSLog(@"<\n%@\n:%@>", NSStringFromSelector(_cmd), self.view.subviews);
    }
    self.processing = NO;
}

#pragma mark - swip gesture handler

- (void)swipGestureAction:(UISwipeGestureRecognizer *)swipGestureRecognizer {
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
    if (swipGestureRecognizer.direction == UISwipeGestureRecognizerDirectionUp) {
        // swip up
        [self sendUpPageViewToAppearedLocationBack];
        [self appearedPageViewTransformToUp];
    } else {
        // swip down
        [self bringPreparedPageViewToUpLocationFront];
        [self upViewTransformToAppear];
    }
}

@end
