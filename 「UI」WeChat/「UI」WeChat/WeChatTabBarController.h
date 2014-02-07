//
//  ReTabBarViewController.h
//  「UI」WeChat
//
//  Created by cuan on 14-2-1.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainUIViewControllerFather.h"

@interface WeChatTabBarController : UITabBarController <MianVCDelegate>

- (void)showTabBar;
- (void)hiddenTabBar;

@end
