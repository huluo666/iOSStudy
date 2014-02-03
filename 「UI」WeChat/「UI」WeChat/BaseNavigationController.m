//
//  BaseNavigationController.m
//  「UI」WeChat
//
//  Created by cuan on 14-2-2.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 自定义导航管理器返回按钮

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    viewController.navigationItem.hidesBackButton = YES;
    if (!viewController.navigationItem.leftBarButtonItem && [self.viewControllers count] > 1)
    {
        viewController.navigationItem.leftBarButtonItem = [self customLeftBackButton];
    }
}

- (UIBarButtonItem *)customLeftBackButton
{
    // 左侧间距偏宽，无法调整。。。
    /*
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(0, 0, 50, 49);
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [button setTitle:[NSString stringWithFormat:@"<%@", self.title] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    [button addTarget:self action:@selector(popSelf) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButton = [[[UIBarButtonItem alloc] initWithCustomView:button] autorelease];
    return backButton;
    */

    UIBarButtonItem *item = [[[UIBarButtonItem alloc] init] autorelease];
    item.title = [NSString stringWithFormat:@"<%@", self.title];
    item.tintColor = [UIColor whiteColor];
    item.target = self;
    item.action = @selector(popSelf);
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = item;
    return item;
}

- (void)popSelf
{
    [self popViewControllerAnimated:YES];
}

@end
