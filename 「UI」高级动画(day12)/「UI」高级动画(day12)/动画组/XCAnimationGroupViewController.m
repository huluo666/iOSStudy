//
//  XCAnimationGroupViewController.m
//  「UI」高级动画(day12)
//
//  Created by 萧川 on 14-2-21.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "XCAnimationGroupViewController.h"

@interface XCAnimationGroupViewController ()

- (void)initUserInterface;
- (void)startAnimationGroup;

@end

@implementation XCAnimationGroupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"动画组";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self initUserInterface];
}

- (CABasicAnimation *)opacityFromValue:(NSValue *)fromValue toValue:(NSValue *)toValue
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = 0.5f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fromValue = fromValue;
    animation.toValue = toValue;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}

- (CABasicAnimation *)rotationFromValue:(NSValue *)fromValue toValue:(NSValue *)toValue
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 0.5f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fromValue = fromValue;
    animation.toValue = toValue;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}

- (CABasicAnimation *)translationFromValue:(NSValue *)fromValue toValue:(NSValue *)toValue
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = 0.5f;
    // 动画延迟时间
//    animation.beginTime = 0.6;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fromValue = fromValue;
    animation.toValue = toValue;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}

- (void)startAnimationGroup
{
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    // 动画组时长大于等于子动画时长
    animationGroup.duration = 0.5;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animationGroup.animations = @[
          [self translationFromValue:[NSValue valueWithCGPoint:CGPointMake(160, 284)]
                             toValue:[NSValue valueWithCGPoint:CGPointMake(160, 150)]],
          [self rotationFromValue:@0 toValue:@(M_PI)],
          [self opacityFromValue:@1 toValue:@0.5]
                                  ];
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    [self.view.layer addAnimation:animationGroup forKey:@"animationGroup"];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self startAnimationGroup];
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
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 150, 150);
    button.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame));
    button.backgroundColor = [UIColor lightGrayColor];
    
    // 图层属性
    // CALayer为UIView提供显示支持
    button.layer.cornerRadius = 75;                             // 配置视图圆角半径
    button.layer.borderColor = [UIColor greenColor].CGColor;    // 配置边框颜色
    button.layer.borderWidth = 1.0f;                            // 配置边框宽度
    button.layer.shadowColor = [UIColor redColor].CGColor;      // 配置阴影颜色
    button.layer.shadowOpacity = 0.5;                           // 配置阴影不透明度
    button.layer.shadowOffset = CGSizeMake(-40, -20);           // 配置阴影偏移量
//    [self.view addSubview:button];
 
}

@end
