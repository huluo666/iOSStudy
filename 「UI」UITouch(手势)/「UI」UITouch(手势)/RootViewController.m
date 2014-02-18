//
//  RootViewController.m
//  「UI」UITouch(手势)
//
//  Created by 萧川 on 14-2-16.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

- (void)initUserInterface;

@end

@implementation RootViewController

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
    [self initUserInterface];
}

#pragma mark 私有方法

- (void)initUserInterface
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    [self.view addGestureRecognizer:singleTap];
    [singleTap release];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
    [doubleTap release];
    
    [singleTap requireGestureRecognizerToFail:doubleTap];
}

- (void)singleTap:(UITapGestureRecognizer *)tapGetrue {
    NSLog(@"单击");
}

- (void)doubleTap:(UITapGestureRecognizer *)tapGetrue {
    NSLog(@"双击");
}




@end
