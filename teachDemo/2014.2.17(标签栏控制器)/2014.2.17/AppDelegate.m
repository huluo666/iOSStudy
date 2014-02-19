//
//  AppDelegate.m
//  2014.2.17
//
//  Created by 张鹏 on 14-2-17.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "ViewController4.h"
#import "ViewController5.h"
#import "ViewController6.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 为被管理的控制器添加导航控制器，导航栏
    ViewController1 *vc1 = [[ViewController1 alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    [nav1.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_ios7.png"]
                             forBarMetrics:UIBarMetricsDefault];
    
    ViewController2 *vc2 = [[ViewController2 alloc] init];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    [nav2.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_ios7.png"]
                             forBarMetrics:UIBarMetricsDefault];
    
    ViewController3 *vc3 = [[ViewController3 alloc] init];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    [nav3.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_ios7.png"]
                             forBarMetrics:UIBarMetricsDefault];
    
    ViewController4 *vc4 = [[ViewController4 alloc] init];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:vc4];
    [nav4.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_ios7.png"]
                             forBarMetrics:UIBarMetricsDefault];
    
    ViewController5 *vc5 = [[ViewController5 alloc] init];
    ViewController6 *vc6 = [[ViewController6 alloc] init];
    
    // 标签控制器视图应直接加载于window上，不应进行任何视图包装
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    // 配置委托对象
    tabBarController.delegate = self;
    // 更多标识导航控制器
    [tabBarController.moreNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_ios7.png"] forBarMetrics:UIBarMetricsDefault];
    // 配置所管理的控制器集合
    tabBarController.viewControllers = @[nav1, nav2, nav3, nav4, vc5, vc6];
    // 配置标签栏背景图片
    tabBarController.tabBar.backgroundImage = [UIImage imageNamed:@"nav_bg.png"];
    self.window.rootViewController = tabBarController;
    [tabBarController release];
    [vc1 release];
    [vc2 release];
    [vc3 release];
    [vc4 release];
    [vc5 release];
    
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

#pragma mark - <UITabBarControllerDelegate>

// 指定是否可以选择特定的控制器，默认为YES
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    // 当前选中的控制器索引
    NSInteger currentSelectedIndex = tabBarController.selectedIndex;
    // 将要选中的控制器索引
    NSInteger willSelectedIndex = [tabBarController.viewControllers indexOfObject:viewController];
    // 控制器2自加处理
    if (willSelectedIndex == 1 && currentSelectedIndex == 1) {
        // 拿出指定索引下的按钮
        UITabBarItem *tabBarItem = tabBarController.tabBar.items[1];
        // 获取bagezValue值
        NSInteger count = [tabBarItem.badgeValue integerValue];
        if (++count <= 10) {
            tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", count];
        }
        else {
            tabBarItem.badgeValue = nil;
        }
    }
    // 模拟登录
    else if (willSelectedIndex == 2 && currentSelectedIndex != 2) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:@"检测到尚未登录，是否现在登录？"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
        [alert show];
        [alert release];
        
        return NO;
    }
    else if (willSelectedIndex == 3 && currentSelectedIndex != 3) {
        ViewController1 *vc1 = [[(UINavigationController *)tabBarController.viewControllers[0] viewControllers] objectAtIndex:0];
        ViewController4 *vc4 = [[(UINavigationController *)tabBarController.viewControllers[3] viewControllers] objectAtIndex:0];
        vc4.value = vc1.value;
    }
    
    
    return YES;
}

// 特定控制器已选择完成
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    // ...
}

#pragma mark - <UIAlertViewDelegate>

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == [alertView firstOtherButtonIndex]) {
//        UITabBarController *tabBarController = (UITabBarController *)[[[[UIApplication sharedApplication] delegate] window] rootViewController];
        // 获取UITabBarController
        UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
        // 设置选中的控制器页面索引
        tabBarController.selectedIndex = 5;
    }
}

@end




















