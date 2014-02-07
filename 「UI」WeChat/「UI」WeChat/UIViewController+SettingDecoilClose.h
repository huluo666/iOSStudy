//
//  UIViewController+SettingDecoilClose.h
//  「UI」WeChat
//
//  Created by cuan on 14-2-6.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SettingDecoilClose)

- (void)settingDecoilCloseWithFrame:(CGRect)frame color:(UIColor *)color tableViewDataSource:(id <UITableViewDataSource>) dataSource tableViewDalegate:(id <UITableViewDelegate>) delegate forViewController:(UIViewController *)viewController;

@end
