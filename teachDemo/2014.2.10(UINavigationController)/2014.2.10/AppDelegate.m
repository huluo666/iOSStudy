//
//  AppDelegate.m
//  2014.2.10
//
//  Created by 张鹏 on 14-2-10.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    ViewController *vc = [[ViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    // 配置导航栏
    // 设置背景色
    nav.navigationBar.barTintColor = [UIColor redColor];
    // 设置风格色
    nav.navigationBar.tintColor = [UIColor whiteColor];
    // 设置背景图片
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_ios7.png"]
                            forBarMetrics:UIBarMetricsDefault];
    // 设置title风格
    // NSForegroundColorAttributeName:配置文本色
    // NSFontAttributeName:配置文本字体类型
    // NSShadowAttributeName:配置文本阴影
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor blackColor];
    shadow.shadowOffset = CGSizeMake(5, 5);
    [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                NSFontAttributeName: [UIFont systemFontOfSize:20],
                                                NSShadowAttributeName: shadow}];
    [shadow release];
    
    // 配置工具栏，默认情况下，导航控制器显示导航栏，隐藏工具栏
    nav.toolbarHidden = NO;
    // 设置背景色
    nav.toolbar.barTintColor = [UIColor redColor];
    // 设置风格色
    nav.toolbar.tintColor = [UIColor whiteColor];
    // 设置背景图片
    [nav.toolbar setBackgroundImage:[UIImage imageNamed:@"nav_bg.png"]
                 forToolbarPosition:UIBarPositionBottom
                         barMetrics:UIBarMetricsDefault];
    
    [vc release];
    self.window.rootViewController = nav;
    [nav release];
    
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
