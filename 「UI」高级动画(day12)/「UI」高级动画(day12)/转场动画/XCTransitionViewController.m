//
//  XCTransitionViewController.m
//  「UI」高级动画(day12)
//
//  Created by 萧川 on 14-2-21.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "XCTransitionViewController.h"

@interface XCTransitionViewController ()

- (void)startAniamtionTransition;

@end

@implementation XCTransitionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"转场动画";
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

- (void)startAniamtionTransition
{
    NSArray *subTpyes = @[kCATransitionFromLeft, kCAGravityRight, kCAGravityBottom, kCATransitionFromTop];
    
    // QuartzCore.framework
    CATransition *transition = [CATransition animation];
    // 持续时长
    transition.duration = .2f;
    // 动画线性变换
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    // 动画主要类型
    /* CATransition私有类型: cube suckEffect oglFlip rippleEffect p7ageCurl pageUnCurl cameraIrisHollowOpen cameraIrisHollowClose */
    transition.type = kCATransitionMoveIn;
    // 动画子类型(方向)
    transition.subtype = subTpyes[arc4random()%4];
    // 动画是否需要逆向执行
    transition.autoreverses = YES;
    // 执行动画，key标识动画唯一性, 重复会覆盖
    [self.view.layer addAnimation:transition forKey:@"Transition"];
    self.view.backgroundColor = [UIColor specialRandomColor];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self startAniamtionTransition];
}


@end
