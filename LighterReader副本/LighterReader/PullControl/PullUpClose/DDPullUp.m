//
//  DDPullUp.m
//  「UI」下拉刷新上拉加载
//
//  Created by 萧川 on 14-2-26.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDPullUp.h"

@interface DDPullUp ()
{
    DDRefreshState _lastState; // 记录上次刷新状态
}

// 重新调整页面布局
- (void)adjustFrame;

// 拖动状态为正常状态下的响应
- (void)responseStateNormal;
// 拖动状态为托住但未释放
- (void)responseStatePulling;
// 正在刷新
- (void)responseStateRefreshing;

// 父类中需要调用的方法
// 控件类型
- (DDRefreshType)viewType;
// 合适的拖动值
- (CGFloat)properVerticalPullValue;

// 滚动视图内容超过view的高度
- (CGFloat)scrollViewOverViewHeight;

@end

@implementation DDPullUp

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 移除不需要的控件
        [self.lastUpdate removeFromSuperview];
    }
    return self;
}

+ (instancetype)pullUp
{
    return [[self alloc] init];
}

#pragma mark - 调整控件位置

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];

    // 移除进度指示器
    [self.indicator removeFromSuperview];

    // 控件高度至少容下状态提示文本的高度
    if (CGRectGetHeight(frame) / 2 !=
        CGRectGetHeight(self.status.bounds)) {
        self.status.center = CGPointMake(CGRectGetMidX(frame),
                                         DDRefreshViewHeight / 2);
    }
}

#pragma mark - 重写setter

- (void)setScrollView:(UIScrollView *)scrollView
{
    if (self.scrollView != scrollView) {
        // 移除以前的监视器
        [self.scrollView removeObserver:self forKeyPath:DDRefreshContentSize];
        // 监听scrollView的contentSize变化
        [scrollView addObserver:self
                     forKeyPath:DDRefreshContentSize
                        options:NSKeyValueObservingOptionNew
                        context:nil];
        // 调用父类实现方法，父类方法中会监视contentOffSet,
        // 当向上拖动的时候，contentOffSet值会改变，会根据设置好的监听处理事件来做相应的响应
        // 里面会用到setState方法，故覆盖父类方法来实现自己的具体显示效果
        [super setScrollView:scrollView];
    }
    
    // 重新加载数据后，视图的内容尺寸会发生改变，故需要调整布局
    [self adjustFrame];
}

#pragma mark - 监听方法

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{

    // 调用父类实现方法
    [super observeValueForKeyPath:keyPath
                         ofObject:object
                           change:change
                          context:context];
    // 排除不必要的调用

    if (!self.userInteractionEnabled) {
        return;
    }
    if (  self.alpha == 0) {
        return;
    }
    if (self.isHidden) {
        return;
    }
    // 调整布局
    [self adjustFrame];
}

#pragma mark - 调整布局

- (void)adjustFrame
{
    // 表格的高度
    CGFloat scrollViewHeight = CGRectGetHeight(self.scrollView.frame) -
        (self.scrollViewInsetRecord.top + self.scrollViewInsetRecord.bottom);
    // 显示内容的高度
    CGFloat contentHeight = self.scrollView.contentSize.height;
    // 重设控件的视图位置以及大小
    CGFloat height = scrollViewHeight > contentHeight ? scrollViewHeight : contentHeight;
    self.frame = CGRectMake(0,
                            height,
                            CGRectGetWidth(self.scrollView.bounds),
                            DDRefreshViewHeight);
}

#pragma mark - 设置不同状态对应的动画效果

- (void)setState:(DDRefreshState)state
{    
    // 排出不必要的调用
    if (state == self.state) {
        return;
    }
    // 记录当前状态
    _lastState = self.state;
    
    [super setState:state];

    // 根据不同状态做出不同反应
    switch (state) {
        case DDRefreshStateNormal: // 普通状态, 上拉刷新
            [self responseStateNormal];
            break;
        case DDRefreshStatePulling: // 拉住状态, 松手就更新
            [self responseStatePulling];
            break;
        case DDRefreshStateRefreshing: // 正在刷新
            [self responseStateRefreshing];
            break;
        default:
            break;
    }
}

#pragma mark - 响应状态方法

- (void)responseStateNormal
{
    // 设置状态显示文本
    self.status.text = DDPullUpToRefresh;
    
    // 刚好刷新完毕
    CGFloat animationDuration = DDRefreshAnimationDuration;
    CGFloat overHeight = [self scrollViewOverViewHeight];
    CGPoint offSet = CGPointZero;
    if (DDRefreshStateRefreshing == _lastState &&
        overHeight > 0) {
        offSet = self.scrollView.contentOffset;
        animationDuration = 0.0f;
    }
    
    [UIView animateWithDuration:animationDuration animations:^{
        self.arrow.transform = CGAffineTransformMakeRotation(M_PI);
        UIEdgeInsets inset = self.scrollView.contentInset;
        inset.bottom = self.scrollViewInsetRecord.bottom;
        self.scrollView.contentInset = inset;
    }];
    
    if (!animationDuration) {
        self.scrollView.contentOffset = offSet;
    }
}

- (CGFloat)scrollViewOverViewHeight
{
    CGFloat height = CGRectGetHeight(self.scrollView.frame) -
        (self.scrollViewInsetRecord.top + self.scrollViewInsetRecord.bottom);
    return self.scrollView.contentSize.height - height;
}

- (void)responseStatePulling
{
    self.status.text = DDPullUpReleaseToLoadData;
    [UIView animateWithDuration:DDRefreshAnimationDuration animations:^{
        self.arrow.transform = CGAffineTransformIdentity;
        UIEdgeInsets inset = self.scrollView.contentInset;
        inset.top = self.scrollViewInsetRecord.bottom;
        self.scrollView.contentInset = inset;
    }];
}

- (void)responseStateRefreshing
{
    self.status.text = DDPullUpDataLoading;
    [UIView animateWithDuration:DDRefreshAnimationDuration animations:^{
        self.arrow.transform = CGAffineTransformMakeRotation(M_PI);
        UIEdgeInsets inset = self.scrollView.contentInset;
        CGFloat bottom = self.scrollViewInsetRecord.bottom + DDRefreshViewHeight;
        CGFloat overHeight = [self scrollViewOverViewHeight];
        if (overHeight < 0) {
            bottom -= overHeight;
        }
        inset.bottom = bottom;
        self.scrollView.contentInset = inset;
    }];
}

#pragma mark 父类方法中需要调用的实现

- (DDRefreshType)viewType
{
    return DDRefreshTypePullUp;
}

- (CGFloat)properVerticalPullValue
{
    CGFloat overHeight = [self scrollViewOverViewHeight];
    CGFloat result = self.scrollViewInsetRecord.top;
    if (overHeight > 0) {
        return overHeight - result;
    } else {
        return -result;
    }
}

@end
