//
//  AppDelegate.m
//  backgroudTask
//
//  Created by wei.chen on 13-1-9.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
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
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
        
    return YES;
}

- (void)timerAction:(NSTimer *)timer {
    count++;
    
    if (count % 500 == 0) {
        UIApplication *application = [UIApplication sharedApplication];
        //结束旧的后台任务
        [application endBackgroundTask:taskId];
        
        //开启一个新的后台
        taskId = [application beginBackgroundTaskWithExpirationHandler:NULL];
    }
    
    NSLog(@"%d",count);
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    //开启一个后台任务
    taskId = [application beginBackgroundTaskWithExpirationHandler:^{
        
        //结束指定的任务
        [application endBackgroundTask:taskId];
    }];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];    
}

@end
