//
//  ViewController.m
//  UITask
//
//  Created by cuan on 14-1-22.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "ViewController.h"
#import "RedViewController.h"

@interface ViewController ()

@end

@implementation ViewController

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
    
    UILabel *label      = [[UILabel alloc] initWithFrame:CGRectMake(60, 259, 200, 50)];
    label.text          = @"Tap show red view";
    label.textAlignment = NSTextAlignmentCenter;
    label.tag           = 10;
    [self.view addSubview:label];
    [label release];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    RedViewController *redViewController = [[[RedViewController alloc] init] autorelease];
    [self presentViewController:redViewController animated:NO completion:^{
        NSLog(@"RedViewControllerr is show. ");
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
