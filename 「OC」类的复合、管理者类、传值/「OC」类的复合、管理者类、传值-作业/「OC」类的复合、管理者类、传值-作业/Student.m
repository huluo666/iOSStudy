//
//  Student.m
//  「OC」类的复合、管理者类、传值-作业
//
//  Created by cuan on 14-1-16.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Student.h"

@implementation Student

- (id)initWithName:(NSString *)name
                age:(NSInteger)age
           IDNumber:(NSString *)IDNumber
           birthday:(NSDate *)birthday
{
    if (self = [super init])
    {
        _name     = [name copy];
        _age      = age;
        _IDNumber = [IDNumber copy];
        _birthday = [birthday retain];
        _teacher  = nil;
    }
    
    return self;
}

- (void)dealloc
{
    [_name release];
    [_IDNumber release];
    [_birthday release];
    [_teacher release];
    [super dealloc];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"name = %@, age = %ld, IDNumber = %@ , birthday = %@",
            _name, _age, _IDNumber, _birthday];
}

@end
