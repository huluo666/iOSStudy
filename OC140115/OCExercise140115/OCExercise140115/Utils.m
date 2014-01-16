//
//  Utils.m
//  OCExercise140115
//
//  Created by cuan on 14-1-15.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (NSDate *) getBirthDateWithIDString:(NSString *)aIDString
{
    if (!aIDString || [aIDString length] == 0)
    {
        NSLog(@"kkkk");
        return nil;
    }
    
    NSString *birthString = [aIDString substringWithRange:NSMakeRange(6, 8)];
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat: @"yyyyMMdd"];
    
    return [dateFormatter dateFromString:birthString];
}

@end
