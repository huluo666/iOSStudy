//
//  Teacher.m
//  OC140109
//
//  Created by cuan on 14-1-9.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Teacher.h"

@implementation Teacher
- (id) initWithName:(NSString *) name age:(NSString *)age
{
    self = [super init];
    if (self)
    {
        _name = name;
        _age  = age;
    }
    return self;
}


@end
