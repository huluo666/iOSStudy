//
//  Student.m
//  「OC」比较器
//
//  Created by cuan on 14-1-18.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Student.h"

@implementation Student

- (id)initWithName:(NSString *)name age:(NSInteger)age code:(NSInteger)code
{
    if (self = [super init])
    {
        _name = [name copy];
        _age  = age;
        _code = code;
    }
    return self;
}

- (void)dealloc
{
    [_name release];
    [super dealloc];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"name = %@, age = %ld, code = %ld", _name, _age, _code];
}

@end
