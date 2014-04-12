//
//  DDPullDownControl.m
//  「Demo」PullControlDemo
//
//  Created by 萧川 on 14-4-12.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

NSString * const DDPullDownToAction        = @"Pull to refresh";
NSString * const DDPullDownAction          = @"Loading...";
NSString * const DDPullDownReleaseToAction = @"Release to refresh";

#import "DDPullDownControl.h"

@interface DDPullDownControl ()

@end

@implementation DDPullDownControl

- (void)dealloc {
    
    NSLog(@"%s", __FUNCTION__);
}

- (void)didMoveToSuperview {
    
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    self.frame = CGRectMake(0, _threshold, width, -_threshold);
    
    _arrowView.bounds = CGRectMake(0, 0, 30, 30);
    _arrowView.center = CGPointMake(CGRectGetMidX(self.bounds) - kArrowDistancefromCenter,
                                    CGRectGetMidY(self.bounds));
    
    _indicatorView.frame = _arrowView.frame;
    
    _titleLabel.frame = self.bounds;
}

- (void)setState:(DDPullControlState)state {
    
    [super setState:state];
    
    switch(state) {
        case DDPullControlStateHidden:
        {
            _indicatorView.hidden = YES;
            [_indicatorView stopAnimating];
            _arrowView.hidden = NO;
        }
            break;
        case DDPullControlStatePulling:
        {
            self.titleLabel.text = DDPullDownToAction;
            
            [UIView animateWithDuration:0.2 animations:^{
                _arrowView.transform = CGAffineTransformIdentity;
            }];
        }
            break;
        case DDPullControlStateOveredThreshold:
        {
            self.titleLabel.text = DDPullDownReleaseToAction;
    
            [UIView animateWithDuration:0.2 animations:^{
                _arrowView.transform = CGAffineTransformMakeRotation(M_PI);

            }];
        }
            break;
        case DDPullControlStateStoping:
        {
            _indicatorView.hidden = NO;
            [_indicatorView startAnimating];
            self.titleLabel.text = DDPullDownAction;
            _arrowView.hidden = YES;
        }
            break;
        default:
            break;
    }
}

- (void)endAction {
    
    [super endAction];
    _arrowView.transform = CGAffineTransformMakeRotation(M_PI);
}

@end
