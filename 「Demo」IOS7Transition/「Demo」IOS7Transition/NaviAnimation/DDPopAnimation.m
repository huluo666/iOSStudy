//
//  DDPopAnimation.m
//  「Demo」IOS7Transition
//
//  Created by 萧川 on 14-4-10.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDPopAnimation.h"

@implementation DDPopAnimation

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.8f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [[transitionContext containerView] addSubview:toViewController.view];
    
    toViewController.view.alpha = 0;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromViewController.view.transform = CGAffineTransformMakeScale(0, 0);
        toViewController.view.alpha = 1;
    } completion:^(BOOL finished) {
        fromViewController.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}


@end
