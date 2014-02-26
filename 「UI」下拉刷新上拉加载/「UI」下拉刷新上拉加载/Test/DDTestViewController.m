//
//  DDTestViewController.m
//  「UI」下拉刷新上拉加载
//
//  Created by 萧川 on 14-2-26.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDTestViewController.h"
#import "DDRefreshBaseView.h"

@interface DDTestViewController ()

@end

@implementation DDTestViewController

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
	self.view.backgroundColor = [UIColor whiteColor];
    
    DDRefreshBaseView *refresh = [[DDRefreshBaseView alloc] initWithFrame:CGRectMake(100, 100, 200, 80)];
    refresh.backgroundColor = [UIColor redColor];
    [self.view addSubview:refresh];
    [refresh release];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
