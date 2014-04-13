//
//  DDViewController.m
//  「Demo」PullControlDemo
//
//  Created by 萧川 on 14-4-12.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDViewController.h"
#import "DDDetailViewController.h"
#import "DDDelegateViewController.h"

@interface DDViewController ()

@end

@implementation DDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    UIButton *goNextPage = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    goNextPage.bounds = CGRectMake(0, 0, width / 2 - 20, 40);
    goNextPage.center = CGPointMake(CGRectGetMidX(self.view.bounds),
                                    CGRectGetMidY(self.view.bounds));
    [goNextPage setTitle:@"goNextPage" forState:UIControlStateNormal];
    goNextPage.layer.borderWidth = 1;
    goNextPage.layer.borderColor = [UIColor grayColor].CGColor;
    goNextPage.layer.cornerRadius = 5;
    [goNextPage addTarget:self
                                action:@selector(pushAction:)
                      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goNextPage];
}

- (void)pushAction:(UIButton *)sender {
    
//    DDDetailViewController *detailVC = [[DDDetailViewController alloc] init];
//    [self.navigationController pushViewController:detailVC animated:YES];
    
    DDDelegateViewController *deleVC = [[DDDelegateViewController alloc] init];
    [self.navigationController pushViewController:deleVC animated:YES];
}

@end
