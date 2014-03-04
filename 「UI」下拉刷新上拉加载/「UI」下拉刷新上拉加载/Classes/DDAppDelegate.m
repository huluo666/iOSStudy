//
//  DDAppDelegate.m
//  「UI」下拉刷新下拉加载
//
//  Created by 萧川 on 14-2-25.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDAppDelegate.h"
#import "DDTableViewController.h"
#import "DDCollectionViewController.h"

@implementation DDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];

    // 表视图控制器
    DDTableViewController *tableVC = [[DDTableViewController alloc] init];
    UINavigationController *tableNavi = [[UINavigationController alloc]
                                    initWithRootViewController:tableVC];
    [tableVC release];
    // 集合视图控制器
    DDCollectionViewController *collectionVC = [[DDCollectionViewController alloc] init];
    UINavigationController *collectionNavi = [[UINavigationController alloc]
                                              initWithRootViewController:collectionVC];
    [collectionVC release];
    
    // 标签栏控制器
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[tableNavi, collectionNavi];
    [tableNavi release];
    [collectionNavi release];
    
    self.window.rootViewController = tabBarController;
    [tabBarController release];
    
    // 导航栏显示效果配置
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor magentaColor]}];
    // 标签栏显示效果配置
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor magentaColor]}
                                             forState:UIControlStateSelected];

    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
