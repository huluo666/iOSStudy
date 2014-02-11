//
//  AppDelegate.m
//  TouchDemo
//
//  Created by wei.chen on 13-2-28.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "AppDelegate.h"
#import "TouchView.h"

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
    
    TouchView *touchView = [[TouchView alloc] initWithFrame:CGRectMake(0, 20, 320, 300)];
    touchView.backgroundColor = [UIColor grayColor];
    [self.window addSubview:touchView];
    
    return YES;
}
@end
