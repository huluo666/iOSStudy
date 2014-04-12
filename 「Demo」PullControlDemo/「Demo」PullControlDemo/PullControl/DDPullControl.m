//
//  DDPullControl.m
//  「Demo」PullControlDemo
//
//  Created by 萧川 on 14-4-12.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDPullControl.h"

@interface DDPullControl ()

// 滚动视图正在滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
// 滚动视图结束拖动、将要减速
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate;
// 将要移动到父视图
- (void)willMoveToSuperview:(UIView *)newSuperview;

@end

@implementation DDPullControl

- (void)dealloc {
    
    [[self scrollView] removeObserver:self forKeyPath:@"contentOffset"];
    NSLog(@"%s", __FUNCTION__);
}

// init

//- (id)init
//{
//    self = [super init];
//    if (self) {
//        _threshold = -60;
//        _state = DDPullControlStateHidden;
//        _dragging = NO;
//    }
//    return self;
//}

- (id)init
{
    self = [super init];
    if (self) {
        
        _threshold = -60;
        _state = DDPullControlStateHidden;
        _dragging = NO;

        self.backgroundColor= [UIColor clearColor];
        
        // arrow
        _arrowView = [[UIImageView alloc] init];

        _arrowView.image = DDImageWithName(@"arrow");
        [self addSubview:_arrowView];
        
        // indicator view
        _indicatorView = [[UIActivityIndicatorView alloc]
                          initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:_indicatorView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = kTitleLabelPullText;
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
        [self addSubview:_titleLabel];
    }
    return self;
}

#pragma mark - overide

//- (void)setFrame:(CGRect)frame {
//    
//    frame.origin.y = -frame.size.height;
//    
//    [super setFrame:frame];
//}

- (UIScrollView *)scrollView {
    
    UIScrollView *scrollView = (UIScrollView *)[self superview];
    
    if(![scrollView isKindOfClass:[UIScrollView class]]) {
        scrollView = nil;
    }

    return scrollView;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if([self scrollView] != nil) {
        [[self scrollView] removeObserver:self forKeyPath:@"contentOffset"];
    }
    
    if([newSuperview isKindOfClass:[UIScrollView class]]) {
//        self.frame = CGRectMake(0,
//                                -CGRectGetHeight(self.bounds),
//                                CGRectGetWidth(self.bounds),
//                                CGRectGetHeight(self.bounds));
        
        [newSuperview addObserver:self
                       forKeyPath:@"contentOffset"
                          options:NSKeyValueObservingOptionNew
                          context:NULL];
    }
}

#pragma mark - actions

- (void)beginAction {
    
    if([_delegate respondsToSelector:@selector(pullControlWillBeginAction:)]) {
        [_delegate pullControlWillBeginAction:self];
    }
    
    [self setState:DDPullControlStateStoping];
    
    UIScrollView *scrollView = self.scrollView;
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
        scrollView.contentInset = UIEdgeInsetsMake(-_threshold, 0, 0, 0);
                     }
                     completion:NULL];
    
    if([_delegate respondsToSelector:@selector(pullControlDidBeginAction:)]) {
        [_delegate pullControlDidBeginAction:self];
    }

}

- (void)endAction {

    if([_delegate respondsToSelector:@selector(pullControlWillEndAction:)]) {
        [_delegate pullControlWillEndAction:self];
    }
    
    UIScrollView *scrollView = self.scrollView;
    
    if(scrollView.contentOffset.y < 0) {
        CGPoint offset = scrollView.contentOffset;
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [scrollView setContentOffset:offset animated:NO];
        
        [UIView animateWithDuration:0.2
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
            scrollView.contentOffset = CGPointMake(0, 0);
        }
                         completion:NULL];
    } else {
        scrollView.contentInset = UIEdgeInsetsZero;
    }
    
    [self setState:DDPullControlStateHidden];
    
    if([_delegate respondsToSelector:@selector(pullControlDidEndAction:)]) {
        [_delegate pullControlDidEndAction:self];
    }

}

#pragma mark - kvo

// kvo monitor message
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    
    if([keyPath isEqualToString:@"contentOffset"]) {
        UIScrollView *scrollView = (UIScrollView *)object;
        
        if(_dragging != scrollView.isDragging) {
            if(!scrollView.isDragging) {
                [self scrollViewDidEndDragging:scrollView willDecelerate:NO];
            }
            
            _dragging = scrollView.isDragging;
        }
        
        [self scrollViewDidScroll:scrollView];
    }
}

#pragma mark - private messages

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if(_state == DDPullControlStateStoping) {
        return;
    }
    NSLog(@"_threshold = %f", _threshold);
    NSLog(@"-contentOffset.y = %f", -scrollView.contentOffset.y);
    if(_threshold <= scrollView.contentOffset.y) {
        NSLog(@"111111");
        if (scrollView.contentOffset.y < 0) {
            [self setState:DDPullControlStatePullingDown];
        } else {
            [self setState:DDPullControlStatePullingUp];
        }
    } else if(_threshold > scrollView.contentOffset.y) {
        NSLog(@"222222");
        [self setState:DDPullControlStateOveredThreshold];
    } else {
        NSLog(@"3333");
        [self setState:DDPullControlStateHidden];
        NSLog(@"DDPullControlStateHidden");
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate {
 
    if(_state == DDPullControlStateStoping) {
        return;
    }
    
    if(_state == DDPullControlStateOveredThreshold) {
        if(scrollView.contentOffset.y < _threshold) {
            [scrollView setContentOffset:scrollView.contentOffset animated:NO];
        }
        
        [self beginAction];
    }
}

@end
