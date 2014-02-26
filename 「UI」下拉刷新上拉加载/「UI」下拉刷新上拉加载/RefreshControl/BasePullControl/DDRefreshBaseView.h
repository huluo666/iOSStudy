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
    DDRefreshTypePullUp   = 1 << 0,
    DDRefreshTypePullDown = 1 << 1
} DDRefreshType;

#pragma mark - 控件的状态

typedef enum {
    DDRefreshStatePulling        = 1 << 0, // 下拉或者上拉
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

@property (retain, nonatomic) UILabel *lastUpdate;              // 上次更新时间
@property (assign, nonatomic) DDRefreshState state;             // 刷新状态
@property (retain, nonatomic) UILabel *status;                  // 状态显示
@property (retain, nonatomic) UIImageView *arrow;               // 箭头图标
@property (assign, nonatomic) UIEdgeInsets scrollViewInsetInit; // 第一次的视图扩展范围

@property (retain, nonatomic) UIScrollView *scrollView;         // 滑动控件
- (instancetype)initWihtScrollView:(UIScrollView *)scrollView;

// 委托
@property (nonatomic, assign) id<DDRefreshBaseDelegate> delegate;
// 是否正在刷新
@property (nonatomic, assign, getter = isRefreshing) BOOL refreshing;

#pragma mark - block
// 开始刷新调用
@property (nonatomic, copy) void (^beginRefreshBaseView)(DDRefreshBaseView *refreshBaseView);
// 刷新完成调用
@property (nonatomic, copy) void (^didRefreshBaseView)(DDRefreshBaseView *refreshBaseView);
// 刷新状态发生变化调用
@property (nonatomic, copy) void (^refreshStateChange)(DDRefreshBaseView *refreshBaseView, DDRefreshState state);


// 开始刷新
- (void)beginRefreshing;
// 刷新完成
- (void)endRefreshing;
// 不静止地刷新
- (void)endRefreshingWithoutIdle;
// 设置刷新状态
- (void)setState:(DDRefreshState)state;

@end
