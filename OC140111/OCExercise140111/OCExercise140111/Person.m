//
//  Person.m
//  OCExercise140111
//
//  Created by cuan on 14-1-10.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Person.h"

@implementation Person

- (id)init
{
    self = [super init];
    if (self)
    {
        _name   = nil;
        _age    = 0;
        _height = 0;
    }
    return self;
}

- (id) initWithName:(NSString *)name age:(NSInteger) age height:(NSInteger) height
{
    self = [super init];
    if (self)
    {
        _name   = name;
        _age    = age;
        _height = height;
    }
    return self;
}

- (NSString *)name
{
    return _name;
}

- (NSInteger)age
{
    return _age;
}

- (NSInteger)height
{
    return _height;
}
@end
