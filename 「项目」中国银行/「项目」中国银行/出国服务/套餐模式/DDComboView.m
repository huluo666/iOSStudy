//
//  DDComboView.m
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-14.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDComboView.h"
#import "DDCombo.h"

@interface DDComboView ()
{
    NSMutableArray *_combos;                    // 套餐模式控件数组
    BOOL _isAnimating;                          // 是否正在动画中
    NSMutableArray *_comboLocationList;         // 用于存储5个坐标点
}

// 响应滑动手势
- (void)processSwipeGesture:(UISwipeGestureRecognizer *)swipe;

// 为view添加缩放动画
- (void)startBasicScaleAnimationFromValue:(NSValue *)fromeValue
                                  toValue:(NSValue *)toValue
                                  ForView:(UIView *)view
                    withAnimationDuration:(NSTimeInterval)duration;

@end

@implementation DDComboView

- (void)dealloc
{
    NSLog(@"%@ dealloc", [self class]);
    [_combos release];
    [_comboLocationList release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 左滑
        UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc]
                                               initWithTarget:self
                                               action:@selector(processSwipeGesture:)];
        leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:leftSwipe];
        [leftSwipe release];
        
        // 右滑
        UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc]
                                                initWithTarget:self
                                                action:@selector(processSwipeGesture:)];
        rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:rightSwipe];
        [rightSwipe release];

        // 初始化展示视图
        _combos = [[NSMutableArray alloc] init];

        // 初始化五个视图的center坐标点
        CGFloat comboCenterX = CGRectGetMidX(self.bounds);
        CGFloat comboCenterY = CGRectGetMidY(self.bounds);
        CGPoint comboCenter = CGPointMake(comboCenterX, comboCenterY);
        _comboLocationList = [@[[NSValue valueWithCGPoint:CGPointMake(comboCenterX - 700, comboCenterY)],
                                [NSValue valueWithCGPoint:CGPointMake(comboCenterX - 400, comboCenterY)],
                                [NSValue valueWithCGPoint:comboCenter],
                                [NSValue valueWithCGPoint:CGPointMake(comboCenterX + 400, comboCenterY)],
                                [NSValue valueWithCGPoint:CGPointMake(comboCenterX + 700, comboCenterY)]] mutableCopy];
  
        for (int i = 0; i < 5; i++) {
            DDCombo *combo = [[DDCombo alloc] initWithFrame:CGRectZero];
            combo.center =  [_comboLocationList[i] CGPointValue];
            combo.userInteractionEnabled = NO;
            combo.titleLabel.text = [NSString stringWithFormat:@"测试标题%d", i];
            [self addSubview:combo];
            [_combos addObject:combo];
            [combo release];
        }
    }
    return self;
}

- (void)processSwipeGesture:(UISwipeGestureRecognizer *)swipe
{
    // 正在动画中不就不执行动画
    if (_isAnimating) {
        return;
    }
    
    // 标记开始动画
    _isAnimating = YES;
    
    // 判断移动方向
    if (UISwipeGestureRecognizerDirectionLeft == swipe.direction) {
        // 向左移动
        // 将控件数组中的所有控件前移动一格
        // 第3个缩小的同时第4个放大
        // 先调整坐标顺序
        UIView *firstCombo = [_combos firstObject];
        firstCombo.center = [[_comboLocationList lastObject] CGPointValue];
        [_combos removeObjectAtIndex:0];
        [_combos addObject:firstCombo];
        
        // 缩放动画
        [self startBasicScaleAnimationFromValue:@1.2
                                        toValue:@1
                                        ForView:_combos[1]
                          withAnimationDuration:kAnimateDuration / 2];
        [self startBasicScaleAnimationFromValue:@1
                                        toValue:@1.2 ForView:_combos[2]
                          withAnimationDuration:kAnimateDuration / 2];
    } else {
        // 向右移动
        // 调整坐标顺序
        UIView *lastCombo = [_combos lastObject];
        lastCombo.center = [[_comboLocationList firstObject] CGPointValue];
        [_combos removeObject:lastCombo];
        [_combos insertObject:lastCombo atIndex:0];
        
        // 缩放动画
        [self startBasicScaleAnimationFromValue:@1.2
                                        toValue:@1
                                        ForView:_combos[3]
                          withAnimationDuration:kAnimateDuration / 2];
        [self startBasicScaleAnimationFromValue:@1
                                        toValue:@1.2
                                        ForView:_combos[2]
                          withAnimationDuration:kAnimateDuration / 2];
    }
    
    // 移动一格
    [UIView animateWithDuration:kAnimateDuration / 2 animations:^{
        for (int i = 0; i < 5; i++) {
            UIView *combo = _combos[i];
            combo.center = [_comboLocationList[i] CGPointValue];
        }
    } completion:^(BOOL finished) {
        _isAnimating = NO;
    }];
}

#pragma mark - 缩放动画

- (void)startBasicScaleAnimationFromValue:(NSValue *)fromeValue
                                  toValue:(NSValue *)toValue
                                  ForView:(UIView *)view
                    withAnimationDuration:(NSTimeInterval)duration
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = duration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fromValue = fromeValue;
    animation.toValue = toValue;
    animation.removedOnCompletion = YES;
    animation.delegate = self;
    animation.fillMode = kCAFillModeForwards;
    [view.layer addAnimation:animation forKey:@"transform.scale"];
    
    // 切换用户交互
    if (fromeValue < toValue) {
        view.userInteractionEnabled = NO;
    } else {
        view.userInteractionEnabled = YES;
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    _isAnimating = NO;
}

@end
