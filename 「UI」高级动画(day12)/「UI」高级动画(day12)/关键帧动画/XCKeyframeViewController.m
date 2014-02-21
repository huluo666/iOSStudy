//
//  XCKeyframeViewController.m
//  「UI」高级动画(day12)
//
//  Created by 萧川 on 14-2-21.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "XCKeyframeViewController.h"

@interface XCKeyframeViewController ()

- (void)startKeyframeAnimation;

@end

@implementation XCKeyframeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"关键帧动画";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self initUserInterface];
}

- (void)startKeyframeAnimation
{
    // 关键帧动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 3.0f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    animation.values = nil; // 每一帧动画值
    
    CGMutablePathRef path = CGPathCreateMutable();
    // 将路径其实位置移动到指定位置
    CGPathMoveToPoint(path, NULL, 160, 284);
    // 为路径画直线
    CGPathAddLineToPoint(path, NULL, 160 + 100, 284 + 100);
    CGPathAddLineToPoint(path, NULL, 160 + 100, 284 + 100);
    CGPathAddLineToPoint(path, NULL, 160 + 100, 284 - 100);
    CGPathAddLineToPoint(path, NULL, 160, 284);
    // 配置关键帧动画路径
    animation.path = path;
    // 释放路径
    CGPathRelease(path);
    // 每一帧如何开始执行
    animation.keyTimes = @[@0.0, @0.2, @0.5, @0.7, @1.0];
    [self.view.layer addAnimation:animation forKey:@"position"];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self startKeyframeAnimation];
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

@end
