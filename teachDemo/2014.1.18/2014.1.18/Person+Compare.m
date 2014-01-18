//
//  Person+Compare.m
//  2014.1.18
//
//  Created by 张鹏 on 14-1-18.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "Person+Compare.h"

@implementation Person (Compare)

- (NSComparisonResult)compareAgeAndCode:(Person *)person {
    
    if ([_age isEqualToString:person.age]) {
        return [_code compare:person.code options:NSNumericSearch];
    }
    else {
        return [_age compare:person.age options:NSNumericSearch];
    }
}

@end














