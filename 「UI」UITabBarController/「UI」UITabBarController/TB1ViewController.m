//
//  TB1ViewController.m
//  「UI」UITabBarController
//
//  Created by cuan on 14-1-30.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "TB1ViewController.h"

@implementation TB1ViewController

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor redColor];
    
}

// method one, recommend
// 想要隐藏tabBar必须在视图加载前干掉它，所以不能在viewDidLoad里面执行
// 在视图控制器的视图加入到导航控制器的栈容器之前，设置隐藏属性才会生效
//- (id)init
//{
//    if (self = [super init])
//    {
//        // 隐藏tabBar，method one
//        self.hidesBottomBarWhenPushed = YES; 
//    }
//    return self;
//}

// method two
- (void)viewDidAppear:(BOOL)animated
{
    // 通过改变标签栏控制器view的子view的frame的形式，来达到隐藏标签栏的效果
    NSArray *views = self.tabBarController.view.subviews;
    NSLog(@"``````````%@", views); // <UITabBar: 0x109239a60; frame = (0 519; 320 49)
    UIView *tabBar = views[views.count - 1];
    tabBar.frame = CGRectMake(0, 519+49, 320, 49);
}


@end
