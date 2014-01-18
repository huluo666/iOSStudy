//
//  Teacher.m
//  「OC」比较器
//
//  Created by cuan on 14-1-18.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Teacher.h"
#import "Student.h"

@implementation Teacher

- (id)initWithName:(NSString *)name
               age:(NSInteger)age
              code:(NSInteger)code
            number:(NSInteger)number
{
    if (self = [super init])
    {
        _name          = [name copy];
        _age           = age;
        _code          = code;
        _number        = number;
        _studentsArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [_name release];
    [_studentsArray release];
    [super dealloc];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"name = %@, age = %ld, code = %ld, number = %ld", _name, _age, _code, _number];
}

- (int)calculateStudentsAverageAge
{
    int averageAge = 0;
    for (int i = 0; i < [_studentsArray count]; i++)
    {
        averageAge += [_studentsArray[i] age];
    }
    
    return averageAge;
}

+ (Teacher *)haveYoungestStudent:(NSMutableArray *)teachersArray
{
    Teacher *result = nil;
    int min = 100;
    
    for (Teacher *teacher in teachersArray)
    {
        if ([teacher calculateStudentsAverageAge] < min)
        {
            min = [teacher calculateStudentsAverageAge];
            result = teacher;
        }
    }
    
    return result;
}

@end
