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
        
        _threshold = -64;
        _state = DDPullControlStateHidden;
        _dragging = NO;
        _pullControlType = DDPullControlTypeDown;

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
        _titleLabel.text = @"ddd";
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
                         UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
                         if (DDPullControlTypeDown == self.pullControlType) {
                             edgeInsets = UIEdgeInsetsMake(-_threshold, 0, 0, 0);
                         } else {
                             edgeInsets = UIEdgeInsetsMake(_threshold, 0, 0, 0);
                         }
                         scrollView.contentInset = edgeInsets;
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
    CGFloat contentOffsetY = fabs(scrollView.contentOffset.y);
    if(contentOffsetY == -_threshold) {
        CGPoint offset = scrollView.contentOffset;
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [scrollView setContentOffset:offset animated:NO];
        [UIView animateWithDuration:0.4
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

    // 下拉为负、上拉为正 contentOffSetY
    CGFloat contentOffSetY = scrollView.contentOffset.y * self.pullControlType;
    
    if(self.threshold <= contentOffSetY && contentOffSetY < 0) {
        // 托动ing
        self.state = DDPullControlStatePulling;
    } else if(self.threshold > contentOffSetY) {
        // 超过临界值(箭头反向、改变提示文字)，松手会执行Action(显示菊花，改变提示文字)
        self.state = DDPullControlStateOveredThreshold;
    } else {
        // 反方向拖动ing
        self.state = DDPullControlStateHidden;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate {
 
    if(_state == DDPullControlStateStoping) {
        return;
    }
    
    if(_state == DDPullControlStateOveredThreshold) {
        if(_threshold > scrollView.contentOffset.y * self.pullControlType) {
            [scrollView setContentOffset:scrollView.contentOffset animated:NO];
        }
        [self beginAction];
    }
}

@end
