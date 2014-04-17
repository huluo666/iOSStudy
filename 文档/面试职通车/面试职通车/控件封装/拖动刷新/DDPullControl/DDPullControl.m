//
//  DDPullControl.m
//  「Demo」PullControlDemo
//
//  Created by 萧川 on 14-4-12.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDPullControl.h"

@interface DDPullControl () <UIScrollViewDelegate>

@property (nonatomic, assign, getter = hasInitInset) BOOL initInset;

@end

@implementation DDPullControl

#pragma mark -

- (void)dealloc {

    NSLog(@"%s", __FUNCTION__);
}

// 初始化子控件
- (id)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor= [UIColor clearColor];
        _state = DDPullControlStateHidden;
        
        _pullControlType = DDPullControlTypeDown;

        // arrow
        _arrowView = [[UIImageView alloc] init];

        _arrowView.image = DDImageWithName(@"DDPullControlArrow");
        [self addSubview:_arrowView];
        
        // indicator view
        _indicatorView = [[UIActivityIndicatorView alloc]
                          initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:_indicatorView];
        
        _hintLabel = [[UILabel alloc] init];
        _hintLabel.textColor = [UIColor grayColor];
        _hintLabel.textAlignment = NSTextAlignmentCenter;
        _hintLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
        [self addSubview:_hintLabel];
        
        _showsScrollIndicatorPolicy = YES;
    }
    return self;
}

#pragma mark - override

// 获取父视图
- (UIScrollView *)scrollView {
    
    UIScrollView *scrollView = (UIScrollView *)[self superview];
    
    if(![scrollView isKindOfClass:[UIScrollView class]]) {
        scrollView = nil;
    }

    return scrollView;
}

// 父视图发生改变时调用，(**初始化、dealloc前会调用**)
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

// 刷新加载数据后滚动视图的内容尺寸大小发生改变，需要重新布局，会调用该方法
/*
 * layoutSubviews在以下情况下会被调用：
 *
 * 1、init初始化不会触发layoutSubviews
 * 2、addSubview会触发layoutSubviews
 * 3、设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化
 * 4、滚动一个UIScrollView会触发layoutSubviews
 * 5、旋转Screen会触发父UIView上的layoutSubviews事件
 * 6、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    if (!self.initInset) {
        _scrollViewInsetRecord = self.scrollView.contentInset;
        
        [self observeValueForKeyPath:@"contentSize"
                            ofObject:nil
                              change:nil
                             context:nil];
        _initInset = YES;
        if (_state == DDPullControlStateAction) {
            [self setState:DDPullControlStateAction];
        }
    }
}

#pragma mark - kvo

// kvo monitor message
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    
    if(![keyPath isEqualToString:@"contentOffset"]) {
        return;
    }
    
    UIScrollView *scrollView = (UIScrollView *)object;
    if(_dragging != scrollView.isDragging) {
        if(!scrollView.isDragging) {
            [self scrollViewDidEndDragging:scrollView willDecelerate:NO];
        }
        
        _dragging = scrollView.isDragging;
    }
    [self scrollViewDidScroll:scrollView];
}

#pragma mark - <UIScrollViewDelegate>

// 父视图开始被拖动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
//    NSLog(@"type = %d", [self pullControlType]);
    
    // pullControlType:下拉为-1，上拉为+1
    CGFloat contentOffSetVerticalValue = scrollView.contentOffset.y * [self pullControlType];
//    NSLog(@"1: contentOffSetVerticalValue = %f", contentOffSetVerticalValue);
    CGFloat properVerticalPullValue = [self properVerticalPullValue];
//    NSLog(@"2: properVerticalPullValue = %f", properVerticalPullValue);
    
    // 排除反方向拖动
    if (contentOffSetVerticalValue <=  properVerticalPullValue) {
        return;
    }
    
    // 正在执行事务(如刷新)、不监视，处于停止状态
    if(_state == DDPullControlStateAction) {
        return;
    }
    
    CGFloat properContentOffsetVerticalValue = properVerticalPullValue + kPullControlHeight;
//    NSLog(@"3: properContentOffsetVerticalValue = %f", properContentOffsetVerticalValue);
    
    if (contentOffSetVerticalValue <= properContentOffsetVerticalValue ) {
        // 正在拖动，但是还没有到临界点
        [self setState:DDPullControlStatePulling];
    } else if (contentOffSetVerticalValue > properContentOffsetVerticalValue) {
        // 超过临界点(箭头反向、改变提示文字)，松手会执行Action(显示菊花，改变提示文字)
        [self setState:DDPullControlStateOveredThreshold];
    } else {
        // 反方向拖动、根本进不来
        [self setState:DDPullControlStateHidden];
    }
}

// 父视图停止被拖动、将要减速
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate {
    
    if(_state == DDPullControlStateAction) {
        return;
    }
    
    if (DDPullControlStateOveredThreshold == [self state]) {
        _scrollViewInsetRecord = scrollView.contentInset;
        // 执行事务
        [self beginAction];
    }
}

#pragma mark - actions

// 开始执行事务
- (void)beginAction {
    
    if([_delegate respondsToSelector:@selector(pullControlWillBeginAction:)]) {
        [_delegate pullControlWillBeginAction:self];
    }
    if (_pullControlWillBeginAction) {
        _pullControlWillBeginAction(self);
    }
    
    [self setState:DDPullControlStateAction];
    
    // 控件滚动到合适位置停留
    if (DDPullControlTypeDown == [self pullControlType]) {
        // 下拉控件
        [UIView animateWithDuration:0.2 animations:^{
            UIEdgeInsets inset = self.scrollView.contentInset;
            inset.top = self.scrollViewInsetRecord.top + kPullControlHeight;
            self.scrollView.contentInset = inset;
            // 设置滚动停留的位置
            self.scrollView.contentOffset =
                CGPointMake(0, -self.scrollViewInsetRecord.top - kPullControlHeight);
        }];
    } else {
        // 上拉控件
        [UIView animateWithDuration:0.2 animations:^{
            UIEdgeInsets inset = self.scrollView.contentInset;
            CGFloat bottom = self.scrollViewInsetRecord.bottom + kPullControlHeight;
            CGFloat overHeight = [self scrollViewOverViewHeight];
            if (overHeight < 0) {
                bottom -= overHeight;
            }
            inset.bottom = bottom;
            // 设置滚动停留的位置
            self.scrollView.contentInset = inset;
        }];
    }
    
    if([_delegate respondsToSelector:@selector(pullControlDidBeginAction:)]) {
        [_delegate pullControlDidBeginAction:self];
    }
    if (_pullControlDidBeginAction) {
        _pullControlDidBeginAction(self);
    }
}

// 结束执行事务
- (void)endAction {

    if (_showsScrollIndicatorPolicy) {
        self.scrollView.showsVerticalScrollIndicator = YES;
    }
    
    if([_delegate respondsToSelector:@selector(pullControlWillEndAction:)]) {
        [_delegate pullControlWillEndAction:self];
    }
    if (_pullControlWillEndAction) {
        _pullControlWillEndAction(self);
    }

    // 事务执行完成
    if (DDPullControlTypeDown == [self pullControlType]) {
        // 下拉控件，滚到父视图头部以上刚好看不见位置(还原inset)
        UIEdgeInsets inset = self.scrollView.contentInset;
        inset.top = self.scrollViewInsetRecord.top;
        [UIView animateWithDuration:0.2 animations:^{
            self.scrollView.contentInset = inset;
        }];
    } else {
        /* 加载完成，内容没有占满整屏，contentOffset伴随动画回到zero */
        
        CGPoint tempOffset = CGPointZero;
        CGFloat animtionDuration = 0.2;
        CGFloat screenHeight = CGRectGetHeight([[UIScreen mainScreen] bounds]);
        if (self.scrollView.contentSize.height + kPullControlHeight > screenHeight) {
            tempOffset = self.scrollView.contentOffset;
            animtionDuration = 0;
        }
        
        // 内容未超过屏幕底端时animtionDuration ！= 0
        [UIView animateWithDuration:animtionDuration animations:^{
            UIEdgeInsets inset = self.scrollView.contentInset;
            inset.bottom = self.scrollViewInsetRecord.bottom;
            self.scrollView.contentInset = inset;
        }];
        
        // 内容超过屏幕底端，不出现回滚动画，直接加载数据，控件`消失`
        if (animtionDuration == 0) {
            self.scrollView.contentOffset = tempOffset;
        }
    }
    
    [self setState:DDPullControlStateHidden];
    
    if([_delegate respondsToSelector:@selector(pullControlDidEndAction:)]) {
        [_delegate pullControlDidEndAction:self];
    }
    if (_pullControlDidEndAction) {
        _pullControlDidEndAction(self);
    }
}

@end
