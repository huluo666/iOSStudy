//
//  NextViewController.m
//  UIDemoDay03
//
//  Created by cuan on 14-1-23.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()

- (void)initializeUserInteface;
- (IBAction)pressedPreviewPage:(UIButton *)sender;

@end

@implementation NextViewController

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
    
    [self initializeUserInteface];
}

- (void)initializeUserInteface
{
    UIButton *nextPageButton = [UIButton buttonWithType:UIButtonTypeSystem];
    nextPageButton.bounds    = CGRectMake(0, 0, 80, 50);
//    previewNextPage.center = CGPointMake(30, 40);
    nextPageButton.center    = CGPointMake(CGRectGetMinX(self.view.frame) + 30, CGRectGetMinY(self.view.frame)+ 40);
    [nextPageButton setTitle:@"上一页" forState:UIControlStateNormal];
    [nextPageButton addTarget:self action:@selector(pressedPreviewPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextPageButton];
    
    [super viewDidLoad];
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, 254, 200, 60)];
    label.text = @"This is the next page";
    [self.view addSubview:label];
    [label release];
}

- (IBAction)pressedPreviewPage:(UIButton *)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        NSLog(@"切换到上一页");
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
