//
//  ViewController3.m
//  2014.2.21
//
//  Created by 张鹏 on 14-2-21.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "ViewController3.h"

@interface ViewController3 ()

- (void)initializeUserInterface;
- (void)startBasicAnimation;

@end

@implementation ViewController3

- (id)init
{
    self = [super init];
    if (self) {
        
        self.title = NSStringFromClass([self class]);
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initializeUserInterface];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self startBasicAnimation];
}

- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.text = @"Animation";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:40];
    [self.view addSubview:label];
    [label release];
}

- (void)startBasicAnimation {
    
    // 基础属性动画
    // 平移
    // keyPath：决定了基础属性动画的类型
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"position"];
    animation1.duration = 0.5;
    animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    // NSNumber:封装简单数据类型为对象类型，int float double NSInteger BOOL
    // NSValue:封装复杂数据类型为对象类型，结构体：CGPoint、CGSize、CGRect（NSPoint）
    // 动画开始位置
    animation1.fromValue = [NSValue valueWithCGPoint:CGPointMake(160, 284)];
    // 动画结束位置
    animation1.toValue = [NSValue valueWithCGPoint:CGPointMake(160, 100)];
    // 配置动画结束后是否应被移除
    animation1.removedOnCompletion = NO;
    animation1.fillMode = kCAFillModeForwards;
//    animation1.autoreverses = YES;
    // 重复次数
//    animation1.repeatCount = HUGE_VALF;
//    animation1.autoreverses = YES;
    [self.view.layer addAnimation:animation1 forKey:@"position"];
    
    // 翻转
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    animation2.duration = 0.5;
    animation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation2.fromValue = @0;
    animation2.toValue = @(M_PI);
    animation2.removedOnCompletion = NO;
    animation2.fillMode = kCAFillModeForwards;
    [self.view.layer addAnimation:animation2 forKey:@"rotation"];
    
    // 不透明度
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation3.duration = 0.5;
    animation3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation3.fromValue = @1;
    animation3.toValue = @0.5;
    animation3.removedOnCompletion = NO;
    animation3.fillMode = kCAFillModeForwards;
    // 配置委托
    animation3.delegate = self;
    [self.view.layer addAnimation:animation3 forKey:@"opacity"];
}

// 动画执行完成委托回调（非正式协议方法，非正式协议：NSObject类别）
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"position"];
    animation1.duration = 0.5;
    animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation1.fromValue = [NSValue valueWithCGPoint:CGPointMake(160, 100)];
    animation1.toValue = [NSValue valueWithCGPoint:CGPointMake(160, 284)];
    animation1.removedOnCompletion = NO;
    animation1.fillMode = kCAFillModeForwards;
    [self.view.layer addAnimation:animation1 forKey:@"position"];
    
    // 翻转
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    animation2.duration = 0.5;
    animation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation2.fromValue = @(M_PI);
    animation2.toValue = @(M_PI * 2);
    animation2.removedOnCompletion = NO;
    animation2.fillMode = kCAFillModeForwards;
    [self.view.layer addAnimation:animation2 forKey:@"rotation"];
    
    // 不透明度
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation3.duration = 0.5;
    animation3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation3.fromValue = @0.5;
    animation3.toValue = @1;
    animation3.removedOnCompletion = NO;
    animation3.fillMode = kCAFillModeForwards;
    [self.view.layer addAnimation:animation3 forKey:@"opacity"];
}

@end

















