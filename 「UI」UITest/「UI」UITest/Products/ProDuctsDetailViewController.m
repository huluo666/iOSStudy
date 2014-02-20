//
//  ProDuctsDetailViewController.m
//  「UI」UITest
//
//  Created by 萧川 on 14-2-20.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "ProductsDetailViewController.h"

@interface ProductsDetailViewController ()

- (void)initUserInterface;

@end

@implementation ProductsDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)dealloc
{
    [_text release];
    [super dealloc];
}

- (id)initWithText:(NSString *)text
{
    if (self = [super init]) {
        self.text = text;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUserInterface];
	[self loadGestureRecognizer];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)initUserInterface
{
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.frame];
    label.font = [UIFont systemFontOfSize:22.0f];
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.text = _text;
    [self.view addSubview:label];
    [label release];
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
