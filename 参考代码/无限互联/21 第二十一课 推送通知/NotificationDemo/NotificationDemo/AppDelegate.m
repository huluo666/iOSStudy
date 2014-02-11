//
//  AppDelegate.m
//  NotificationDemo
//
//  Created by 周泉 on 13-2-28.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G开发培训中心. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // 这是一个测试label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 320, 50)];
    label.backgroundColor = [UIColor redColor];
    label.tag = 101;
    label.textColor = [UIColor whiteColor];
    [self.window addSubview:label];
    [label release];
 
    // 当我们的程序未运行时
    NSDictionary *remoteDic = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (remoteDic) {
        label.backgroundColor = [UIColor purpleColor];
        label.text = [[remoteDic objectForKey:@"aps"] objectForKey:@"alert"];
    }
    
    // 注册通知（声音、标记、弹出窗口）
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
    
    return YES;
} // 当我们的程序没有被启动时，provider（服务器）发送了一条感兴趣的消息，通过launchOptions字典来获取内容

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"deviceToken : %@", deviceToken);
} // APNS -> token（令牌）

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"error : %@", [error localizedDescription]);
} // error

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
//    NSLog(@"userInfo : %@", [[userInfo objectForKey:@"aps"] objectForKey:@"alert"]);
    
    UILabel *label = (UILabel *)[self.window viewWithTag:101];
    label.text = [[userInfo objectForKey:@"aps"] objectForKey:@"other"];
    
} // 接受到感兴趣的内容(挂起时调用代理方法)

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
    [application setApplicationIconBadgeNumber:0];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
