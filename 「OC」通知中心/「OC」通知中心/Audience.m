//
//  Audience.m
//  「OC」通知中心
//
//  Created by cuan on 14-1-27.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Audience.h"

@implementation Audience

- (void)listening
{
    // 注册通知中心
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recesiveBroad:) name:@"Broadcast" object:nil];
    // param1, param2 只要有Broadcast就调用[self recesiveBroad:]
}

// 接收广播
- (void)recesiveBroad:(NSNotification *)notify
{
    NSLog(@"notify is %@", notify);
}



@end
