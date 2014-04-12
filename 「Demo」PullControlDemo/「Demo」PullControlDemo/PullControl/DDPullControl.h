//
//  DDPullControl.h
//  「Demo」PullControlDemo
//
//  Created by 萧川 on 14-4-12.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol DDPullControlDelegate;

/* 拖动状态 */
typedef enum {
    DDPullControlStateHidden,           // 隐藏状态
    DDPullControlStatePullingDown,      // 下拉状态
    DDPullControlStatePullingUp,        // 上拉状态
    DDPullControlStateOveredThreshold,  // 超过临界值状态
    DDPullControlStateStoping           // 停止状态
} DDPullControlState;

/* 控件类型 */
typedef enum {
    DDPullControlTypeDown,
    DDPullControlTypeUp
} DDPullControlType;


@interface DDPullControl : UIView {

    /* 子类访问 */
    CGFloat _threshold;

    /* 子类访问 */
    UIImageView *_arrowView;
    UIActivityIndicatorView *_indicatorView;
    UILabel *_titleLabel;
    BOOL _dragging;
}

@property (nonatomic, assign) id<DDPullControlDelegate> delegate;
@property (nonatomic, assign) CGFloat threshold;
@property (nonatomic, assign) DDPullControlState state;
@property (nonatomic, strong, readonly) UIScrollView *scrollView;

/* 子类需要访问的属性 */
@property (nonatomic, retain) UIImageView *arrowView;
@property (nonatomic, retain) UIActivityIndicatorView *indicatorView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, assign, getter = isDragging) BOOL dragging;

- (void)beginAction;
- (void)endAction;

@end

/* 拖动控件委托 */
@protocol DDPullControlDelegate <NSObject>

@optional
// 将要开始执行动作
- (void)pullControlWillBeginAction:(DDPullControl *)pullControl;
// 已经开始执行动作
- (void)pullControlDidBeginAction:(DDPullControl *)pullControl;
// 将要结束执行动作
- (void)pullControlWillEndAction:(DDPullControl *)pullControl;
// 已经结束执行动作
- (void)pullControlDidEndAction:(DDPullControl *)pullControl;

@end

#define DDImageWithName(NAME) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:NAME ofType:@"png"]]

#define kArrowDistancefromCenter 80

#define kTitleLabelPullText @"Pull to refresh"
#define kTitleLabelReleaseText @"Release to Refresh"
#define kTitleLabelActionText @"Loading..."

