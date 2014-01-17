//
//  NSDate+DateComponents.m
//  八、类别、类扩展、协议、单例、封装、继承
//
//  Created by 张鹏 on 13-11-6.
//  Copyright (c) 2013年 张鹏. All rights reserved.
//

#import "NSDate+DateComponents.h"

@implementation NSDate (DateComponents)

- (NSString *)hour {
    
    /*
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH"];
    NSString *hour = [formatter stringFromDate:self];
    [formatter release];
     */
    
//    /*
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger hourComponent = [calendar component:NSCalendarUnitHour fromDate:self];
    NSString *hour = [NSString stringWithFormat:@"%ld", hourComponent];
//     */
    
    return hour;
}

- (NSString *)minute {
    
//    /*
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"mm"];
    NSString *minute = [formatter stringFromDate:self];
    [formatter release];
//     */
    
    /*
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger minuteComponent = [calendar component:NSCalendarUnitMinute fromDate:self];
    NSString *minute = [NSString stringWithFormat:@"%ld", minuteComponent];
    */
    
    return minute;
}

@end





