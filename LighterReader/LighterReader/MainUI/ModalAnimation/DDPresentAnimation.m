//
//  DDPresentAnimation.m
//  LighterReader
//
//  Created by 萧川 on 14-3-28.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDPresentAnimation.h"

@implementation DDPresentAnimation

#pragma mark - <UIViewControllerAnimatedTransitioning>

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.8f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    // 1. get controllers from transition context
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // 2. set init frame for toVC
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
//    toVC.view.frame = CGRectMake(-screenBounds.size.width, 0, screenBounds.size.width, screenBounds.size.height);
    toVC.view.frame = CGRectOffset(finalFrame, -screenBounds.size.width, 0);
    // 3. Add toVC's view to containerView
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    // 4. Do animate now
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                          delay:0
         usingSpringWithDamping:1
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         toVC.view.frame = finalFrame;
                     }
                     completion:^(BOOL finished) {
                         // 5. Tell context that we completed.
                         [transitionContext completeTransition:YES];
                     }];
}


@end
