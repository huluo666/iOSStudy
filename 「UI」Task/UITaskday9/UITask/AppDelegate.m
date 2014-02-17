//
//  AppDelegate.m
//  UITask
//
//  Created by cuan on 14-1-22.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "PhotosViewController.h"
#import "HomePageViewController.h"
#import "SettingViewController.h"
#import "AboutViewController.h"

@interface AppDelegate ()

- (void)initTabBarController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
/*
    RootViewController *rootVC =[[RootViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:rootVC];
    [navi.navigationBar setBarTintColor:[UIColor colorWithWhite:0.349 alpha:1.000]];
//    [navi.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_ios7"] forBarMetrics:UIBarMetricsDefault];
    application.statusBarStyle = UIStatusBarStyleLightContent;
    navi.navigationBar.tintColor = [UIColor whiteColor];
    [navi.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    [rootVC release];
    self.window.rootViewController = navi;
    [navi release];
*/
    
    application.statusBarStyle = UIStatusBarStyleLightContent;
    [self initTabBarController];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)initTabBarController
{
    PhotosViewController *photoVC = [[PhotosViewController alloc] init];
    UINavigationController *photoNavi = [[UINavigationController alloc]
                                         initWithRootViewController:photoVC];
    photoNavi.tabBarItem.image = [UIImage imageNamed:@"photoNavi"];
    [photoVC release];
    
    HomePageViewController *homePageVC = [[HomePageViewController alloc] init];
    UINavigationController *homePageNavi = [[UINavigationController alloc]
                                            initWithRootViewController:homePageVC];
    homePageNavi.tabBarItem.image = [UIImage imageNamed:@"homePageNavi"];
    [homePageVC release];
    
    SettingViewController *settingVC = [[SettingViewController alloc] init];
    UINavigationController *settingNavi = [[UINavigationController alloc]
                                           initWithRootViewController:settingVC];
    settingNavi.tabBarItem.image = [UIImage imageNamed:@"settingNavi"];
    [settingVC release];
    
    AboutViewController *aboutVC = [[AboutViewController alloc] init];
    UINavigationController *aboutNavi = [[UINavigationController alloc]
                                         initWithRootViewController:aboutVC];
    
    aboutNavi.tabBarItem.image = [UIImage imageNamed:@"aboutNavi"];
    [aboutVC release];
    
    NSArray *controllers = @[photoNavi, homePageNavi, settingNavi, aboutNavi];
    [photoNavi release];
    [homePageNavi release];
    [settingNavi release];
    [aboutNavi release];
    
    for (UINavigationController *controller in controllers) {
        [controller.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_ios7"]
                                       forBarMetrics:UIBarMetricsDefault];
        [controller.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                           NSFontAttributeName:[UIFont systemFontOfSize:20]}];
        controller.navigationBar.tintColor = [UIColor whiteColor];
    }
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.tabBar.barTintColor = [UIColor colorWithRed:0.500 green:0.461 blue:0.336 alpha:1.000];
    tabBarController.viewControllers = controllers;
    tabBarController.tabBar.tintColor = [UIColor colorWithRed:1.000 green:0.458 blue:0.353 alpha:1.000];
    tabBarController.selectedIndex = 1;
    self.window.rootViewController = tabBarController;
    
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
