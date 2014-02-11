//
//  AppDelegate.m
//  ASIHttpDemo
//
//  Created by wei.chen on 13-1-11.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "AppDelegate.h"
#import "WebImageView.h"
#import "ASIHTTPRequest.h"

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
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self action:@selector(loadImage) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"test" forState:UIControlStateNormal];
    button.frame = CGRectMake(200, 100, 100, 50);
    [self.window addSubview:button];
    
//    self.queue = [ASINetworkQueue queue];
//    //设置请求的并发数
//    self.queue.maxConcurrentOperationCount = 1;
    
    
    [ASIHTTPRequest sharedQueue].maxConcurrentOperationCount = 1;
    
    return YES;
}

- (void)loadImage {
    for (int i=0; i<10; i++) {
        WebImageView *imageView = [[WebImageView alloc] initWithFrame:CGRectMake(10, i*50, 100, 50)];
        [imageView setImageURL:[NSURL URLWithString:@"http://pica.nipic.com/2007-12-12/20071212235955316_2.jpg"]];
        [self.window addSubview:imageView];
    }
    
    //执行队列中的请求
//    [self.queue go];
}

@end
