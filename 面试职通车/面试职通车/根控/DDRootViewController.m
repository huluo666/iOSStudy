//
//  DDRootViewController.m
//  面试职通车
//
//  Created by 萧川 on 14-4-16.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDRootViewController.h"
#import "DDHomeViewController.h"
#import "DDPushAnimation.h"
#import "DDPopAnimation.h"

@interface DDRootViewController () <UINavigationControllerDelegate>

@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *interactionController;

@end

@implementation DDRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 加载主页
    DDHomeViewController *homeVC = [[DDHomeViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc]
                                    initWithRootViewController:homeVC];
    navi.delegate = self;
    [self addChildViewController:navi];
    [self.view addSubview:navi.view];
    
    // 修改导航栏样式
    UIImage *barImage = DDImageWithName(@"title_back");
    [[UINavigationBar appearance] setBackgroundImage:barImage forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    NSDictionary *textAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor],
                                     NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:16.0]};
    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
