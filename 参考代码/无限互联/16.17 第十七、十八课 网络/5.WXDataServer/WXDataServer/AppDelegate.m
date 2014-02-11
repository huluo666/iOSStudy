//
//  AppDelegate.m
//  WXDataServer
//
//  Created by wei.chen on 13-1-10.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "AppDelegate.h"
#import "WXDataService.h"

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
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.frame = CGRectMake(10, 50, 20, 20);
    [button addTarget:self action:@selector(load) forControlEvents:UIControlEventTouchUpInside];
    [self.window addSubview:button];
    
    return YES;
}

- (void)load {
    NSDictionary *params = @{@"code":@"101010300"};
    [WXDataService getWetheaData:params block:^(id result){
        NSLog(@"%@",result);
//        [self refreshUI:result];
    }];
}

@end
