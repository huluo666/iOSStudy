//
//  DDModalViewController.m
//  「Demo」IOS7Transition
//
//  Created by 萧川 on 14-4-10.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDModalViewController.h"

@interface DDModalViewController ()

@end

@implementation DDModalViewController

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
    self.view.backgroundColor = [UIColor greenColor];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
