//
//  MainViewController.m
//  CATranstionDemo
//
//  Created by wei.chen on 13-1-8.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (IBAction)transtionAction:(id)sender {

//    CATransition *animation = [CATransition animation];
//    animation.duration = 0.6;
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
//    
//    /**
//        kCATransitionFade
//        kCATransitionMoveIn
//        kCATransitionPush
//     */
//    animation.type = kCATransitionReveal;
//    animation.subtype = kCATransitionFromTop;
//    
//    
//    [self.MyView.layer addAnimation:animation forKey:@"animationKey"];
//    
//    [self.MyView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
//
    
    
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.6;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromLeft;
    
    [self.navigationController.view.layer addAnimation:animation forKey:@"test"];
    
    UIViewController *viewCtrl = [[UIViewController alloc] init];
    [self.navigationController pushViewController:viewCtrl animated:NO];
    
}

- (void)dealloc {
    [_MyView release];
    [super dealloc];
}
@end
