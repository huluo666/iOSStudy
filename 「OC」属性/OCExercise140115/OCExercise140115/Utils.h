//
//  Utils.h
//  OCExercise140115
//
//  Created by cuan on 14-1-15.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

/*!
 *    通过身份证号码获取生日信息
 *
 *    @param aIDString 身份证号码字符串
 *
 *    @return 生日
 */
+ (NSDate *) getBirthDateWithIDString:(NSString *)aIDString;

@end
