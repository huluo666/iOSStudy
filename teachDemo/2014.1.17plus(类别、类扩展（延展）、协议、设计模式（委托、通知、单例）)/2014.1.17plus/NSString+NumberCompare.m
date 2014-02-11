//
//  NSString+NumberCompare.m
//  2014.1.17plus
//
//  Created by 张鹏 on 14-1-17.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "NSString+NumberCompare.h"

@implementation NSString (NumberCompare)

- (NSComparisonResult)numericCompare:(NSString *)string {
    
    // @"99"   @"100"
    return [self compare:string options:NSNumericSearch];
}

@end

















