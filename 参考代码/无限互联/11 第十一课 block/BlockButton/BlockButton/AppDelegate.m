//
//  AppDelegate.m
//  BlockButton
//
//  Created by wei.chen on 13-1-4.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "AppDelegate.h"
#import "BlockButton.h"

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
    
    BlockButton *button = [[BlockButton alloc] initWithFrame:CGRectMake(20, 40, 100, 20)];
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:@"按钮" forState:UIControlStateNormal];
    button.block = ^(BlockButton *btn){
        NSLog(@"按钮被点击了");
    };
    [self.window addSubview:button];
    [button release];
    
    return YES;
}

@end
