//
//  Tools.m
//  OC140111
//
//  Created by cuan on 14-1-10.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Tools.h"

@implementation Tools
+ (NSString *) NSInteger2NSString:(NSInteger)number
{
    return [NSString stringWithFormat:@"%ld", (long)number];
}

+ (NSInteger) NSString2NSInteger:(NSString *)string
{
    return [string integerValue];
}
@end
