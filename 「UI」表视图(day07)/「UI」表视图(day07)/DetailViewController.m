//
//  DetailViewController.m
//  「UI」表视图(day07)
//
//  Created by cuan on 14-2-13.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

- (void)initUserInterface;

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

- (id)initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        self.title = title;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initUserInterface];
	
}

- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.frame];
    label.text = self.title;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:self.title size:30.0f];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    [self.view addSubview:label];
    [label release];
}

@end
