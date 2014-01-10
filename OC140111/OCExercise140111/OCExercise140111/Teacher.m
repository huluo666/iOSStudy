//
//  Teacher.m
//  OCExercise140111
//
//  Created by cuan on 14-1-10.
//  Copyright (c) 2014年 cuan. All rights reserved.
//
#import <stdlib.h>
#import "Teacher.h"

@implementation Teacher

- (id)init
{
    self = [super init];
    if (self)
    {
        _student = nil;
    }
    return self;
}

- (id) initWithName:(NSString *)name age:(NSInteger)age height:(NSInteger)height student:(Student *)student
{
    self = [self initWithName:name age:age height:height];
    if (self)
    {
        _student = student;
    }
    
    return self;
}

- (NSInteger) ageDifferenceWith:(Student *)student
{
    return _age - [student age];
}

@end
