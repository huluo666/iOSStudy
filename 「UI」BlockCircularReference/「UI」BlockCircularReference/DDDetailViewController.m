//
//  DDDetailViewController.m
//  「UI」BlockCircularReference
//
//  Created by 萧川 on 3/4/14.
//  Copyright (c) 2014 CUAN. All rights reserved.
//

#import "DDDetailViewController.h"
#import "DDBlockButton.h"

@interface DDDetailViewController ()

- (void)initializeUserInterface;

@end

@implementation DDDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

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
    self.view.backgroundColor = [UIColor lightGrayColor];
    
//    // 使用代码块、没有调用dealloc方法
//    DDBlockButton *button = [[DDBlockButton alloc] initWithFrame:CGRectMake(100, 30, 100, 30)];
//    [button setTitle:@"上一页" forState:UIControlStateNormal];
//    button.backgroundColor = [UIColor cyanColor];
//    button.clickBlock = ^(DDBlockButton *button) {
//        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
//    };
//    [self.view addSubview:button];
//    [button release];
    
    // 使用代理方法会调用dealloc方法
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    button.frame = CGRectMake(100, 30, 100, 30);
//    button.backgroundColor = [UIColor greenColor];
//    [button addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
    
    // 通过以上试验，可以知道，代码块中用到的变量会被自动retain一次
    DDBlockButton *button = [[DDBlockButton alloc] initWithFrame:CGRectMake(100, 30, 100, 30)];
    [button setTitle:@"上一页" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor cyanColor];

    __block UIViewController *vc = self;
    button.clickBlock = ^(DDBlockButton *button) {
        [vc.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    };
    [self.view addSubview:button];
    [button release];
}

- (void)buttonPressed
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    NSLog(@"DDDetailViewController dealloc..");
    [super dealloc];
}

@end
