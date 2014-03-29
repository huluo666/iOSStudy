//
//  DDMainUINaviController.m
//  LighterReader
//
//  Created by 萧川 on 14-3-28.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDMainUINaviController.h"
#import "DDPresentAnimation.h"
#import "DDDismissAnimation.h"

@interface DDMainUINaviController ()

@end

@implementation DDMainUINaviController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationBar.barTintColor = [UIColor whiteColor];
        self.navigationBar.tintColor = [UIColor grayColor];
        [self.navigationBar setBackgroundImage:DDImageWithName(@"navi")
                                 forBarMetrics:UIBarMetricsDefault];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - UIViewControllerTransitioningDelegate

// Present
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[[DDPresentAnimation alloc] init] autorelease];
    
}

// Dismiss
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[[DDDismissAnimation alloc] init] autorelease];
}

@end
