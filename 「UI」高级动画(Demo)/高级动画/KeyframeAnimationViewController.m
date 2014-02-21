//
//  KeyframeAnimationViewController.m
//  高级动画
//
//  Created by 张鹏 on 14-2-20.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "KeyframeAnimationViewController.h"

@interface KeyframeAnimationViewController ()

- (void)initializeUserInterface;
- (void)startKeyframeAnimation;

@end

@implementation KeyframeAnimationViewController

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
    label.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label];
}

- (void)startKeyframeAnimation {
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 3.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.keyTimes = @[@0.0, @0.25, @0.5, @0.75, @1.0];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 160, 284);
    CGPathAddLineToPoint(path, NULL, 160, 284 + 150);
    CGPathAddLineToPoint(path, NULL, 280, 284 + 150);
    CGPathAddLineToPoint(path, NULL, 280, 284 - 150);
    CGPathAddLineToPoint(path, NULL, 160, 284);
    animation.path = path;
    CGPathRelease(path);
    [self.view.layer addAnimation:animation forKey:@"position"];
}

@end
