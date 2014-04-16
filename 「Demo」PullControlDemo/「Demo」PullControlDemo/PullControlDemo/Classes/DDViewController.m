//
//  DDViewController.m
//  「Demo」PullControlDemo
//
//  Created by 萧川 on 14-4-12.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDViewController.h"
#import "DDDetailViewController.h"
#import "DDBlockViewController.h"
#import "DDDelegateViewController.h"
#import "DDModalViewController.h"

@interface DDViewController ()

@end

@implementation DDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"PullControlDemo";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    UIButton *delegateButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    delegateButton.bounds = CGRectMake(0, 0, width / 2 - 20, 40);
    delegateButton.center = CGPointMake(CGRectGetMidX(self.view.bounds) -
                                        CGRectGetMidX(delegateButton.bounds) - 10,
                                        CGRectGetMidY(self.view.bounds));
    [delegateButton setTitle:@"delegate" forState:UIControlStateNormal];
    delegateButton.layer.borderWidth = 1;
    delegateButton.layer.borderColor = [UIColor grayColor].CGColor;
    delegateButton.layer.cornerRadius = 5;
    delegateButton.tag = 999;
    [delegateButton addTarget:self
                                action:@selector(pushAction:)
                      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:delegateButton];

    UIButton *blockButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    blockButton.bounds = CGRectMake(0, 0, width / 2 - 20, 40);
    blockButton.center = CGPointMake(CGRectGetMidX(self.view.bounds) +
                                        CGRectGetMidX(blockButton.bounds) + 10,
                                        CGRectGetMidY(self.view.bounds));
    [blockButton setTitle:@"block" forState:UIControlStateNormal];
    blockButton.layer.borderWidth = 1;
    blockButton.layer.borderColor = [UIColor grayColor].CGColor;
    blockButton.layer.cornerRadius = 5;
    blockButton.tag = 998;
    [blockButton addTarget:self
                       action:@selector(pushAction:)
             forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:blockButton];


    UIButton *tableViewButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    tableViewButton.bounds = CGRectMake(0, 0, width / 2 - 20, 40);
    tableViewButton.center = CGPointMake(CGRectGetMidX(delegateButton.frame),
                                         CGRectGetMaxY(delegateButton.frame) +
                                         CGRectGetHeight(tableViewButton.bounds));
    [tableViewButton setTitle:@"tableView" forState:UIControlStateNormal];
    tableViewButton.layer.borderWidth = 1;
    tableViewButton.tag = 997;
    tableViewButton.layer.borderColor = [UIColor grayColor].CGColor;
    tableViewButton.layer.cornerRadius = 5;
    [tableViewButton addTarget:self
                    action:@selector(pushAction:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tableViewButton];

    UIButton *modalVCButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    modalVCButton.bounds = CGRectMake(0, 0, width / 2 - 20, 40);
    modalVCButton.center = CGPointMake(CGRectGetMidX(blockButton.frame),
                                         CGRectGetMaxY(blockButton.frame) +
                                         CGRectGetHeight(modalVCButton.bounds));
    [modalVCButton setTitle:@"modalVC" forState:UIControlStateNormal];
    modalVCButton.layer.borderWidth = 1;
    modalVCButton.layer.borderColor = [UIColor grayColor].CGColor;
    modalVCButton.layer.cornerRadius = 5;
    [modalVCButton addTarget:self
                        action:@selector(pushAction:)
              forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:modalVCButton];


}

- (void)pushAction:(UIButton *)sender {

    NSInteger index = sender.tag;
    if (998 == index) {
        DDBlockViewController *blockVC = [[DDBlockViewController alloc] init];
        [self.navigationController pushViewController:blockVC animated:YES];
    } else if (999 == index){
        DDDelegateViewController *delegateVC = [[DDDelegateViewController alloc] init];
        [self.navigationController pushViewController:delegateVC animated:YES];
    } else if (997 == index) {
        DDDetailViewController *detailVC = [[DDDetailViewController alloc] init];
        [self.navigationController pushViewController:detailVC animated:NO];
    } else {
        DDModalViewController *modalVC = [[DDModalViewController alloc] init];
        [self presentViewController:modalVC animated:YES completion:NULL];
    }
}

@end
