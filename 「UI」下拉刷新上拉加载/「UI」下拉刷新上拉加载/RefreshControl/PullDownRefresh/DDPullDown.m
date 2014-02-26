//
//  DDPullDown.m
//  「UI」下拉刷新上拉加载
//
//  Created by 萧川 on 14-2-26.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDPullDown.h"
#import "DDRefreshControlConst.h"

@interface DDPullDown ()
{
    DDRefreshState _lastState; // 记录上次刷新状态
}

@property (nonatomic, retain) NSDate *lastUpdateTime; // 上次更新时间

// 更新时间显示
- (void)updateTimeLabel;

// 拖动状态为正常状态下的响应
- (void)responseStateNormal;
// 拖动状态为托住但未释放
- (void)responseStatePulling;
// 正在刷新
- (void)responseStateRefreshing;

@end

@implementation DDPullDown

+ (instancetype)pullDown
{
    return [[[DDPullDown alloc] init] autorelease];
}

- (void)dealloc
{
    [_lastUpdateTime release];
    [super dealloc];
}

#pragma mark - 设置scrollView

- (void)setScrollView:(UIScrollView *)scrollView
{
    [super setScrollView:scrollView];
    
    // 设置尺寸
    self.frame = CGRectMake(0, -DDRefreshViewHeight, CGRectGetWidth(scrollView.bounds), DDRefreshViewHeight);
    // 上次更新时间
    self.lastUpdateTime = [[NSUserDefaults standardUserDefaults] objectForKey:DDLastUpdateTime];
}

#pragma mark - 重写setter

- (void)setLastUpdateTime:(NSDate *)lastUpdateTime
{
    if (![_lastUpdateTime isEqual:DDLastUpdateTime]) {
        [_lastUpdateTime release];
        _lastUpdateTime = [lastUpdateTime retain];

        // 记录上次更新时间
        [[NSUserDefaults standardUserDefaults] setObject:_lastUpdateTime forKey:DDLastUpdateTime];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // 更新显示
        [self updateTimeLabel];
    }
}

- (void)setState:(DDRefreshState)state
{
    // 排错
    if (state == self.state) {
        return;
    }
    // 记录当前状态
    _lastState = self.state;
    
    [super setState:state];
    
    // 根据不同状态做出不同反应
    switch (state) {
        case DDRefreshStateNormal: // 普通状态
            [self responseStateNormal];
            break;
        case DDRefreshStatePulling: // 拉住状态，松手就更新
            [self responseStatePulling];
        case DDRefreshStateRefreshing: // 正在刷新
            [self responseStateRefreshing];
        default:
            break;
    }
}

#pragma mark - 私有方法

- (void)updateTimeLabel
{
    if (!_lastUpdateTime) {
        return;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *timeString = [formatter stringFromDate:_lastUpdateTime];
    [formatter release];
    
    self.lastUpdate.text = [NSString stringWithFormat:@"最近更新时间：%@", timeString];
}

- (void)responseStateNormal
{
    // 设置状态文字
    self.status.text = DDPullDownToRefresh;
    
    // 执行动画
    [UIView animateWithDuration:DDRefreshAnimationDuration animations:^{
        self.arrow.transform = CGAffineTransformIdentity;
        UIEdgeInsets inset = self.scrollView.contentInset;
        inset.top = self.scrollViewInsetInit.top;
        self.scrollView.contentInset = inset;
    }];
    
    if (_lastState == DDRefreshStateRefreshing) { // 刚刚刷新完成
        self.lastUpdateTime = [NSDate date];
    }
}

- (void)responseStatePulling
{
    // 设置文字
    self.status.text = DDPullDownReleaseToLoadData;
    // 设置动画
    [UIView animateWithDuration:DDRefreshAnimationDuration animations:^{
        self.arrow.transform = CGAffineTransformMakeRotation(M_PI);
        UIEdgeInsets inset = self.scrollView.contentInset;
        inset.top = self.scrollViewInsetInit.top;
        self.scrollView.contentInset = inset;
    }];
}

- (void)responseStateRefreshing
{
    // 设置文字
    self.status.text = DDPullDownDataLoading;
    // 设置动画
    [UIView animateWithDuration:DDRefreshAnimationDuration animations:^{
        self.arrow.transform = CGAffineTransformIdentity;
        UIEdgeInsets inset = self.scrollView.contentInset;
        inset.top = self.scrollViewInsetInit.top + DDRefreshViewHeight;
        self.scrollView.contentInset = inset;
        
        self.scrollView.contentOffset = CGPointMake(0, -self.scrollViewInsetInit.top - DDRefreshViewHeight);
    }];
}


- (CGFloat)properScrollCoordinateY
{
    return self.scrollViewInsetInit.top;
}

- (DDRefreshType)viewType
{   
    return DDRefreshTypePullDown;
}


@end
