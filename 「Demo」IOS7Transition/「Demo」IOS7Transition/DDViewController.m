//
//  DDViewController.m
//  「Demo」IOS7Transition
//
//  Created by 萧川 on 14-4-10.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDViewController.h"
#import "DDModalViewController.h"
#import "DDNaviViewController.h"
#import "DDPresentAnimation.h"
#import "DDDismissAnimation.h"
#import "DDPushAnimation.h"
#import "DDPopAnimation.h"

@interface DDViewController () <
    UIViewControllerTransitioningDelegate
>

@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *interactionController;

@end

@implementation DDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"iOS7Transition";
    
    // add pan gesture
    UIPanGestureRecognizer* panRecognizer = [[UIPanGestureRecognizer alloc]
                                             initWithTarget:self
                                             action:@selector(panGestureRecognizerAction:)];
    [self.navigationController.view addGestureRecognizer:panRecognizer];
    
    // init UI
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    UIButton *modalButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    modalButton.bounds = CGRectMake(0, 0, width / 2 - 20, 40);
    modalButton.center = CGPointMake(CGRectGetMidX(self.view.bounds) / 2, CGRectGetMidY(self.view.bounds));
    modalButton.tag = 100;
    [modalButton setTitle:@"ModalTransition" forState:UIControlStateNormal];
    modalButton.layer.borderWidth = 1;
    modalButton.layer.borderColor = [UIColor grayColor].CGColor;
    modalButton.layer.cornerRadius = 5;
    [modalButton addTarget:self
                    action:@selector(transitionAction:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:modalButton];

    UIButton *naviButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    naviButton.bounds = CGRectMake(0, 0, width / 2 - 20, 40);
    naviButton.center = CGPointMake(CGRectGetMidX(self.view.bounds) / 2 * 3, CGRectGetMidY(self.view.bounds));
    [naviButton setTitle:@"NaivPushTransition" forState:UIControlStateNormal];
    naviButton.layer.borderWidth = 1;
    naviButton.layer.borderColor = [UIColor grayColor].CGColor;
    naviButton.layer.cornerRadius = 5;
    [naviButton addTarget:self
                   action:@selector(transitionAction:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:naviButton];
}

- (void)transitionAction:(UIButton *)sender {
    
    if (100 == sender.tag) {
        // modal
        DDModalViewController *modalVC = [[DDModalViewController alloc] init];
        modalVC.transitioningDelegate = self;
        [self presentViewController:modalVC animated:YES completion:nil];
    } else {
        // navi
        DDNaviViewController *naviVC = [[DDNaviViewController alloc] init];
        [self.navigationController pushViewController:naviVC animated:YES];
    }
}


#pragma mark - <UIViewControllerTransitioningDelegate>

// Present
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                   presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    return [[DDPresentAnimation alloc] init];
    
}

// Dismiss
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    return [[DDDismissAnimation alloc] init];
}

#pragma mark - <UINavigationControllerDelegate>

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPush) {
        return [[DDPushAnimation alloc] init];
    }
    if (operation == UINavigationControllerOperationPop) {
        return [[DDPopAnimation alloc] init];
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    
    return _interactionController;
}

#pragma mark - panGestureRecognizerAction

- (void)panGestureRecognizerAction:(UIPanGestureRecognizer*)recognizer
{
    UIView *view = self.navigationController.view;
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint location = [recognizer locationInView:view];
        if (location.x <  20 &&
            self.navigationController.viewControllers.count > 1) {
            // left half
            _interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:view];
        CGFloat d = fabs(translation.x / CGRectGetWidth(view.bounds));
        [_interactionController updateInteractiveTransition:d];
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        if ([recognizer velocityInView:view].x > 0) {
            [_interactionController finishInteractiveTransition];
        } else {
            [_interactionController cancelInteractiveTransition];
        }
        _interactionController = nil;
    }
}

@end
