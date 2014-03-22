//
//  DDComboView.m
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-14.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDComboView.h"
#import "DDCombo.h"

typedef enum {
    DDZoomIn, // 放大
    DDZoomOut // 缩小
} DDScaleType;

@interface DDComboView ()
{
    NSMutableArray *_combos;                    // 套餐模式控件数组
    BOOL _isAnimating;                          // 是否正在动画中
    NSMutableArray *_comboLocationList;         // 用于存储5个坐标点
    NSMutableArray *_dataSource;
}

// 响应滑动手势
- (void)processSwipeGesture:(UISwipeGestureRecognizer *)swipe;

// 为view添加缩放动画
- (void)scaleViewForView:(UIView *)view
                    type:(DDScaleType)type
                duration:(NSTimeInterval)duration;

@end

@implementation DDComboView

- (void)dealloc
{
    NSLog(@"%@ dealloc", [self class]);
    [_combos release];
    [_comboLocationList release];
    [_dataSource release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [DDHTTPManager sendRequestForMealsWithUserId:[[NSUserDefaults standardUserDefaults]
                                                      objectForKey:kUserInfoId]
                                          pageNumber:@"1"
                                            pageSize:@"30"
                                   completionHandler:^(id content, NSString *resultCode) {
            echo();
           _dataSource = [[NSMutableArray alloc] initWithArray:content];
           [self loadViews];
        }];
    }
    return self;
}

- (void)loadViews
{
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
    NSLog(@"_dataSource = %@", _dataSource);
    for (int i = 0; i < 5; i++) {
        DDCombo *combo = [[DDCombo alloc] initWithFrame:CGRectZero];
        combo.center =  [_comboLocationList[i] CGPointValue];
        combo.userInteractionEnabled = NO;
        combo.titleLabel.text = [NSString stringWithFormat:_dataSource[i][@"name"], i];
        combo.showDetail = ^{
            
        };
        [self addSubview:combo];
        [_combos addObject:combo];
        [combo release];
        
        // 默认放大第三个
        if (i != 2) {
            [self scaleViewForView:combo
                              type:DDZoomOut
                          duration:0];
        }
    }
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
        UIView *firstCombo = [[_combos firstObject] retain];
        firstCombo.center = [[_comboLocationList lastObject] CGPointValue];
        [_combos removeObject:firstCombo];
        [_combos addObject:firstCombo];
        [firstCombo release];
        
        NSDictionary *firstDict = [[_dataSource firstObject] retain];
        [_dataSource removeObject:firstDict];
        [_dataSource addObject:firstDict];
        [firstDict release];
        
        [self scaleViewForView:_combos[1]
                          type:DDZoomOut
                      duration:kAnimateDuration / 2];
        [self scaleViewForView:_combos[2]
                          type:DDZoomIn
                      duration:kAnimateDuration / 2];
    } else {
        // 向右移动
        // 调整坐标顺序
        UIView *lastCombo = [[_combos lastObject] retain];
        lastCombo.center = [[_comboLocationList firstObject] CGPointValue];
        [_combos removeObject:lastCombo];
        [_combos insertObject:lastCombo atIndex:0];
        [lastCombo release];
        
        NSDictionary *lastDict = [[_dataSource lastObject] retain];
        [_dataSource removeObject:lastDict];
        [_dataSource insertObject:lastDict atIndex:0];
        [lastDict release];
        
        [self scaleViewForView:_combos[3]
                          type:DDZoomOut
                      duration:kAnimateDuration / 2];
        [self scaleViewForView:_combos[2]
                          type:DDZoomIn
                      duration:kAnimateDuration / 2];
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
    
    // 更新数据
    DDCombo *lastCombo = [_combos lastObject];
    lastCombo.titleLabel.text = _dataSource[4][@"name"];
}

#pragma mark - 缩放动画

- (void)scaleViewForView:(UIView *)view
                    type:(DDScaleType)type
                duration:(NSTimeInterval)duration;
{
    _isAnimating = YES;
    [UIView animateWithDuration:duration
                     animations:^{
             if (DDZoomIn == type) {
                 // 放大
                 view.transform = CGAffineTransformIdentity;
                 view.userInteractionEnabled = YES;
             } else if (DDZoomOut == type) {
                 // 缩小
                 view.transform = CGAffineTransformScale(view.transform, 0.8, 0.8);
                 view.userInteractionEnabled = NO;
             }
         }
                     completion:^(BOOL finished) {
                         _isAnimating = NO;
    }];
}

@end
