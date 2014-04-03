//
//  DDViewController.m
//  LighterReader
//
//  Created by 萧川 on 14-4-3.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDViewController.h"
#import "DDTableViewController.h"

@interface DDViewController ()

@end

@implementation DDViewController

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
    
    UIView *view = [[UIView alloc] init];
    [self.view addSubview:view];
    
//    self.automaticallyAdjustsScrollViewInsets = YES;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = [UIColor redColor];
    
    DDTableViewController *table = [[DDTableViewController alloc] init];
    table.view.frame = self.view.bounds;
    [self addChildViewController:table];
    [self.view addSubview:table.view];
    
    
    NSLog(@"%@", table.view);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
