//
//  AppDelegate.m
//  LoadImage
//
//  Created by wei.chen on 13-1-10.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "AppDelegate.h"
#import "UIImageView+WebCach.h"
#import "WebImageView.h"

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
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self action:@selector(loadImage) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"test" forState:UIControlStateNormal];
    button.frame = CGRectMake(200, 100, 100, 50);
    [self.window addSubview:button];
    
    
    return YES;
}

- (void)loadImage {
    for (int i=0; i<10; i++) {
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, i*50, 100, 50)];
//        [imageView setImageWithURL:[NSURL URLWithString:@"http://pica.nipic.com/2007-12-12/20071212235955316_2.jpg"]];
//        [self.window addSubview:imageView];
        
        WebImageView *imageView = [[WebImageView alloc] initWithFrame:CGRectMake(10, i*50, 100, 50)];
        [imageView setURL:[NSURL URLWithString:@"http://pica.nipic.com/2007-12-12/20071212235955316_2.jpg"]];
        [self.window addSubview:imageView];
    }

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
