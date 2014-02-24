//
//  CustomOperation.m
//  2014.2.24多线程
//
//  Created by 张鹏 on 14-2-24.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "CustomOperation.h"

@implementation CustomOperation

- (void)main {
    
    NSDate *beginDate = [NSDate date];
    // 当前线程休眠10秒
    [NSThread sleepForTimeInterval:10];
    NSDate *endDate = [NSDate date];
    NSLog(@"Complete processing with '%.2f' seconds.", [endDate timeIntervalSinceDate:beginDate]);
}

@end


















