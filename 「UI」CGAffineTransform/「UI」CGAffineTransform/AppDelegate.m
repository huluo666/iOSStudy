//
//  AppDelegate.m
//  「UI」CGAffineTransform
//
//  Created by cuan on 14-1-31.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    /*
    UIView *view = [[UIView alloc] init];
    view.center = CGPointMake(CGRectGetMidX(self.window.frame), CGRectGetMidY(self.window.frame));
    view.bounds = CGRectMake(0, 0, 200, 180);
    view.tag = 100;
    view.backgroundColor = [UIColor redColor];
    [self.window addSubview: view];
    [view release];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setBounds:CGRectMake(0, 0, 100, 40)];
    [button setCenter:CGPointMake(CGRectGetMidX(self.window.frame), CGRectGetMaxY(view.frame) + 40)];
    [button setTitle:@"点击显示动画" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(viewTranslate) forControlEvents:UIControlEventTouchUpInside];
    [self.window addSubview:button];
    
    */
    
//    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [button1 setCenter:CGPointMake(CGRectGetMidX(self.window.frame), CGRectGetMinY(self.window.frame) + 60)];
//    [button1 setBounds:CGRectMake(0, 0, 330, 40)];
//    button1.layer.borderWidth = 1.0f;
//    button1.layer.borderColor = [UIColor grayColor].CGColor;
//    [self.window addSubview:button1];
//
//    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [button2 setCenter:CGPointMake(CGRectGetMidX(self.window.frame), CGRectGetMaxY(button1.frame) + 20)];
//    [button2 setBounds:CGRectMake(0, 0, 330, 40)];
//    button2.layer.borderWidth = 1.0f;
//    button2.layer.borderColor = [UIColor grayColor].CGColor;
//    [self.window addSubview:button2];
//    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)viewScale
{
    UIView *view = [self.window viewWithTag:100];
    view.transform = CGAffineTransformScale(view.transform, 0.8, 0.8);
}

- (void)viewRotate
{
    UIView *view = [self.window viewWithTag:100];
    view.transform = CGAffineTransformRotate(view.transform, 0.2);
}

- (void)viewTranslate
{
    UIView *view = [self.window viewWithTag:100];
    view.transform = CGAffineTransformTranslate(view.transform, 50, 50);
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
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
