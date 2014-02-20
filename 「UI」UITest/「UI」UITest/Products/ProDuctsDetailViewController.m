//
//  ProDuctsDetailViewController.m
//  「UI」UITest
//
//  Created by 萧川 on 14-2-20.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "ProDuctsDetailViewController.h"

@interface ProDuctsDetailViewController ()

@end

@implementation ProDuctsDetailViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
	[self loadGestureRecognizer];
}

- (void)loadGestureRecognizer
{
    UISwipeGestureRecognizer *swipViewRight = [[UISwipeGestureRecognizer alloc]
                                               initWithTarget:self
                                               action:@selector(processGesture:)];
    swipViewRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipViewRight];
    [swipViewRight release];

}

- (void)processGesture:(UISwipeGestureRecognizer *)swip
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
