//
//  DetailViewController.m
//  2014.2.17
//
//  Created by 张鹏 on 14-2-17.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

- (void)initializeUserInterface;

@end

@implementation DetailViewController

- (id)init
{
    self = [super init];
    if (self) {
        
        self.title = @"DetailViewController";
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initializeUserInterface];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
}

- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor specialRandomColor];
}

@end

















