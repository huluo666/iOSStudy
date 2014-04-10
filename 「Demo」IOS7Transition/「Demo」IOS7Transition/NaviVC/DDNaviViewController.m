//
//  DDNaviViewController.m
//  「Demo」IOS7Transition
//
//  Created by 萧川 on 14-4-10.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDNaviViewController.h"

@interface DDNaviViewController ()

@end

@implementation DDNaviViewController

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
	self.view.backgroundColor = [UIColor orangeColor];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backButton.bounds = CGRectMake(0, 0, width / 2 - 20, 40);
    backButton.center = self.view.center;
    [backButton setTitle:@"NaviPopTransition" forState:UIControlStateNormal];
    backButton.layer.borderWidth = 1;
    backButton.layer.borderColor = [UIColor grayColor].CGColor;
    backButton.layer.cornerRadius = 5;
    [backButton addTarget:self
                   action:@selector(transitionAction:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}

- (void)transitionAction:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
