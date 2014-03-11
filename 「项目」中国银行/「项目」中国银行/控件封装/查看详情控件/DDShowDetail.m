//
//  DDShowDetail.m
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-10.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDShowDetail.h"

@interface DDShowDetail ()
{
    UIView *_backgroundView; // 背景视图
    UIView *_bottomView; // 背景视图
}

// 关闭当前窗口
- (void)closeSelf;

@end

@implementation DDShowDetail

- (void)dealloc
{
    [_backgroundView release];
    [_bottomView release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, kRootViewWidth, kRootViewHeight);
        
        // 背景视图
        _backgroundView= [[UIView alloc] initWithFrame:self.frame];
        _backgroundView.backgroundColor = [UIColor clearColor];
        [self addSubview:_backgroundView];
        
        // 详情框底视图
        _bottomView = [[UIView alloc] init];
        _bottomView.bounds = CGRectMake(0, 0, 260, 200);
        _bottomView.center = CGPointMake(kRootViewWidth / 2, kRootViewHeight / 2);
        _bottomView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bottomView];
        
        // title
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.bounds = CGRectMake(0,
                                       0,
                                       CGRectGetWidth(_bottomView.bounds),
                                       CGRectGetHeight(_bottomView.bounds) * 0.1);
        titleLabel.center = CGPointMake(CGRectGetMidX(_bottomView.bounds), CGRectGetMidY(titleLabel.bounds));
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.text = @"测试标题";
        [_bottomView addSubview:titleLabel];
        [titleLabel release];
        
        // contentView
        UIView *contentView = [[UIView alloc] init];
        contentView.bounds = CGRectMake(0,
                                        0,
                                        CGRectGetWidth(_bottomView.bounds),
                                        CGRectGetHeight(_bottomView.bounds) * 0.75);
        contentView.center = CGPointMake(CGRectGetMidX(_bottomView.bounds),
                                         CGRectGetMidY(contentView.bounds) + CGRectGetHeight(titleLabel.bounds));
        contentView.backgroundColor = [UIColor orangeColor];
        [_bottomView addSubview:contentView];
        [contentView release];
        
        // 取消按钮
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        closeButton.bounds = CGRectMake(0,
                                        0,
                                        CGRectGetWidth(_bottomView.bounds) * 0.05,
                                        CGRectGetWidth(_bottomView.bounds) * 0.05);
        closeButton.center = CGPointMake(CGRectGetMaxX(_bottomView.bounds) - CGRectGetMidX(closeButton.bounds),
                                         CGRectGetMidY(titleLabel.bounds));
        [closeButton setBackgroundImage:[UIImage imageNamed:@"close_07"] forState:UIControlStateNormal];
        [closeButton addTarget:self
                        action:@selector(closeSelf)
              forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:closeButton];

        // 动画
        [UIView animateWithDuration:kAnimateDuration / 2 animations:^{
            _backgroundView.backgroundColor = [UIColor blackColor];
            _backgroundView.alpha = 0.5f;
            _bottomView.transform = CGAffineTransformScale(_bottomView.transform, 3, 3);
        }];
    }
    return self;
}

- (void)closeSelf
{
    [UIView animateWithDuration:kAnimateDuration / 2
                     animations:^{
                         _backgroundView.backgroundColor = [UIColor clearColor];
                         _backgroundView.alpha = 1.0f;
                         _bottomView.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

@end
