//
//  MainViewController.m
//  UIViewAnimation
//
//  Created by wei.chen on 13-1-8.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)dealloc {
    [_myView release];
    [_parentView release];
    [super dealloc];
}

- (IBAction)starAnimation:(UIButton *)sender {
    
//    [UIView beginAnimations:@"testAnimation" context:@"test"];
//    [UIView setAnimationDuration:0.5];
////    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationDelegate:self];
//    
//    [UIView setAnimationDidStopSelector:@selector(animationStop)];
//    
//    CGRect frame = self.myView.frame;
//    frame.origin.y = 400;
//    
//    self.myView.frame = frame;
//    
//    [UIView commitAnimations];
    
    self.myView.alpha = 1;
    self.myView.transform = CGAffineTransformScale(self.myView.transform, 1, 1);
    
    [UIView animateWithDuration:0.7 animations:^{
        [UIView setAnimationRepeatCount:1000];
        
//        CGRect frame = self.myView.frame;
//        frame.origin.y += 200;
//        self.myView.frame = frame;
        
        self.myView.alpha = 0;
        
        self.myView.transform = CGAffineTransformScale(self.myView.transform, 0.01, 0.01);
        
    } completion:^(BOOL finished){
        if (finished) {
            [UIView animateWithDuration:0.7 animations:^{
//                CGRect frame = self.myView.frame;
//                frame.origin.y -= 200;
//                self.myView.frame = frame;
                self.myView.alpha = 1;
                self.myView.transform = CGAffineTransformIdentity;
            }];
        }
    }];
    
}

- (void)animationStop {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    CGRect frame = self.myView.frame;
    frame.origin.y = 54;
    self.myView.frame = frame;
    [UIView commitAnimations];
}

- (IBAction)transitionAction:(id)sender {
    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.5];
//
//    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.parentView cache:YES];
//    
//    [UIView commitAnimations];
//    
//    [self.parentView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    
    
    //block动画语法
    [UIView transitionWithView:self.parentView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            [self.parentView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    } completion:NULL];
    
    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.5];
//
//    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:YES];
//
//    [UIView commitAnimations];
//    
//    UIViewController *viewContr = [[UIViewController alloc] init];
//    [self.navigationController pushViewController:viewContr animated:NO];

    
}
@end
