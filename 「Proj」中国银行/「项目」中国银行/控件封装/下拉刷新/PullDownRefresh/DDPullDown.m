//
//  DDPullDown.m
//  「UI」下拉刷新上拉加载
//
//  Created by 萧川 on 14-2-26.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDPullDown.h"

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
    return [[[self alloc] init] autorelease];
}

- (void)dealloc
{
    NSLog(@"%@ is dealloced", [self class]);
    [_lastUpdateTime release];
    [super dealloc];
}

#pragma mark - setter

- (void)setScrollView:(UIScrollView *)scrollView
{
    [super setScrollView:scrollView];

    // 设置尺寸
    self.frame = CGRectMake(0,
                            -DDRefreshViewHeight,
                            CGRectGetWidth(scrollView.bounds),
                            DDRefreshViewHeight);
    // 上次更新时间
    NSDate *date = [[NSUserDefaults standardUserDefaults]
                    objectForKey:DDLastUpdateTime];
    if (!date) {
        date = [NSDate date];
    }
    self.lastUpdateTime = date;
}

- (void)setLastUpdateTime:(NSDate *)lastUpdateTime
{
    if (_lastUpdateTime != lastUpdateTime) {
        [_lastUpdateTime release];
        _lastUpdateTime = [lastUpdateTime retain];

        // 记录上次更新时间
        [[NSUserDefaults standardUserDefaults] setObject:_lastUpdateTime
                                                  forKey:DDLastUpdateTime];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // 更新显示
        [self updateTimeLabel];
    }
}

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
        case DDRefreshStateNormal: // 普通状态, 下拉刷新
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

#pragma mark - 重写getter

- (CGFloat)properVerticalPullValue
{
    return self.scrollViewInsetRecord.top;
}

- (DDRefreshType)viewType
{
    return DDRefreshTypePullDown;
}

#pragma mark - 私有方法

- (void)updateTimeLabel
{
    if (!_lastUpdateTime) {
        return;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-dd HH:mm"];
    NSString *timeString = [formatter stringFromDate:_lastUpdateTime];
    [formatter release];
    
    self.lastUpdate.text = [NSString stringWithFormat:@"上次更新时间：%@", timeString];
}

- (void)responseStateNormal
{
    // 设置状态文字
    self.status.text = DDPullDownToRefresh;
    
    // 执行动画
    [UIView animateWithDuration:DDRefreshAnimationDuration animations:^{
        self.arrow.transform = CGAffineTransformIdentity;
        UIEdgeInsets inset = self.scrollView.contentInset;
        inset.top = self.scrollViewInsetRecord.top;
        self.scrollView.contentInset = inset;
    }];
    
    // 刚刚刷新完成
    if (_lastState == DDRefreshStateRefreshing) {
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
        inset.top = self.scrollViewInsetRecord.top;
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
        inset.top = self.scrollViewInsetRecord.top + DDRefreshViewHeight;
        self.scrollView.contentInset = inset;
         // 设置滚动停留的位置
        self.scrollView.contentOffset = CGPointMake(0, -self.scrollViewInsetRecord.top - DDRefreshViewHeight);
    }];
}
@end