//
//  DDViewController.m
//  CrachDemo
//
//  Created by 萧川 on 14-4-15.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDViewController.h"
#import "DDReadViewController.h"

@interface DDViewController ()

@end

@implementation DDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    DDReadViewController *readVC = [[DDReadViewController alloc] init];
    [self.navigationController pushViewController:readVC animated:YES];
}


@end
