//
//  DDViewController.m
//  「Demo」下拉刷新上拉关闭
//
//  Created by 萧川 on 14-4-12.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDViewController.h"
#import "DDPullDownViewController.h"
#import "DDPullUpViewController.h"
#import "DDQBPullViewController.h"

@interface DDViewController ()

@end

@implementation DDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    UIButton *goToPullDownButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    goToPullDownButton.bounds = CGRectMake(0, 0, width / 2 - 20, 40);
    goToPullDownButton.center = CGPointMake(CGRectGetMidX(self.view.bounds) / 2, CGRectGetMidY(self.view.bounds));
    goToPullDownButton.tag = 100;
    [goToPullDownButton setTitle:@"goToPullDownVC" forState:UIControlStateNormal];
    goToPullDownButton.layer.borderWidth = 1;
    goToPullDownButton.layer.borderColor = [UIColor grayColor].CGColor;
    goToPullDownButton.layer.cornerRadius = 5;
    [goToPullDownButton addTarget:self
                           action:@selector(pushAction:)
                 forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goToPullDownButton];
    
    UIButton *goToPullUpButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    goToPullUpButton.bounds = CGRectMake(0, 0, width / 2 - 20, 40);
    goToPullUpButton.center = CGPointMake(CGRectGetMidX(self.view.bounds) / 2 * 3, CGRectGetMidY(self.view.bounds));
    [goToPullUpButton setTitle:@"goToPullUpVC" forState:UIControlStateNormal];
    goToPullUpButton.tag = 101;
    goToPullUpButton.layer.borderWidth = 1;
    goToPullUpButton.layer.borderColor = [UIColor grayColor].CGColor;
    goToPullUpButton.layer.cornerRadius = 5;
    [goToPullUpButton addTarget:self
                         action:@selector(pushAction:)
               forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goToPullUpButton];
    
    UIButton *goToQBPullControlButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    goToQBPullControlButton.bounds = CGRectMake(0, 0, width / 2 - 20, 40);
    goToQBPullControlButton.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds) + CGRectGetHeight(goToQBPullControlButton.bounds) * 2);
    [goToQBPullControlButton setTitle:@"goToQBPullControl" forState:UIControlStateNormal];
    goToQBPullControlButton.layer.borderWidth = 1;
    goToQBPullControlButton.layer.borderColor = [UIColor grayColor].CGColor;
    goToQBPullControlButton.layer.cornerRadius = 5;
    [goToQBPullControlButton addTarget:self
                         action:@selector(pushAction:)
               forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goToQBPullControlButton];
}

- (void)pushAction:(UIButton *)sender {
    
    NSInteger index = sender.tag;
    if (100 == index) {
        // pull down vc
        DDPullDownViewController *pullDownVC = [[DDPullDownViewController alloc] init];
        [self.navigationController pushViewController:pullDownVC animated:YES];
    } else if (101 == index) {
        // pull up vc
        DDPullUpViewController *pullUpVC = [[DDPullUpViewController alloc] init];
        [self.navigationController pushViewController:pullUpVC animated:YES];
    } else {
        DDQBPullViewController *qbPull = [[DDQBPullViewController alloc] init];
        [self.navigationController pushViewController:qbPull animated:YES];
    }
}

@end
