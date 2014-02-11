//
//  MainViewController.m
//  EventDemo
//
//  Created by wei.chen on 13-3-1.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "MainViewController.h"
#import "TouchView.h"

@interface MainViewController ()

@end

@implementation MainViewController

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
    
    TouchView *touchView = [[TouchView alloc] initWithFrame:CGRectMake(0, 0, 320, 350)];
    touchView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:touchView];
    
}

//事件的传递
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"MainViewController touchesBegan!");
    
    [self.nextResponder touchesBegan:touches withEvent:event];
}

@end
