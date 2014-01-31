//
//  AppDelegate.m
//  「UI」TabBar、Navi联合
//
//  Created by cuan on 14-1-31.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "AppDelegate.h"
#import "ChatController.h"
#import "FindViewController.h"
#import "SettingViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    ChatController *chatVC = [[ChatController alloc] init];
    chatVC.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:102];
    UINavigationController *chatNvaiController = [[UINavigationController alloc] initWithRootViewController:chatVC];
    [chatVC release];
    FindViewController *findVC = [[FindViewController alloc] init];
    findVC.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:101];
    UINavigationController *findNaviController = [[UINavigationController alloc] initWithRootViewController:findVC];
    [findVC release];
    
    SettingViewController *settingVC = [[SettingViewController alloc] initWithStyle:UITableViewStylePlain];
    settingVC.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:103];
    UINavigationController *settingNaivController = [[UINavigationController alloc] initWithRootViewController:settingVC];
    [settingVC release];
    
    NSArray *controllers = @[chatNvaiController, findNaviController, settingNaivController];
    [chatNvaiController release];
    [findNaviController release];
    [settingNaivController release];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = controllers;
    
    self.window.rootViewController = tabBarController;
    
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
