//
//  RandomViewController.m
//  UITask
//
//  Created by cuan on 14-2-10.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "RandomViewController.h"
#import "UIColor+Expand.h"

@interface RandomViewController ()

@end

@implementation RandomViewController

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
    self.navigationController.toolbarHidden = YES;
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor specialRandomColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.bounds = CGRectMake(0, 0, self.view.frame.size.width, 20);
    label.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame));
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [NSString stringWithFormat:@"ViewController"];
    [self.view addSubview:label];
    [label release];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
