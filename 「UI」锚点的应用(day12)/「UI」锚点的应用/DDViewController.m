//
//  DDViewController.m
//  「UI」锚点的应用
//
//  Created by 萧川 on 14-2-21.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "DDViewController.h"

@interface DDViewController ()

@end

/*
 * anchorPoint、position、frame、bound之间的计算公式
 * frame.size.width = bounds.size.width
 * frame.size.height = bounds.size.height
 * frame.origin.x = position.x - anchorPoint.x * bounds.size.width
 * frame.origin.y = position.y - anchorPoint.y * bounds.size.height
 */

@implementation DDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 150, 150);
    button.center = self.view.center;
    // 修改锚点的值
    button.layer.anchorPoint = CGPointMake(0.5, 0.5);
    button.backgroundColor = [UIColor grayColor];
    [button addTarget:self
               action:@selector(buttonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    NSLog(@"anchor point = %@", NSStringFromCGPoint(button.layer.anchorPoint));
    NSLog(@"center point = %@", NSStringFromCGPoint(button.center));
}

- (void)buttonPressed:(UIButton *)sender
{
    [UIView animateWithDuration:0.5f animations:^{
//        sender.transform = CGAffineTransformRotate(sender.transform, M_PI_2);
        sender.transform = CGAffineTransformScale(sender.transform, 2, 2);
    } completion:^(BOOL finished) {
//        [self performSelector:_cmd withObject:sender afterDelay:0.5];
    }];
}

@end
