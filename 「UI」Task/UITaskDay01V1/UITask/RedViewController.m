//
//  RedViewController.m
//  UITask
//
//  Created by cuan on 14-1-22.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "RedViewController.h"

@interface RedViewController ()

@end

@implementation RedViewController

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
	
    self.view.backgroundColor = [UIColor blueColor];
    
    UILabel *placeholderLabel        = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 568)];
    placeholderLabel.textAlignment   = NSTextAlignmentCenter;
    placeholderLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:placeholderLabel];
    [placeholderLabel release];
    
    UILabel *label      = [[UILabel alloc] initWithFrame:CGRectMake(60, 259, 200, 50)];
    label.text          = @"Tap show blue view";
    label.textAlignment = NSTextAlignmentCenter;
    label.tag           = 10;
    [self.view addSubview:label];
    [label release];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.presentingViewController dismissViewControllerAnimated:NO completion:^{
        NSLog(@"返回deatail");
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
