//
//  NSData+DateCate.m
//  「OC」类别、类扩展、协议、设计模式(委托、通知、单例)-作业
//
//  Created by cuan on 14-1-17.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "NSDate+DateCate.h"

@implementation NSDate (DateCate)

- (NSString *)nowTimeString
{
//    NSDate *nowDate = [NSDate date];
//    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    return [NSDateFormatter localizedStringFromDate:self dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *)hours
{
    return [[self nowTimeString] substringWithRange:NSMakeRange(2, 1)];
}

- (NSString *)minutes
{
    return [[self nowTimeString] substringWithRange:NSMakeRange(4, 2)];
}

@end
