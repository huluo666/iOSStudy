//
//  DDPullControl.h
//  「Demo」PullControlDemo
//
//  Created by 萧川 on 14-4-12.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#define DDImageWithName(NAME) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:NAME ofType:@"png"]]
#define kArrowDistancefromCenter 80
#define kPullControlHeight 64

#import <UIKit/UIKit.h>

@protocol DDPullControlDelegate;

/* 拖动状态 */
typedef enum {
    DDPullControlStateHidden,           // 反向拖动状态
    DDPullControlStatePulling,          // 拖动状态
    DDPullControlStateOveredThreshold,  // 超过临界值状态
    DDPullControlStateAction            // 执行动作ing状态
} DDPullControlState;

/* 控件类型 */
typedef enum {
    DDPullControlTypeDown = -1,
    DDPullControlTypeUp = 1
} DDPullControlType;


@interface DDPullControl : UIView {
    
    /* 子类需要访问 */
    
    UIImageView *_arrowView;
    UIActivityIndicatorView *_indicatorView;
    UILabel *_hintLabel;
    UIEdgeInsets _scrollViewInsetRecord;
    BOOL _dragging;
}

/* 本类访问的属性 */

// 委托
@property (nonatomic, assign) id<DDPullControlDelegate> delegate;
// 父视图
@property (nonatomic, strong, readonly) UIScrollView *scrollView;

/* 子类需要访问的属性 */

// 控件类型
@property (nonatomic, assign) DDPullControlType pullControlType;
// 合适的垂直方向拖动的值(子类override其getter)
@property (nonatomic, assign) CGFloat properVerticalPullValue;
// 控件类型
@property (nonatomic, assign) DDPullControlState state;
// 箭头视图
@property (nonatomic, retain) UIImageView *arrowView;
// 进度指示器
@property (nonatomic, retain) UIActivityIndicatorView *indicatorView;
// 提示文字
@property (nonatomic, retain) UILabel *hintLabel;
// 记录父滚动视图滚动后的contentInSet
@property (assign, nonatomic) UIEdgeInsets scrollViewInsetRecord;
// 滚动视图内容超过控件视图的高度(子类覆写)
@property (assign, nonatomic) CGFloat scrollViewOverViewHeight;
// 是否正在拖动
@property (nonatomic, assign, getter = isDragging) BOOL dragging;

// 开始执行事务
- (void)beginAction;
// 结束执行事务
- (void)endAction;

- (void)adjustFrame;

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
