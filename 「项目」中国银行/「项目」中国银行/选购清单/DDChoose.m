//
//  DDChoose.m
//  「项目」中国银行
//
//  Created by 萧川 on 3/7/14.
//  Copyright (c) 2014 CUAN. All rights reserved.
//

#import "DDChoose.h"
#import "DDOrderView.h"

@interface DDChoose ()
{
    UIImageView *_listBackgroundView; // 清单背景颜色
}

// 提交办理
- (void)submit;

@end

@implementation DDChoose

- (void)dealloc
{
    NSLog(@"%@ is dealloced", [self class]);
    [_listBackgroundView release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, kMainViewWidth, kMainViewHeight);
        // 初始化大背景
        UIImageView *bottomView = [[UIImageView alloc] init];
        bottomView.frame = kMainViewBounds;
        bottomView.image = [UIImage imageNamed:@"背景"]; // cache
        bottomView.userInteractionEnabled = YES;
        [self addSubview:bottomView];
        [bottomView release];
        
        // 清单背景
        UIImage *listBackgroundImage = kImageWithName(@"down_05");
        _listBackgroundView = [[UIImageView alloc] initWithImage:listBackgroundImage];
        _listBackgroundView.bounds = CGRectMake(0, 0, CGRectGetWidth(bottomView.bounds) * 0.92,
                                               CGRectGetHeight(bottomView.bounds) * 0.92);
        _listBackgroundView.center = CGPointMake(CGRectGetMidX(self.bounds),
                                                CGRectGetMidY(self.bounds));
        _listBackgroundView.userInteractionEnabled = YES;
        [self addSubview:_listBackgroundView];
        
        CGFloat width = CGRectGetWidth(_listBackgroundView.bounds) * 0.8;
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.font = [UIFont systemFontOfSize:24];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.bounds = CGRectMake(0, 0, width * 0.2, 40);
        nameLabel.text = @"姓名";
        nameLabel.center = CGPointMake(CGRectGetMidX(nameLabel.bounds) + 20, 70);
        [_listBackgroundView addSubview:nameLabel];
        [nameLabel release];

        UILabel *orderLabel = [[UILabel alloc] init];
        orderLabel.textAlignment = NSTextAlignmentCenter;
        orderLabel.font = [UIFont systemFontOfSize:24];
        orderLabel.textColor = [UIColor whiteColor];
        orderLabel.bounds = CGRectMake(0, 0, width * 0.8, 40);
        orderLabel.center = CGPointMake(CGRectGetMaxX(nameLabel.frame) + CGRectGetMidX(orderLabel.bounds) + 20, 70);
        orderLabel.text = @"订单号";
        [_listBackgroundView addSubview:orderLabel];
        [orderLabel release];
        
        
        // 模拟提交订单
        [self performSelector:@selector(submit) withObject:nil afterDelay:3];
    }
    return self;
}

- (void)submit
{
    // 创建订单信息页面
    CGRect frame = CGRectMake(20,
                              20,
                              CGRectGetWidth(_listBackgroundView.bounds),
                              CGRectGetHeight(_listBackgroundView.bounds));
    
    __block DDOrderView *orderView = [[DDOrderView alloc] initWithFrame:frame];
    CGPoint center = _listBackgroundView.center;
    orderView.center = CGPointMake(3 * center.x, center.y);
    [self addSubview:orderView];
    [orderView release];

    orderView.swipRight = ^{
        [UIView animateWithDuration:kAnimateDuration animations:^{
            _listBackgroundView.center = center;
            orderView.center =  CGPointMake(3 * center.x, center.y);
        } completion:^(BOOL finished) {
            [orderView removeFromSuperview];
        }];
    };
    
    [UIView animateWithDuration:kAnimateDuration animations:^{
        _listBackgroundView.center = CGPointMake(-center.x, center.y);
        orderView.center = center;
    }];
}


@end
