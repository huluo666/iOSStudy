//
//  ViewController2.m
//  2014.2.21
//
//  Created by 张鹏 on 14-2-21.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "ViewController2.h"
#import "UIColor+Expand.h"

@interface ViewController2 ()

- (void)initializeUserInterface;
- (void)startAnimationTransition;

@end

@implementation ViewController2

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
    
    [self startAnimationTransition];
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

- (void)startAnimationTransition {
    
    self.view.backgroundColor = [UIColor specialRandomColor];
    
    NSArray *subtypes = @[kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromBottom, kCATransitionFromTop];
    
    // QuartzCore.framework
    // 初始化CATransition
    CATransition *transition = [CATransition animation];
    // 持续时长
    transition.duration = 1.0;
    // 线性变换规律
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    // 配置动画主要类型
    // CATransition私有类型：若食用，无法上架Appstore
    // cube suckEffect oglFlip rippleEffect p7ageCurl pageUnCurl cameraIrisHollowOpen cameraIrisHollowClose
    transition.type = @"cameraIrisHollowClose";
    // 配置动画子类型（方向）
    transition.subtype = subtypes[arc4random() % 4];
    // 配置动画是否需要逆向执行
    transition.autoreverses = YES;
    // 执行动画，key标识了动画的唯一性，若重复则覆盖
    [self.view.layer addAnimation:transition forKey:@"Transition"];
}

@end















