//
//  RootViewController.m
//  「UI」UINavigationController(day04)
//
//  Created by cuan on 14-2-10.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "RootViewController.h"
#import "FirstViewController.h"
#import "UIColor+Expand.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor specialRandomColor];
    self.title = @"首页";
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"appcoda-logo"]];
    
    UILabel *label = [[UILabel alloc] init];
    label.bounds = CGRectMake(0, 0, 320, 50);
    label.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.frame));
    
    label.text = @"UINavigationController";
    label.font = [UIFont systemFontOfSize:22];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    [label release];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.bounds = CGRectMake(0, 0, 320, 40);;
    button.center = CGPointMake(CGRectGetMidX(self.view.bounds), 120);
    button.layer.borderWidth = 1.0f;
    button.layer.borderColor = [UIColor greenColor].CGColor;
    [button setTitle:@"PUSH" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:NULL];
    UIBarButtonItem *camreaItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:NULL];
    UIBarButtonItem *bookmarkItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:NULL];
    NSArray *tools = @[space, camreaItem, space, bookmarkItem, space];

    self.toolbarItems = tools;
}

- (void)buttonPressed
{
    FirstViewController *firstVC = [[FirstViewController alloc] init];
    [self.navigationController pushViewController:firstVC animated:YES];
    [firstVC release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
