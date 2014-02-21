//
//  AnimationGroupViewController.m
//  高级动画
//
//  Created by 张鹏 on 14-2-20.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "AnimationGroupViewController.h"

@interface AnimationGroupViewController ()

- (void)initializeUserInterface;
- (void)startGroupAnimation;

@end

@implementation AnimationGroupViewController

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
    
    [self startGroupAnimation];
}

- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.text = @"Animation";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:40];
    label.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label];
}

- (void)startGroupAnimation {
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"position"];
    animation1.duration = 0.5;
    animation1.beginTime = 0.0;
    animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation1.fromValue = [NSValue valueWithCGPoint:CGPointMake(160, 284)];
    animation1.toValue = [NSValue valueWithCGPoint:CGPointMake(160, 100)];
    animation1.removedOnCompletion = NO;
    animation1.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation2.duration = 0.5;
    animation2.beginTime = 0.5;
    animation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation2.fromValue = @0;
    animation2.toValue = @(M_PI);
    animation2.removedOnCompletion = NO;
    animation2.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation3.duration = 0.5;
    animation3.beginTime = 1.0;
    animation3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation3.fromValue = @1;
    animation3.toValue = @0.5;
    animation3.removedOnCompletion = NO;
    animation3.fillMode = kCAFillModeForwards;
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.duration = 1.5;
    groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    groupAnimation.delegate = self;
    groupAnimation.animations = @[animation1, animation2, animation3];
    groupAnimation.removedOnCompletion = NO;
    groupAnimation.fillMode = kCAFillModeForwards;
    [self.view.layer addAnimation:groupAnimation forKey:@"AnimationGroup"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"position"];
    animation1.duration = 0.5;
    animation1.beginTime = 0.0;
    animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation1.fromValue = [NSValue valueWithCGPoint:CGPointMake(160, 100)];
    animation1.toValue = [NSValue valueWithCGPoint:CGPointMake(160, 284)];
    animation1.removedOnCompletion = NO;
    animation1.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation2.duration = 0.5;
    animation2.beginTime = 0.5;
    animation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation2.fromValue = @(M_PI);
    animation2.toValue = @(M_PI * 2);
    animation2.removedOnCompletion = NO;
    animation2.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation3.duration = 0.5;
    animation3.beginTime = 1.0;
    animation3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation3.fromValue = @0.5;
    animation3.toValue = @1.0;
    animation3.removedOnCompletion = NO;
    animation3.fillMode = kCAFillModeForwards;
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.duration = 1.5;
    groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    groupAnimation.animations = @[animation1, animation2, animation3];
    groupAnimation.removedOnCompletion = NO;
    groupAnimation.fillMode = kCAFillModeForwards;
    [self.view.layer addAnimation:groupAnimation forKey:@"AnimationGroup"];
}

@end
