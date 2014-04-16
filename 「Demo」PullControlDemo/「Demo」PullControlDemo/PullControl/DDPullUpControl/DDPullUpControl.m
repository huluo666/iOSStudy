//
//  DDPullUpControl.m
//  「Demo」PullControlDemo
//
//  Created by 萧川 on 14-4-12.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

NSString * const DDPullUpToAction          = @"Pull up to loading";
NSString * const DDPullUpAction            = @"Loading...";
NSString * const DDPullUpReleaseToAction   = @"Release to loading";

#import "DDPullUpControl.h"

@interface DDPullUpControl ()

// 调整控件frame
- (void)adjustFrame;

@end

@implementation DDPullUpControl

#pragma mark -

- (void)dealloc {
    
    NSLog(@"%s", __FUNCTION__);
}

- (id)init
{
    self = [super init];
    if (self) {
        _pullControlType     = DDPullControlTypeUp;
        
        _pullToAction        = DDPullUpToAction;
        _pullAction          = DDPullUpAction;
        _pullReleaseToAction = DDPullUpReleaseToAction;
    }
    return self;
}

#pragma mark - override

- (void)willMoveToSuperview:(UIView *)newSuperview {

    [super willMoveToSuperview:newSuperview];
    
    if([self scrollView] != nil) {
        [[self scrollView] removeObserver:self forKeyPath:@"contentSize"];
    }
    
    if([newSuperview isKindOfClass:[UIScrollView class]]) {
        [newSuperview addObserver:self
                       forKeyPath:@"contentSize"
                          options:NSKeyValueObservingOptionNew
                          context:NULL];
        
    }
}

// 已经移动到父视图上，更新控件界面尺寸
- (void)didMoveToSuperview {
    
    [super didMoveToSuperview];
    
    [self adjustFrame];
    
    _arrowView.bounds = CGRectMake(0, 0, 30, 30);
    _arrowView.center = CGPointMake(CGRectGetMidX(self.bounds) - kPullControlArrowDistancefromCenter,
                                    CGRectGetMidY(self.bounds));
    
    _indicatorView.frame = _arrowView.frame;
    _hintLabel.frame = self.bounds;
}

// 设置状态
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
            if (_showsScrollIndicatorPolicy) {
                self.scrollView.showsVerticalScrollIndicator = YES;
            }
            _hintLabel.text = _pullToAction;
            
            [UIView animateWithDuration:0.2 animations:^{
                _arrowView.transform = CGAffineTransformMakeRotation(M_PI);
            }];
        }
            break;
        case DDPullControlStateOveredThreshold:
        {
            if (_showsScrollIndicatorPolicy) {
                self.scrollView.showsVerticalScrollIndicator = NO;
            }
            _hintLabel.text = _pullReleaseToAction;
            
            [UIView animateWithDuration:0.2 animations:^{
                _arrowView.transform = CGAffineTransformIdentity;
            }];
        }
            break;
        case DDPullControlStateAction:
        {
            _indicatorView.hidden = NO;
            [_indicatorView startAnimating];
            _hintLabel.text = _pullAction;
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
    _arrowView.transform = CGAffineTransformIdentity;
}

// 合适的垂直拖动值
- (CGFloat)properVerticalPullValue {
    
    CGFloat overHeight = [self scrollViewOverViewHeight];
    CGFloat result = self.scrollViewInsetRecord.top;
    if (overHeight > 0) {
        return overHeight - result;
    } else {
        return -result;
    }
}

#pragma mark - private messages

// 父视图contentSize变化时，调整该控件位置
- (void)adjustFrame {

#pragma mark - 不做判断一个控制器同时加载多个该控件会崩溃！！！！
    
    if (!self.scrollView) {
        return;
    }
    
    // 内容的高度
    CGFloat contentHeight = self.scrollView.contentSize.height;
    // 滚动视图的高度
    CGFloat insetHeight = self.scrollViewInsetRecord.top + self.scrollViewInsetRecord.bottom;
    CGFloat scrollViewHeight = CGRectGetHeight(self.scrollView.frame) - insetHeight;
    // 重设控件的视图位置以及大小
    CGFloat y = MAX(contentHeight, scrollViewHeight);
    // 设置边框
    self.frame = CGRectMake(0, y, CGRectGetWidth(self.scrollView.frame), kPullControlHeight);
}

// 滚动视图内容超过控件视图的高度
- (CGFloat)scrollViewOverViewHeight {
    
    CGFloat insetHeight = self.scrollViewInsetRecord.top + self.scrollViewInsetRecord.bottom;
    CGFloat height = CGRectGetHeight(self.scrollView.frame) - insetHeight;
    return self.scrollView.contentSize.height - height;
}

#pragma mark - kvo

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    [self adjustFrame];
}

@end
