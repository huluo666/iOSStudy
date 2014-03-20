//
//  DDBuyView.m
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-19.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDBuyView.h"

@interface DDBuyView ()

@property (retain, nonatomic) UITextField *buyCountField;

@end

@implementation DDBuyView

- (void)dealloc
{
    [_buyCountField release];
    [_productInfo release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bounds = CGRectMake(0, 0, kRootViewWidth, kRootViewHeight);
        CGRect bounds = CGRectMake(0, 0, 434, 328);
        self.center = CGPointMake(kRootViewWidth / 2, kRootViewHeight * 2);
        [UIView animateWithDuration:kAnimateDuration animations:^{
            self.center = CGPointMake(kRootViewWidth / 2, kRootViewHeight / 2);
        }];
        
        CGRect frame = CGRectMake(0, 0, kRootViewWidth, kRootViewHeight);
        UIView *view = [[UIView alloc] initWithFrame:frame];
        view.userInteractionEnabled = NO;
        view.alpha = 0.5;
        [self addSubview:view];
        [view release];
        
        UIImage *backgroundImage = [UIImage imageNamed:@"购买量_05"];
        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
        backgroundView.bounds = bounds;
        backgroundView.center = CGPointMake(CGRectGetMidX(self.bounds),
                                                    CGRectGetMidY(self.bounds));
        backgroundView.userInteractionEnabled = YES;
        [self addSubview:backgroundView];
        
        // xx
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        closeButton.bounds = CGRectMake(0, 0, 45, 45);
        closeButton.center = CGPointMake(CGRectGetMaxX(backgroundView.bounds) - CGRectGetMidX(closeButton.bounds) - 16,
                                         CGRectGetMinY(backgroundView.bounds) + CGRectGetMidY(closeButton.bounds) + 16);
        [closeButton setBackgroundImage:kImageWithName(@"close_07") forState:UIControlStateNormal];
        [closeButton addTarget:self
                        action:@selector(closeSelf)
              forControlEvents:UIControlEventTouchUpInside];
        [backgroundView addSubview:closeButton];

        // 购买量
        _buyCountField = [[UITextField alloc] init];
        _buyCountField.bounds = CGRectMake(0, 0, 250, 40);
        _buyCountField.center = CGPointMake(CGRectGetMidX(backgroundView.bounds) - 15,
                                           CGRectGetMidY(backgroundView.bounds) - 12);
        _buyCountField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _buyCountField.keyboardType = UIKeyboardTypeNumberPad;
        [backgroundView addSubview:_buyCountField];
        
        // 单位
        UILabel *units = [[UILabel alloc] init];
        units.bounds = CGRectMake(0, 0, 50, 40);
        units.center = CGPointMake(CGRectGetMaxX(_buyCountField.frame) + CGRectGetMidX(units.bounds),
                                   CGRectGetMidY(_buyCountField.frame));
        units.text = @"万元";
        [backgroundView addSubview:units];
        [units release];
        
        // 购买
        UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        buyButton.bounds = CGRectMake(0, 0, 159, 50);
        buyButton.center = CGPointMake(CGRectGetMidX(backgroundView.bounds),
                                         CGRectGetMaxY(backgroundView.bounds) - 70);
        [buyButton setBackgroundImage:kImageWithName(@"购买") forState:UIControlStateNormal];
        [buyButton addTarget:self
                      action:@selector(buy)
            forControlEvents:UIControlEventTouchUpInside];
        [backgroundView addSubview:buyButton];
    }
    return self;
}

- (void)closeSelf
{
    [UIView animateWithDuration:kAnimateDuration
                     animations:^{
                         self.center = CGPointMake(kRootViewWidth / 2, kRootViewHeight * 2);
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

- (void)buy
{
    if (!_productInfo) {
        return;
    }
    
    [self closeSelf];
    
    NSLog(@"产品信息：%@", _productInfo);
    
    // 获取订单信息
    NSString *number = _buyCountField.text;
    NSArray *objs = @[number, _productInfo];
    NSDictionary *orderInfo = [[NSDictionary alloc] initWithObjects:objs forKeys:@[kBuyNumer, kBuyProductInfo]];
    
    // 获取未处理订单
    NSData *unarchiverData = [[NSData alloc] initWithContentsOfFile:PATH]; // 关联解档管理器与数据
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:unarchiverData];
    // 通过解档管理器和key解档数据
    NSMutableArray *notProcessOrders = [unarchiver decodeObjectForKey:kOrderInfo];
    [unarchiverData release];
    [unarchiver release];
    
    if (!notProcessOrders) {
        notProcessOrders = [NSMutableArray array];
    }
    [notProcessOrders addObject:orderInfo];
    [orderInfo release];

    // 保存订单信息
    // 创建数据容器
    NSMutableData *archiverData = [NSMutableData data];
    // 关联容器与归档管理器
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:archiverData];
    [archiver encodeObject:notProcessOrders forKey:kOrderInfo];
    [archiver finishEncoding];
    [archiverData writeToFile:PATH atomically:YES];
    [archiver release];
    
    NSLog(@"存进去的数据 = %@", notProcessOrders);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

@end
