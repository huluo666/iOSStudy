//
//  Broadcast.m
//  「OC」通知中心
//
//  Created by cuan on 14-1-27.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Broadcast.h"

@implementation Broadcast

- (void)broadcast
{
    // 取得通知中心
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    // 发送广播
    static int i = 0;
    NSString *count = [NSString stringWithFormat:@"broadcast %d", i++];
//    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"broadcast", @"name", count, @"value", nil];
//    [notificationCenter postNotificationName:@"Broadcast" object:self userInfo:dict];
    [notificationCenter postNotificationName:@"Broadcast" object:self userInfo:@{@"name":@"broadcast", count:@"value"}];
}

- (void)broadcastLooper
{
    // 启动一个定时器循环发广播
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(broadcast) userInfo:nil repeats:YES];
}

@end
