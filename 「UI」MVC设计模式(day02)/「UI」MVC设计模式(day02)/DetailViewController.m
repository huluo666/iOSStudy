//
//  DetailViewController.m
//  「UI」MVC设计模式(day02)
//
//  Created by cuan on 14-1-22.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

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
    
	self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 320, 50)];
    label.text = @"Detail View Controller";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:28];
    [self.view addSubview:label];
    [label release];
    
    UIButton *detailButton = [UIButton buttonWithType:UIButtonTypeSystem];
    detailButton.bounds = CGRectMake(0, 0, 100, 50);
    detailButton.center = CGPointMake(20, 30);
    [detailButton setTitle:@"Back" forState:UIControlStateNormal];
    [detailButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:detailButton];
    
}

- (void)back:(UIButton *)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        NSLog(@"返回deatail");
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
