//
//  UIViewController+SettingDecoilClose.m
//  「UI」WeChat
//
//  Created by cuan on 14-2-6.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "UIViewController+SettingDecoilClose.h"
#import "WeChatTabBarController.h"

@implementation UIViewController (SettingDecoilClose)

- (void)settingDecoilCloseWithFrame:(CGRect)frame color:(UIColor *)color tableViewDataSource:(id <UITableViewDataSource>) dataSource tableViewDalegate:(id <UITableViewDelegate>) delegate forViewController:(UIViewController *)viewController
{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, 320, 568);
    view.tag = _SETTING_TABLE_BG_VIEW_TAG_;
    view.backgroundColor = [UIColor clearColor];
    
    UITableView *settingTV = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    settingTV.tag = _SETTING_TABLE_VIEW_TAG_;
    settingTV.backgroundColor = color;
    settingTV.dataSource = dataSource;
    settingTV.delegate = delegate;
    settingTV.bounces = NO;
    
    if ([viewController isKindOfClass:[WeChatTabBarController class]])
    {
        [viewController.view addSubview:view];
        [viewController.view addSubview:settingTV];
    }
    else
    {
        [viewController.tabBarController.view addSubview:view];
        [viewController.tabBarController.view addSubview:settingTV];
    }
    [view release];
    [settingTV release];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIView *view = (UIView *)[self.view viewWithTag:_SETTING_TABLE_BG_VIEW_TAG_];
    if (view)
    {
        [view removeFromSuperview];
    }
    
    UITableView *settingTV = (UITableView *)[self.view viewWithTag:_SETTING_TABLE_VIEW_TAG_];
    if (settingTV)
    {
        [settingTV removeFromSuperview];
    }
}

@end
