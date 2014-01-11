//
//  Utils.h
//  OCExercise140112
//
//  Created by cuan on 14-1-11.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject
+ (NSString *) getBirthByIDString:(NSString *)aIDString;
+ (NSString *) getStringOppositeNumber:(NSString *)aStringNumber;
+ (void) printStringIsContainsNumberZero:(NSString *)aStringNumber;
+ (NSInteger) daysIntervalSinceDay:(NSString *) aDay fromDay:(NSString *) otherDay;
@end
