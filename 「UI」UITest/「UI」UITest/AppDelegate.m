//
//  AppDelegate.m
//  「UI」UITest
//
//  Created by 萧川 on 14-2-20.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "ProductsViewController.h"
#import "CasusViewController.h"
#import "TrainViewController.h"
#import "AboutViewController.h"

@interface AppDelegate ()

- (void)loadTabBarController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    [self loadTabBarController];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)loadTabBarController
{
    HomePageViewController *homePageVC = [[HomePageViewController alloc] init];
    
    ProductsViewController *productsVC = [[ProductsViewController alloc] init];
    UINavigationController *productsNavi = [[UINavigationController alloc]
                                         initWithRootViewController:productsVC];
    [productsVC release];
    
    CasusViewController *casusVC = [[CasusViewController alloc] init];
    UINavigationController *casusNavi = [[UINavigationController alloc]
                                         initWithRootViewController:casusVC];
    [casusVC release];
    
    TrainViewController *trainVC = [[TrainViewController alloc] init];
    UINavigationController *trainNavi = [[UINavigationController alloc] initWithRootViewController:trainVC];
    [trainVC release];
    
    AboutViewController *aboutVC = [[AboutViewController alloc] init];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    NSArray *navis = @[productsNavi, casusNavi, trainNavi];
    // 改变导航控制器文本颜色
    for (UINavigationController *navi in navis) {
        navi.navigationBar.tintColor = [UIColor whiteColor];
        [navi.navigationBar setBackgroundImage:[UIImage imageNamed:@"navi"] forBarMetrics:UIBarMetricsDefault];
        navi.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                   NSFontAttributeName:[UIFont systemFontOfSize:14.0f]};
    }
    tabBarController.viewControllers = @[homePageVC, productsNavi, casusNavi, trainNavi, aboutVC];
    [homePageVC release];
    [productsNavi release];
    [casusNavi release];
    [trainNavi release];
    [aboutVC release];
    
    // 配置tabBar颜色
    tabBarController.tabBar.tintColor = [UIColor orangeColor];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor], NSFontAttributeName:[UIFont systemFontOfSize:12.0f]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor   ], NSFontAttributeName:[UIFont systemFontOfSize:12.0f]} forState:UIControlStateSelected];

    self.window.rootViewController = tabBarController;
    tabBarController.tabBar.barTintColor = [UIColor blackColor];
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
