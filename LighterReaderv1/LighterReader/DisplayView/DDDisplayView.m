//
//  DDDisplayView.m
//  LighterReader
//
//  Created by 萧川 on 14-3-31.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDDisplayView.h"
#import "DDAppDelegate.h"
#import "DDRootViewController.h"

@interface DDDisplayView () <UIGestureRecognizerDelegate>

// pan gesture action
- (void)panGestureAction:(UIPanGestureRecognizer *)panGesture;

// up transform self
- (void)upTransformSelf;
// down transform upView
- (void)downTransformUpView;
// self identity
- (void)trantransformIdentity;
// upView identity
- (void)upViewTrantransformIdentity;

@end

@implementation DDDisplayView

- (void)dealloc {
    [_upView release];
    [_upSlipCompletionHandler release];
    [_downSlipCompletionHandler release];
    
    [_willUpSliphandler release];
    [_selfIdentityCompletionHandler release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    self = [super initWithFrame:frame style:style];
    if (self) {
        CGRect screenBounds = [[UIScreen mainScreen] bounds];
        self.frame = CGRectMake(0,
                                0,
                                CGRectGetWidth(screenBounds),
                                CGRectGetHeight(screenBounds) - 64);
        self.bounces = NO;
        
        // add pan gesture
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]
                                              initWithTarget:self
                                              action:@selector(panGestureAction:)];
        [self addGestureRecognizer:panGesture];
        [panGesture release];

        // get root and require gesture fail
        DDAppDelegate *ddDelegate = [[UIApplication sharedApplication] delegate];
        DDRootViewController *rootVc = ddDelegate.rootVC;
        UIGestureRecognizer *swip = rootVc.rightSwipGesture;
        [panGesture requireGestureRecognizerToFail:swip];
        
    }
    
    return self;
}

#pragma mark - setter

- (void)setUpView:(UIView *)upView {
    
    if (_upView != upView) {
        [_upView release];
        _upView = [upView retain];
        
    }
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    _upView.center = CGPointMake(CGRectGetMidX(screenBounds),
                                 CGRectGetMidY(screenBounds) -
                                 32 -
                                 CGRectGetHeight(_upView.bounds));
}

#pragma mark - private messages
#pragma mark - gesture action

- (void)panGestureAction:(UIPanGestureRecognizer *)panGesture {

    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    static CGPoint startCenter;
    static CGFloat upViewCenterY;

    if (panGesture.state == UIGestureRecognizerStateBegan) {
        // pan beagin
        startCenter = self.center;
        upViewCenterY = self.upView.center.y;
    }
    
    if (panGesture.state == UIGestureRecognizerStateChanged) {
        // pan changed
        CGPoint translation = [panGesture translationInView:self];
        if (translation.y > 0) {
            // pan down
            self.upView.center = CGPointMake(startCenter.x, upViewCenterY + translation.y);
        } else {
            // will slip up
            if (_willUpSliphandler) {
                self.center = CGPointMake(startCenter.x, startCenter.y + translation.y);
                _willUpSliphandler();
            }
        }
    }
    
    // calculating speed
    CGPoint velocity = [panGesture velocityInView:self];
    CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
    CGFloat slideMult = magnitude / 200;
//    NSLog(@"slideMult = %f", slideMult);
    
    // pan end
    if (panGesture.state == UIGestureRecognizerStateEnded) {
    
        CGPoint translation = [panGesture translationInView:self];
        startCenter = CGPointZero;
        if (translation.y > 0) {
            // down
            if (self.upView.center.y < 0 && slideMult < 1) {
                
                [self upViewTrantransformIdentity];
            } else {
                [self downTransformUpView];
            }
        } else {
            // up
            if (self.center.y > 0 && slideMult < 1) {
                // transformIdentity
                [self trantransformIdentity];
            } else {
                [self upTransformSelf];
            }
        }
    }
}

#pragma mark -  transform

static NSInteger count = 0;

- (void)upTransformSelf {
    
    CGPoint center = self.center;
    [UIView animateWithDuration:0.3 animations:^{
        self.center = CGPointMake(center.x, center.y - CGRectGetHeight(self.frame));
    } completion:^(BOOL finished) {
        if (_upSlipCompletionHandler) {
            _upSlipCompletionHandler();
        }
        NSLog(@"%ld", count++);
    }];
}

- (void)downTransformUpView {

    [UIView animateWithDuration:0.3 animations:^{
        self.upView.center = self.center;
    } completion:^(BOOL finished) {
        if (_downSlipCompletionHandler) {
            _downSlipCompletionHandler();
        }
    }];
}

- (void)trantransformIdentity {
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    [UIView animateWithDuration:0.3 animations:^{
        self.center = CGPointMake(CGRectGetMidX(screenBounds),
                                  CGRectGetMidY(screenBounds) - 32);
    } completion:^(BOOL finished) {
        if (_selfIdentityCompletionHandler) {
            NSLog(@"2");
            _selfIdentityCompletionHandler();
        }
    }];
}

- (void)upViewTrantransformIdentity {
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    [UIView animateWithDuration:0.3 animations:^{
        NSLog(@"333");
        _upView.center = CGPointMake(CGRectGetMidX(screenBounds),
                                     CGRectGetMidY(screenBounds) -
                                     32 -
                                     CGRectGetHeight(_upView.bounds));
    }];
}

@end
