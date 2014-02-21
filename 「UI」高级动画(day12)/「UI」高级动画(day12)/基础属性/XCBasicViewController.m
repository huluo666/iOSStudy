//
//  XCBasicViewController.m
//  「UI」高级动画(day12)
//
//  Created by 萧川 on 14-2-21.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "XCBasicViewController.h"

@interface XCBasicViewController ()

@end

@implementation XCBasicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"基础属性";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self initUserInterface];
}

- (void)initUserInterface
{
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.frame];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:22.0f];
    label.textColor = [UIColor grayColor];
    label.text = self.title;
    [self.view addSubview:label];
    [label release];
}

// 动画完成回掉方法(非正式协议方法，NSObject类别方法)
- (void)animationDidStop
{
    [self translationFromValue:[NSValue valueWithCGPoint:CGPointMake(160, 150)] toValue:[NSValue valueWithCGPoint:CGPointMake(160, 284)]];
    [self rotationFromValue:@(M_PI) toValue:@(2 * M_PI)];
    [self opacityFromValue:@0.5 toValue:@1];
}

- (void)opacityFromValue:(NSValue *)fromValue toValue:(NSValue *)toValue
{
    // 不透明度
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = 0.5f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fromValue = fromValue;
    animation.toValue = toValue;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
//    animation.repeatCount = HUGE_VAL;
    // 配置委托，告诉动作执行完成
//    animation.delegate = self;
    [self.view.layer addAnimation:animation forKey:@"opacity"];
}

- (void)rotationFromValue:(NSValue *)fromValue toValue:(NSValue *)toValue
{
    // 翻转
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 0.5f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fromValue = fromValue;
    animation.toValue = toValue;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
//    animation.repeatCount = HUGE_VAL;
    [self.view.layer addAnimation:animation forKey:@"rotation"];
}

- (void)translationFromValue:(NSValue *)fromValue toValue:(NSValue *)toValue
{
    // 平移效果
    // keyPath决定了基础动画类型
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = 0.5f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    // 动画开始位置
    animation.fromValue = fromValue;
    // 动画结束位置
    animation.toValue = toValue;
    /* NSNumber:封装简单数据类型为对象
     * NSValue: 封装复杂数据类型为对象, CGPoint, CGRect, CGSize
     */
    
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
//    animation.repeatCount = HUGE_VAL;
    [self.view.layer addAnimation:animation forKey:@"positon"];
}

- (void)startBasicAnimation
{
    // 平移效果
    [self translationFromValue:[NSValue valueWithCGPoint:CGPointMake(160, 284)] toValue:[NSValue valueWithCGPoint:CGPointMake(160, 150)]];
    
    // 翻转效果
    [self rotationFromValue:@0 toValue:@(M_PI)];
    
    // 不透明度
    [self opacityFromValue:@1 toValue:@0.5];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self startBasicAnimation];
    [self performSelector:@selector(animationDidStop) withObject:nil afterDelay:0.5f];
}


@end
