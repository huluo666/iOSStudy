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

@interface AppDelegate () <UITabBarControllerDelegate, UIAlertViewDelegate>

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
    UINavigationController *navi1 = [[UINavigationController alloc]
                                     initWithRootViewController:vc1];
    [navi1.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_ios7"]
                              forBarMetrics:UIBarMetricsDefault];
    [vc1 release];
    
    ViewController2 *vc2 = [[ViewController2 alloc] init];
    UINavigationController *navi2 = [[UINavigationController alloc]
                                     initWithRootViewController:vc2];
    [navi2.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_ios7"]
                              forBarMetrics:UIBarMetricsDefault];
    [vc2 release];
    
    ViewController3 *vc3 = [[ViewController3 alloc] init];
    UINavigationController *navi3 = [[UINavigationController alloc]
                                     initWithRootViewController:vc3];
    [navi3.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_ios7"]
                              forBarMetrics:UIBarMetricsDefault];
    [vc3 release];
    
    ViewController4 *vc4 = [[ViewController4 alloc] init];
    UINavigationController *navi4 = [[UINavigationController alloc]
                                     initWithRootViewController:vc4];
    [navi4.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_ios7"]
                              forBarMetrics:UIBarMetricsDefault];
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
    
    [tabBarController.moreNavigationController.navigationBar
            setBackgroundImage:[UIImage imageNamed:@"nav_bg_ios7"]
            forBarMetrics:UIBarMetricsDefault];
    tabBarController.delegate = self;
    self.window.rootViewController = tabBarController;
    [tabBarController release];
}

#pragma mark - <UITabBarControllerDelegate>

- (BOOL)tabBarController:(UITabBarController *)tabBarController
shouldSelectViewController:(UIViewController *)viewController
{
    NSInteger currentSelectedIndex = tabBarController.selectedIndex;
    NSInteger willSelectedIndex = [tabBarController.viewControllers indexOfObject:viewController];
    if (1 == willSelectedIndex && 1 == currentSelectedIndex) {
        UITabBarItem *tabBarItem = tabBarController.tabBar.items[1];
        NSInteger count = [tabBarItem.badgeValue integerValue];
        
        if (10 == ++count) {
            count = 0;
        }
        
        NSString *badgeVauleString = nil;
        if (count) {
            badgeVauleString = [NSString stringWithFormat:@"%ld", count];
        }
        tabBarItem.badgeValue = badgeVauleString;
    } else if (2 == willSelectedIndex && 2 != currentSelectedIndex) { // 模拟登录
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:@"检测到未登录，是否登录？"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
        [alert show];
        [alert release];
        
        return NO;
    } else if (3 == willSelectedIndex && 3!= currentSelectedIndex) {
        ViewController1 *vc1 = [(UINavigationController *)tabBarController.viewControllers[0] viewControllers][0];
        ViewController4 *vc4 = [(UINavigationController *)tabBarController.viewControllers[3] viewControllers][0];
        vc4.value = vc1.value;
    }
    
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController
 didSelectViewController:(UIViewController *)viewController
{

}

#pragma mark - <UIAlertViewDelegate>

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView firstOtherButtonIndex] == buttonIndex) {
//        UITabBarController *tabBarController = (UITabBarController *)[[[[UIApplication sharedApplication] delegate] window] rootViewController];
        UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
        tabBarController.selectedIndex = 5;
    }
}

@end
