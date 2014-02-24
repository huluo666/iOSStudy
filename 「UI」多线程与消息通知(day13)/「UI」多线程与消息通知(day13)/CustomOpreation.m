//
//  CustomOpreation.m
//  「UI」多线程与消息通知(day13)
//
//  Created by 萧川 on 14-2-24.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "CustomOpreation.h"

@implementation CustomOpreation

- (void)main {
    
    NSDate *beginDate = [NSDate date];
    // 当前线程休眠10秒
    [NSThread sleepForTimeInterval:3];
    NSDate *endDate = [NSDate date];
    NSLog(@"Complete processing with '%.2f' seconds.", [endDate timeIntervalSinceDate:beginDate]);
}

@end
