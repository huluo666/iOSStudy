//
//  DDRootViewController.m
//  「UI」BlockCircularReference
//
//  Created by 萧川 on 3/4/14.
//  Copyright (c) 2014 CUAN. All rights reserved.
//

#import "DDRootViewController.h"
#import "DDBlockButton.h"
#import "DDDetailViewController.h"

@interface DDRootViewController ()

- (void)initializeUserInterface;

@end

@implementation DDRootViewController

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
    [self initializeUserInterface];
}

- (void)initializeUserInterface
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    DDBlockButton *button = [[DDBlockButton alloc] initWithFrame:CGRectMake(100, 30, 100, 30)];
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:@"下一页" forState:UIControlStateNormal];
    button.clickBlock = ^(DDBlockButton *button) {
        DDDetailViewController *detailVC = [[DDDetailViewController alloc] init];
        [self presentViewController:detailVC animated:YES completion:nil];
        [detailVC release];
    };
    [self.view addSubview:button];
    [button release];
}

@end
