//
//  AppDelegate.m
//  「UI」多媒体(day10)
//
//  Created by 萧川 on 14-2-18.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "AppDelegate.h"
#import "AudioViewController.h"
#import "VideoViewController.h"
#import "RecordViewController.h"
    
    @implementation AppDelegate
    
    - (BOOL)application:(UIApplication *)applicatibon didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
    {
        self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
        
        AudioViewController *audioVC = [[AudioViewController alloc] init];
        UINavigationController *audioNavi = [[UINavigationController alloc] initWithRootViewController:audioVC];
        [audioVC release];
        
        VideoViewController *videoVC = [[VideoViewController alloc] init];
        UINavigationController *videoNavi = [[UINavigationController alloc] initWithRootViewController:videoVC];
        [videoVC release];
        
        RecordViewController *recordVC = [[RecordViewController alloc] init];
        UINavigationController *recordNavi = [[UINavigationController alloc] initWithRootViewController:recordVC];
        [recordVC release];
        
        NSArray *navis = @[audioNavi, videoNavi, recordNavi];
        [audioNavi release];
        [videoNavi release];
        [recordNavi release];
        
        for (UINavigationController *navi in navis) {
            navi.navigationBar.tintColor = [UIColor whiteColor];
            navi.navigationBar.barTintColor = [UIColor colorWithRed:0.203 green:0.362 blue:0.495 alpha:1.000];
            navi.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:20.0f]};
        }
        
        UITabBarController *tabBarController = [[UITabBarController alloc] init];
        tabBarController.viewControllers = navis;
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor], NSFontAttributeName:[UIFont systemFontOfSize:12.0f]} forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor], NSFontAttributeName:[UIFont systemFontOfSize:12.0f]} forState:UIControlStateSelected];
        
        self.window.rootViewController = tabBarController;
        
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
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
