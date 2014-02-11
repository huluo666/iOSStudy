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

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self initUserInterface];
}

- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"UIView Gesture";
    
    UIView *view = [[UIView alloc] init];
    view.bounds = CGRectMake(0, 0, 200, 200);
    view.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame));
    view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view];
    [view release];
}


@end
