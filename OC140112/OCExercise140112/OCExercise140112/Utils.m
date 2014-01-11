//
//  Utils.m
//  OCExercise140112
//
//  Created by cuan on 14-1-11.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Utils.h"

@implementation Utils

// 2.	写一个方法，计算任意一个身份证号对应的出生年月；
+ (NSString *) getBirthByIDString:(NSString *)aIDString
{
    if (!aIDString || [aIDString length] == 0)
    {
        return nil;
    }
    
    NSString *year = [aIDString substringWithRange:NSMakeRange(6, 4)];
    NSString *month = [aIDString substringWithRange:NSMakeRange(10, 2)];
    NSString *day   = [aIDString substringWithRange:NSMakeRange(12, 2)];
    
    return [NSString stringWithFormat:@"%@年%@月%@日", year, month, day];
}

// 3.	写一个方法，将输入的NSString类型的字符串数值变为相反数字符串后返回，如传入@“1”，返回@“-1
+ (NSString *) getStringOppositeNumber:(NSString *)aStringNumber
{
    // 加一个健壮性判断
    if (!aStringNumber || [aStringNumber length] == 0)
    {
        return nil;
    }
    
    NSInteger number = [aStringNumber integerValue];
    return [NSString stringWithFormat:@"%ld", -(long)number];
}

// 4.	写一个方法输入的字符是否包含数字0，不包含输出@“false”，包含输出其所在位置（多个输出第一个）
+ (void) printStringIsContainsNumberZero:(NSString *)aStringNumber
{
    if (!aStringNumber || [aStringNumber length] == 0)
    {
        return;
    }
    
    NSRange rang = [aStringNumber rangeOfString:@"0"];
    if (rang.location == NSNotFound)
    {
        NSLog(@"false");
    }
    else
    {
        NSLog(@"索引为：%ld", rang.location);
    }
}

// 5.	使用NSDate计算，1970年以后的任意两天之间相隔多少天。
+ (NSInteger) daysIntervalSinceDay:(NSString *) aDay fromDay:(NSString *) otherDay
{
    if (!aDay || !otherDay)
    {
        return 0;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyyMMdd"];
    NSDate *aDayDate= [dateFormatter dateFromString:aDay];
    NSDate *otherDayDate= [dateFormatter dateFromString:otherDay];
    
    return abs([aDayDate timeIntervalSinceDate:otherDayDate]/3600/24);
}

@end
