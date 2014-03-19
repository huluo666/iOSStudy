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
    UIView *_bottomView;     // 背景视图
    BOOL _needRemove;        // 是否需要移除视图
}

// 开始基础缩放动画
- (void)startBasicScaleAnimationFromValue:(NSValue *)fromeValue toValue:(NSValue *)toValue;
// 关闭当前窗口
- (void)closeSelf;

@end

@implementation DDShowDetail

- (void)dealloc
{
    NSLog(@"%@ dealloced", [self class]);
    [_backgroundView release];
    [_bottomView release];
    [_contentView release];
    [_titleLabel release];
    [_buyAction release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, kRootViewWidth, kRootViewHeight);
        
        // 背景视图
        _backgroundView= [[UIView alloc] initWithFrame:self.frame];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = 0.5;
        _backgroundView.userInteractionEnabled = YES;
        [self addSubview:_backgroundView];
        
        // 详情框底视图
        _bottomView = [[UIView alloc] init];
        _bottomView.bounds = CGRectMake(0, 0, 800, 600);
        _bottomView.center = CGPointMake(kRootViewWidth / 2, kRootViewHeight / 2);
        _bottomView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bottomView];
        
        // title
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.bounds = CGRectMake(0,
                                       0,
                                       CGRectGetWidth(_bottomView.bounds),
                                       CGRectGetHeight(_bottomView.bounds) * 0.1);
        _titleLabel.center = CGPointMake(CGRectGetMidX(_bottomView.bounds), CGRectGetMidY(_titleLabel.bounds));
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:22];
        _titleLabel.font = [UIFont boldSystemFontOfSize:22];
        [_bottomView addSubview:_titleLabel];
        
        // contentView
        _contentView = [[UIView alloc] init];
        _contentView.bounds = CGRectMake(0,
                                        0,
                                        CGRectGetWidth(_bottomView.bounds),
                                        CGRectGetHeight(_bottomView.bounds) * 0.75);
        _contentView.center = CGPointMake(CGRectGetMidX(_bottomView.bounds),
                                         CGRectGetMidY(_contentView.bounds) + CGRectGetHeight(_titleLabel.bounds));
        [_bottomView addSubview:_contentView];
        
        // 取消按钮
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        closeButton.bounds = CGRectMake(0,
                                        0,
                                        CGRectGetWidth(_bottomView.bounds) * 0.05,
                                        CGRectGetWidth(_bottomView.bounds) * 0.05);
        closeButton.center = CGPointMake(CGRectGetMaxX(_bottomView.bounds) - CGRectGetMidX(closeButton.bounds) * 1.5,
                                         CGRectGetMidY(_titleLabel.bounds));
        [closeButton setBackgroundImage:kImageWithName(@"close_07") forState:UIControlStateNormal];
        [closeButton addTarget:self
                        action:@selector(closeSelf)
              forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:closeButton];
        
        // 购买按钮
        UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        buyButton.bounds = CGRectMake(0, 0, 159, 50);
        buyButton.center = CGPointMake(CGRectGetMidX(_contentView.bounds),
                                       CGRectGetMaxY(_contentView.frame) - CGRectGetMidY(buyButton.bounds) * 1.2);
        buyButton.hidden = NO;
        [buyButton setBackgroundImage:kImageWithName(@"购买")
                             forState:UIControlStateNormal];
        [buyButton addTarget:self
                      action:@selector(buyButtonAction:)
            forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:buyButton];
        
        // 调用动画
        [self startBasicScaleAnimationFromValue:@0 toValue:@1];
    }
    return self;
}

- (void)setBuyButtonHidden:(BOOL)buyButtonHidden
{
    UIButton *buyButton = (UIButton *)[_bottomView.subviews lastObject];
    buyButton.hidden = buyButtonHidden;
}

- (void)buyButtonAction:(UIButton *)sender
{
    if (_buyAction) {
        _buyAction(sender);
    }
    sender.enabled = NO;
}

- (void)startBasicScaleAnimationFromValue:(NSValue *)fromeValue toValue:(NSValue *)toValue
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = kAnimateDuration / 2;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fromValue = fromeValue;
    animation.toValue = toValue;
    animation.removedOnCompletion = NO;
    animation.delegate = self;
    animation.fillMode = kCAFillModeForwards;
    [_bottomView.layer addAnimation:animation forKey:@"transform.scale"];
}

// 动画回调方法，非正式协议
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (_needRemove) {
        [self removeFromSuperview];
    }
}

- (void)closeSelf
{
    _needRemove = YES;
    [self startBasicScaleAnimationFromValue:@1 toValue:@0];
}

@end
