//
//  AppDelegate.m
//  「UI」标签控制器(day09)
//
//  Created by 萧川 on 14-2-17.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "ViewController4.h"
#import "ViewController5.h"
#import "ViewController6.h"

@interface AppDelegate ()

- (void)initTabBarController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    [self initTabBarController];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;

}

- (void)initTabBarController
{
    ViewController1 *vc1 = [[ViewController1 alloc] init];
    UINavigationController *navi1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    [navi1.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_ios7"] forBarMetrics:UIBarMetricsDefault];
    [vc1 release];
    
    ViewController2 *vc2 = [[ViewController2 alloc] init];
    UINavigationController *navi2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    [navi2.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_ios7"] forBarMetrics:UIBarMetricsDefault];
    [vc2 release];
    
    ViewController3 *vc3 = [[ViewController3 alloc] init];
    UINavigationController *navi3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    [navi3.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_ios7"] forBarMetrics:UIBarMetricsDefault];
    [vc3 release];
    
    ViewController4 *vc4 = [[ViewController4 alloc] init];
    UINavigationController *navi4 = [[UINavigationController alloc] initWithRootViewController:vc4];
    [navi4.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_ios7"] forBarMetrics:UIBarMetricsDefault];
    [vc4 release];
    
    ViewController5 *vc5 = [[ViewController5 alloc] init];
    
    ViewController6 *vc6 = [[ViewController6 alloc] init];
    
#pragma mark 标签控制器应该直接加载于window上，不应该进行任何视图包装
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.tabBar.backgroundImage = [UIImage imageNamed:@"nav_bg"];
    tabBarController.viewControllers = @[navi1, navi2, navi3, navi4, vc5, vc6];
    [navi1 release];
    [navi2 release];
    [navi3 release];
    [navi4 release];
    [vc5 release];
    [vc6 release];
    
    [tabBarController.moreNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_ios7"] forBarMetrics:UIBarMetricsDefault];
    
    self.window.rootViewController = tabBarController;
    [tabBarController release];
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
