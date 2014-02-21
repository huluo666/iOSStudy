//
//  AppDelegate.m
//  2014.2.21
//
//  Created by 张鹏 on 14-2-21.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "ViewController4.h"
#import "ViewController5.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    ViewController1 *vc1 = [[ViewController1 alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    [vc1 release];
    
    ViewController2 *vc2 = [[ViewController2 alloc] init];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    [vc2 release];
    
    ViewController3 *vc3 = [[ViewController3 alloc] init];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    [vc3 release];
    
    ViewController4 *vc4 = [[ViewController4 alloc] init];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:vc4];
    [vc4 release];
    
    ViewController5 *vc5 = [[ViewController5 alloc] init];
    UINavigationController *nav5 = [[UINavigationController alloc] initWithRootViewController:vc5];
    [vc5 release];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[nav1, nav2, nav3, nav4, nav5];
    
    for (int i = 0; i < 5; i++) {
        UITabBarItem *item = tabBarController.tabBar.items[i];
        item.title = [NSString stringWithFormat:@"%d", i + 1];
    }
    
    self.window.rootViewController = tabBarController;
    [nav1 release];
    [nav2 release];
    [nav3 release];
    [nav4 release];
    [nav5 release];
    
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
