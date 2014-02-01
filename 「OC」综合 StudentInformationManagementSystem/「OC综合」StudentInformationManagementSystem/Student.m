//
//  Student.m
//  「OC综合」StudentInformationManagementSystem
//
//  Created by cuan on 14-1-20.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Student.h"

static Student *studentSingleton = nil;

@implementation Student

- (void)dealloc
{
    [_name release];
    [_presents release];
    [super dealloc];
}

- (id)initWithName:(NSString *)name
               age:(NSInteger)age
     studentNumber:(NSInteger)studentNumber
          presents:(NSArray *)presents
{
    if (self = [super init])
    {
        _name          = [name copy];
        _age           = age;
        _studentNumber = studentNumber;
        _presents      = presents;
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"name = %@, age = %ld, studentNumber = %ld", _name,  _age, _studentNumber];
}

+ (instancetype)sharedStudent
{
    if (!studentSingleton)
    {
        studentSingleton = [[self alloc] initWithName:@"newStudent" age:21 studentNumber:111 presents:nil];
    }
    
    return studentSingleton;
}

@end
