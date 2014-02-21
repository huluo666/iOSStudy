//
//  ViewController5.m
//  2014.2.21
//
//  Created by 张鹏 on 14-2-21.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "ViewController5.h"

@interface ViewController5 ()

- (void)initializeUserInterface;
- (void)startAnimationGroup;

@end

@implementation ViewController5

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
    
    [self startAnimationGroup];
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

- (void)startAnimationGroup {
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"position"];
    animation1.duration = 1;
    // 动画延迟执行时间
    animation1.beginTime = 0.0;
    animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation1.fromValue = [NSValue valueWithCGPoint:CGPointMake(160, 284)];
    animation1.toValue = [NSValue valueWithCGPoint:CGPointMake(160, 100)];
    animation1.removedOnCompletion = NO;
    animation1.fillMode = kCAFillModeForwards;
    
    // 翻转
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    animation2.duration = 1;
    animation2.beginTime = 1.0;
    animation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation2.fromValue = @0;
    animation2.toValue = @(M_PI);
    animation2.removedOnCompletion = NO;
    animation2.fillMode = kCAFillModeForwards;
    
    // 不透明度
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation3.duration = 1;
    animation3.beginTime = 2.0;
    animation3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation3.fromValue = @1;
    animation3.toValue = @0.5;
    animation3.removedOnCompletion = NO;
    animation3.fillMode = kCAFillModeForwards;
    
    // 动画组
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    // 动画组时长需要大于等于子动画时长
    animationGroup.duration = 3.0;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    // 添加需要同时执行的动画
    animationGroup.animations = @[animation1, animation2, animation3];
    // 保证了动画组动画执行完成后不被移除
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    [self.view.layer addAnimation:animationGroup forKey:@"AnimationGroup"];
}

@end

















