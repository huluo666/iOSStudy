//
//  Person.m
//  2014.2.24
//
//  Created by 张鹏 on 14-2-24.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "Person.h"

@implementation Person

+ (void)excuteBlock:(void (^)(void))block {
    
    block();
}

+ (NSInteger)processNumber1:(NSInteger)number1
                    number2:(NSInteger)number2
                  withBlock:(NSInteger (^)(NSInteger, NSInteger))block {
    
    if (!block) {
        return 0;
    }
    
    return block(number1, number2);
}

+ (NSArray *)filteredArray:(NSArray *)array usingBlock:(BOOL (^)(id))block {
    
    // 为空判断
    if (!array || !block) {
        return nil;
    }
    NSMutableArray *results = [NSMutableArray array];
    for (id object in array) {
        // block判断是否该被移除，YES为移除
        if (!block(object)) {
            [results addObject:object];
        }
    }
    return results;
}

@end





















