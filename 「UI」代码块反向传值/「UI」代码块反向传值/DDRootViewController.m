//
//  DDRootViewController.m
//  「UI」代码块反向传值
//
//  Created by 萧川 on 14-2-24.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "DDRootViewController.h"
#import "DDDetailViewController.h"

@interface DDRootViewController ()

@property (nonatomic, retain) UILabel *display;

@end

@implementation DDRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [_display release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *goNext = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    goNext.bounds = CGRectMake(0, 0, 80, 40);
    goNext.center = CGPointMake(self.view.center.x, self.view.center.y - 80);
    [goNext setTitle:@"去下一页" forState:UIControlStateNormal];
    [goNext addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goNext];
    
    _display = [[UILabel alloc] init];
    _display.bounds = CGRectMake(0, 0, 320, 40);
    _display.center = self.view.center;
    _display.textAlignment = NSTextAlignmentCenter;
    _display.font = [UIFont systemFontOfSize:22.0f];
    [self.view addSubview:_display];
    [_display release];
}

- (void)buttonPressed:(UIButton *)sender
{
 __block   NSString * ste = @"";
    DDDetailViewController *detailVC = [[DDDetailViewController alloc] initWithBlock:^(NSString *str) {
        _display.text = str;
        ste = [@"12" copy];
    }];
    [self presentViewController:detailVC animated:YES completion:nil];
    [detailVC release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
