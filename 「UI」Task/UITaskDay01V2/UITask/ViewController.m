//
//  ViewController.m
//  UITask
//
//  Created by cuan on 14-1-22.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "ViewController.h"

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
    
    UIView *view         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 160, 568)];
    view.tag             = 100;
    view.backgroundColor = [UIColor redColor];
    view.hidden          = YES;
    [self.view addSubview:view];
    [view release];
    
    UILabel *label      = [[UILabel alloc] initWithFrame:CGRectMake(60, 259, 200, 50)];
    label.tag = 101;
    label.text          = @"Tap show red view";
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    [label release];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIView *view          = (UIView *)[self.view viewWithTag:100];
    BOOL isHidden         = view.hidden == YES ? NO : YES;
    view.hidden           = isHidden;

    UILabel *label        = (UILabel *)[self.view viewWithTag:101];
    NSString *labelString = [label.text isEqualToString:@"Tap show red view"] ?
                                @"Tap show blue view" : @"Tap show red view";
    label.text            = labelString;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
