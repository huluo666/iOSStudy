//
//  Student.m
//  OC140115
//
//  Created by cuan on 14-1-15.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Student.h"

@implementation Student

- (id) initWithName:(NSString *)name age:(NSInteger)age code:(NSString *)code
{
    self = [super init];
    if (self)
    {
        _name = [name copy];
        _code = [code copy];
        _age  = age;
    }
    return self;
}

- (void)dealloc
{
    [_name release];
    [_code release];
    [super dealloc];
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"name = %@, age = %ld, code = %@", _name, _age, _code];
}

- (NSInteger)AgeDiffBetweenWithStudent:(Student *)student
{
    NSInteger ret = self.age - student.age;
    if (ret < 0)
    {
        return -ret;
    }
    return ret;
}

- (void)upperCaseStudentName
{
    _name = [[_name uppercaseString] copy];
}

- (void)assignNameWithAStudent:(Student *)aStudent
{
    _name = [aStudent.name copy];
}
@end
