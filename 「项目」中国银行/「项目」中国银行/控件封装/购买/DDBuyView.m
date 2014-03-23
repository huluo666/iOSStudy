//
//  DDBuyView.m
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-19.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDBuyView.h"
#import "DDAppDelegate.h"
#import "DDRootViewController.h"

@interface DDBuyView ()

@property (retain, nonatomic) UITextField *buyCountField;
@property (retain, nonatomic) UIImageView *imageView; // 曲线动画小球

@end

@implementation DDBuyView

- (void)dealloc
{
    [_buyCountField release];
    [_productInfos release];
    [_imageView release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame productInfo:(NSDictionary *)productInfos
{
    NSLog(@"产品信息 = %@", productInfos);
    
    // 判读是否过期
    NSString *deadline = productInfos[@"stop_time"];
    if (deadline != nil) {
        NSDateFormatter *fromatter = [[NSDateFormatter alloc] init];
        fromatter.dateFormat = @"yyyy-MM-dd";
        NSDate *stopTime = [fromatter dateFromString:deadline];
        if ([stopTime compare:[NSDate date]] == NSOrderedAscending) {
            // 弹出提示
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                            message:@"该产品不在购买期"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
            return nil;
        };
    }
    
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
        [backgroundView release];
        
        // xx
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        closeButton.bounds = CGRectMake(0, 0, 45, 45);
        closeButton.center = CGPointMake(CGRectGetMaxX(backgroundView.bounds) -
                                         CGRectGetMidX(closeButton.bounds) - 16,
                                         CGRectGetMinY(backgroundView.bounds) +
                                         CGRectGetMidY(closeButton.bounds) + 16);
        [closeButton setBackgroundImage:kImageWithName(@"close_07")
                               forState:UIControlStateNormal];
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
        units.center = CGPointMake(CGRectGetMaxX(_buyCountField.frame) +
                                   CGRectGetMidX(units.bounds),
                                   CGRectGetMidY(_buyCountField.frame));
        units.text = @"万元";
        [backgroundView addSubview:units];
        [units release];
        
        // 购买
        UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        buyButton.bounds = CGRectMake(0, 0, 159, 50);
        buyButton.center = CGPointMake(CGRectGetMidX(backgroundView.bounds),
                                         CGRectGetMaxY(backgroundView.bounds) - 70);
        [buyButton setBackgroundImage:kImageWithName(@"购买")
                             forState:UIControlStateNormal];
        [buyButton addTarget:self
                      action:@selector(buy)
            forControlEvents:UIControlEventTouchUpInside];
        [backgroundView addSubview:buyButton];
        
        self.productInfos = productInfos;
    }
    return self;
}

- (void)closeSelf
{
    [UIView animateWithDuration:kAnimateDuration
                     animations:^{
                         self.center = CGPointMake(kRootViewWidth / 2,
                                                   kRootViewHeight * 2);
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

- (void)buy
{
    // 判断数据
    if (!_productInfos) {
        return;
    }
    
    // 移除自身
    [self closeSelf];
    
    //　曲线动画
    UIImage *image = kImageWithName(@"o_01");
    _imageView = [[UIImageView alloc] initWithImage:image];
    _imageView.bounds = CGRectMake(0, 0, 30, 30);
    _imageView.center = CGPointMake(CGRectGetMidX(self.bounds),
                                   CGRectGetMidY(self.bounds) + 100);
    [kRootView addSubview:_imageView];
    
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 1.0f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
    animation.fillMode = kCAFillModeForwards;
    animation.calculationMode = kCAAnimationCubicPaced;
    animation.removedOnCompletion = YES;
    animation.delegate = self;
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, CGRectGetMidX(self.bounds),
                      CGRectGetMidY(self.bounds) + 100);
    CGPathAddQuadCurveToPoint(curvedPath, NULL, 30, 100, 40, 700);
    animation.path = curvedPath;
    [_imageView.layer addAnimation:animation forKey:nil];
    CGPathRelease(curvedPath);
    
    NSLog(@"产品信息：%@", _productInfos);
    
    // 获取订单信息
    NSString *number = _buyCountField.text;
    NSArray *objs = @[number, _productInfos];
    NSDictionary *orderInfo = [[NSDictionary alloc]
                               initWithObjects:objs
                               forKeys:@[kBuyNumer, kBuyProductInfo]];
    // 获取未处理订单
    NSData *unarchiverData = [[NSData alloc] initWithContentsOfFile:PATH];
    // 关联解档管理器与数据
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]
                                     initForReadingWithData:unarchiverData];
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
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]
                                 initForWritingWithMutableData:archiverData];
    [archiver encodeObject:notProcessOrders forKey:kOrderInfo];
    [archiver finishEncoding];
    [archiverData writeToFile:PATH atomically:YES];
    [archiver release];
    
    NSLog(@"存进去的数据 = %@", notProcessOrders);
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [_imageView removeFromSuperview];
    
    // 改变购物车计算
    DDRootViewController *rootVC = (DDRootViewController *)kRootViewController;
    NSString *countString = rootVC.count;
    NSInteger count = 0;
    if (countString) {
        count = [countString integerValue];
    }
    count += 1;
    rootVC.count = [NSString stringWithFormat:@"%d", count];
    rootVC.countLabel.text = [NSString stringWithFormat:@"%d", count];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

@end
