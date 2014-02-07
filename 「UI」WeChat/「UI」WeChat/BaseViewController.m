//
//  BaseViewController.m
//  「UI」WeChat
//
//  Created by cuan on 14-2-4.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "BaseViewController.h"
#import "WeChatTabBarController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    WeChatTabBarController *tabBarViewController = (WeChatTabBarController *)self.tabBarController;
    [tabBarViewController hiddenTabBar];
}

- (void)customTitleViewWithText:(NSString *)text
{
#pragma mark TIPS 设置UINavigationItem的titleView时，设置视图宽度小于文本宽度会被文字自动撑大且文字自动居中，故不用设置宽度。设置宽度的话需要设置文字居中，且文字过长还是会撑过边界 。个人推荐设置宽度为0
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
    titleLabel.text = text;
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    [titleLabel release];
}
@end
