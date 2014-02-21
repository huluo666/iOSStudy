//
//  ViewController4.m
//  2014.2.21
//
//  Created by 张鹏 on 14-2-21.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "ViewController4.h"

@interface ViewController4 ()

- (void)initializeUserInterface;
- (void)startKeyframeAnimation;

@end

@implementation ViewController4

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
    
    [self startKeyframeAnimation];
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

- (void)startKeyframeAnimation {
    
    // 关键帧动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 4.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    // values：每一针动画的值
//    animation.values = nil;
    
    // 创建路径
    CGMutablePathRef path = CGPathCreateMutable();
    // 将路径起始位置移动到指定位置
    CGPathMoveToPoint(path, NULL, 160, 284);
    // 为路径画直线
    CGPathAddLineToPoint(path, NULL, 160, 284 + 100);
    CGPathAddLineToPoint(path, NULL, 160 + 100, 284 + 100);
    CGPathAddLineToPoint(path, NULL, 160 + 100, 284 - 100);
    CGPathAddLineToPoint(path, NULL, 160, 284);
    // 配置关键帧动画路径
    animation.path = path;
    // 释放路径
    CGPathRelease(path);
    // 每一针如何开始执行 0 - 1
    animation.keyTimes = @[@0.0, @0.25, @0.5, @0.75, @1.0];
    [self.view.layer addAnimation:animation forKey:@"KeyFrameAnimation"];
}

@end

















