//
//  NSArray+NSStringFilter.m
//  2014.2.24
//
//  Created by 张鹏 on 14-2-24.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "NSArray+NSStringFilter.h"

@implementation NSArray (NSStringFilter)

- (NSArray *)filteredArrayUsingBlock:(BOOL (^)(id))block {
    
    if (!block) {
        return self;
    }
    NSMutableArray *results = [NSMutableArray array];
    for (id object in self) {
        // block判断是否该被移除，YES为移除
        if (!block(object)) {
            [results addObject:object];
        }
    }
    return results;
}

@end


















