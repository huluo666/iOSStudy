//
//  GestureViewController.m
//  「UI」动画、触摸、手势(day05)
//
//  Created by cuan on 14-2-11.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "GestureViewController.h"

@interface GestureViewController ()

- (void)initUserInterface;

@end

@implementation GestureViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    if (self = [super init])
    {
        self.title =  @"UIView Gesture";
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
    self.view.backgroundColor = [UIColor whiteColor];
    
    UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(processGesture:)];
    swip.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swip];
    [swip release];
}

- (void)processGesture:(UISwipeGestureRecognizer *)swip
{
    NSLog(@"swip");
}

@end
