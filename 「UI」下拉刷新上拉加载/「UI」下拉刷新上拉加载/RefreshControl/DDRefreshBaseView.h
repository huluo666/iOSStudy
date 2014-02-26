//
//  DDRefreshBaseView.h
//  「UI」下拉刷新下拉加载
//
//  Created by 萧川 on 14-2-26.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - 控件的类型

typedef enum {
    DDRefreshTypeHeader = 1 << 0,
    DDRefreshTypeFooter = 1 << 1
} DDRefreshType;

#pragma mark - 控件的状态

typedef enum {
    DDRefreshStatePullOrDrop     = 1 << 0, // 下拉或者上拉
    DDRefreshStateNormal         = 1 << 1, // 普通状态
    DDRefreshStateRefreshing     = 1 << 2, // 刷新状态
    DDRefreshStateWillRefreshing = 1 << 3  // 将要刷新
} DDRefreshState;

#pragma mark - 委托协议方法

@class DDRefreshBaseView;
@protocol DDRefreshBaseDelegate <NSObject>
// 开始进入刷新状态调用
- (void)refreshBaseViewbeginRefreshing:(DDRefreshBaseView *)refreshBaseView;
// 刷新完成调用
- (void)refreshBaseViewDidRefreshing:(DDRefreshBaseView *)refreshBaseView;
// 刷新状态发生变化调用
- (void)refreshBaseView:(DDRefreshBaseView *)refreshBaseView stateChange:(DDRefreshState)state;

@end

@interface DDRefreshBaseView : UIView

@property (assign, nonatomic) DDRefreshType viewType;           // 控件视图类型(Footer或者Header)
@property (assign, nonatomic) CGFloat minScrollCoordinateY;     // 最少滚动多少Y坐标

@property (retain, nonatomic) UIScrollView *scrollView;          // 滑动控件
- (instancetype)initWihtScrollView:(UIScrollView *)scrollView;

// 委托
@property (nonatomic, assign) id<DDRefreshBaseDelegate> delegate;
// 是否在刷新
@property (nonatomic, assign, getter = isRefreshing) BOOL refreshing;

#pragma mark - block
// 开始刷新调用
@property (nonatomic, copy) void (^beginRefreshBaseView)(DDRefreshBaseView *refreshBaseView);
// 刷新完成调用
@property (nonatomic, copy) void (^endRefreshBaseView)(DDRefreshBaseView *endRefreshBaseView);
// 刷新状态发生变化调用
@property (nonatomic, copy) void (^refreshStateChange)(DDRefreshBaseView *refreshBaseView, DDRefreshState state);

// 最少滚动的Y做标值
- (CGFloat)minScrollCoordinateY;


// 开始刷新
- (void)beginRefreshing;
// 刷新完成
- (void)endRefreshing;
// 不静止地刷新
- (void)endRefreshingWithoutIdle;
// 释放资源
- (void)free;
// 设置刷新状态
- (void)setState:(DDRefreshState)state;

@end
