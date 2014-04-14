//
//  DDPullDownControl.m
//  「Demo」PullControlDemo
//
//  Created by 萧川 on 14-4-12.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

NSString * const DDPullDownToAction        = @"Pull to refresh";
NSString * const DDPullDownAction          = @"refresh...";
NSString * const DDPullDownReleaseToAction = @"Release to refresh";

#import "DDPullDownControl.h"

@interface DDPullDownControl ()

@end

@implementation DDPullDownControl

#pragma mark -

- (void)dealloc {
    
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark - override

// 合适的垂直方向拖动的值
- (CGFloat)properVerticalPullValue {

    return self.scrollView.contentInset.top;
}

// 已经移动到父视图上，更新控件界面尺寸(initialize、dealloc会called)
- (void)didMoveToSuperview {
    
    [super didMoveToSuperview];
    
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    self.frame = CGRectMake(0, -kPullControlHeight, width, kPullControlHeight);
    
    _arrowView.bounds = CGRectMake(0, 0, 30, 30);
    _arrowView.center = CGPointMake(CGRectGetMidX(self.bounds) - kPullControlArrowDistancefromCenter,
                                    CGRectGetMidY(self.bounds));
    
    _indicatorView.frame = _arrowView.frame;
    
    _hintLabel.frame = self.bounds;
}

// 设置当前滚动状态
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
            _hintLabel.text = DDPullDownToAction;
            
            [UIView animateWithDuration:0.2 animations:^{
                _arrowView.transform = CGAffineTransformIdentity;
            }];
        }
            break;
        case DDPullControlStateOveredThreshold:
        {
            _hintLabel.text = DDPullDownReleaseToAction;
    
            [UIView animateWithDuration:0.2 animations:^{
                _arrowView.transform = CGAffineTransformMakeRotation(M_PI);

            }];
        }
            break;
        case DDPullControlStateAction:
        {
            _indicatorView.hidden = NO;
            [_indicatorView startAnimating];
            _hintLabel.text = DDPullDownAction;
            _arrowView.hidden = YES;
        }
            break;
        default:
            break;
    }
}

// 结束事务
- (void)endAction {
    
    [super endAction];
    _arrowView.transform = CGAffineTransformMakeRotation(M_PI);
}

@end
