//
//  AppDelegate.m
//  「UI」网络
//
//  Created by 萧川 on 14-2-19.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "AppDelegate.h"
#import "RequestViewController.h"
#import "WebViewController.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    RequestViewController *reauestVC = [[RequestViewController alloc] init];
    UINavigationController *requestNavi = [[UINavigationController alloc] initWithRootViewController:reauestVC];
    [reauestVC release];
    application.statusBarStyle = UIStatusBarStyleLightContent;
    WebViewController *webVC = [[WebViewController alloc] init];
    UINavigationController *webNai = [[UINavigationController alloc] initWithRootViewController:webVC];
    [webVC release];
    
    NSArray *navis = @[requestNavi, webNai];
    [requestNavi release];
    [webNai release];
    
    for (UINavigationController *navi in navis) {
        navi.navigationBar.tintColor = [UIColor whiteColor];
        navi.navigationBar.barTintColor = [UIColor colorWithRed:0.267 green:0.633 blue:1.000 alpha:1.000];
        navi.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                   NSFontAttributeName:[UIFont systemFontOfSize:14.0f]};
    }
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = navis;
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
