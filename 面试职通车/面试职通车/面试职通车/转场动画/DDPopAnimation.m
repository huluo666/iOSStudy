//
//  DDPopAnimation.m
//  面试职通车
//
//  Created by 萧川 on 14-4-16.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDPopAnimation.h"

@implementation DDPopAnimation

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // 1. Get controllers from transition context
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // 2. Set init frame for fromVC
    CGRect initFrame = [transitionContext initialFrameForViewController:fromVC];

    toVC.view.frame = CGRectMake(-CGRectGetMidX(initFrame),
                                 initFrame.origin.y,
                                 CGRectGetWidth(initFrame),
                                 CGRectGetHeight(initFrame));
    
    // 3. Add target view to the container, and move it to back.
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromVC.view];
    [containerView sendSubviewToBack:toVC.view];
    
    // 4. Do animate now
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        fromVC.view.frame = CGRectMake(CGRectGetWidth(initFrame),
                                       initFrame.origin.y,
                                       CGRectGetWidth(initFrame),
                                       CGRectGetHeight(initFrame));
        toVC.view.frame = initFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
