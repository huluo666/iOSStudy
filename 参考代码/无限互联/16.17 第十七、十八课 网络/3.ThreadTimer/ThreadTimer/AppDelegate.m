//
//  AppDelegate.m
//  ThreadTimer
//
//  Created by wei.chen on 13-1-10.
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
    
    [self performSelectorInBackground:@selector(multiThread) withObject:nil];
    
    return YES;
}

- (void)multiThread {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    //此种方式创建的timer已经添加至runLoop
//    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
    //此种方式创建的timer没有添加至runLoop
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
    //将定时器添加到RunLoop中
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    [pool release];
    
    [[NSRunLoop currentRunLoop] run];
    
    NSLog(@"线程结束");
}

- (void)timerAction {
    NSLog(@"timerAction");
}

@end
