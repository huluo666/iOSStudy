//
//  MJTestViewController.m
//  快速集成下拉刷新
//
//  Created by 萧川 on 14-2-26.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "MJTestViewController.h"
#import "MJRefreshBaseView.h"

@interface MJTestViewController ()

@end

@implementation MJTestViewController

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
//	MJRefreshBaseView *baseView = [[MJRefreshBaseView alloc] initWithFrame:CGRectMake(80, 200, 200, 200)];
    MJRefreshBaseView *baseView = [[MJRefreshBaseView alloc] init];
    baseView.bounds = CGRectMake(0, 0, 200, 80);
    baseView.center = CGPointMake(160, 248);
    
    baseView.backgroundColor = [UIColor redColor];
    [self.view addSubview:baseView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
