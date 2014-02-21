//
//  ViewController.m
//  2014.2.21plus
//
//  Created by 张鹏 on 14-2-21.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

- (void)buttonPressed:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 150, 150);
    button.center = CGPointMake(160, 284);
    // 修改锚点值
    button.layer.anchorPoint = CGPointMake(-0.5, 0);
    button.backgroundColor = [UIColor blackColor];
    [button addTarget:self
               action:@selector(buttonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    NSLog(@"anchor point = %@", NSStringFromCGPoint(button.layer.anchorPoint));
    NSLog(@"center = %@", NSStringFromCGPoint(button.center));
}

- (void)buttonPressed:(UIButton *)sender {
    
    [UIView animateWithDuration:0.5 animations:^{
        sender.transform = CGAffineTransformScale(sender.transform, 1.2, 1.2);
    } completion:^(BOOL finished) {
        [self performSelector:_cmd withObject:sender afterDelay:0.5];
    }];
}

@end
















