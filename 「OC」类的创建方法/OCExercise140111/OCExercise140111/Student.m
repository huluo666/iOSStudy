//
//  Student.m
//  OCExercise140111
//
//  Created by cuan on 14-1-10.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Student.h"
#import "Teacher.h"

@implementation Student

- (NSString *) name
{
    return _name;
}

- (NSInteger) age
{
    return _age;
}

- (NSInteger) height
{
    return _height;
}

+ (Student *)compareHeightWithStudent1:(Student *)student1 Student2:(Student *)student2
{
    return student1.height > student1.height ? student1 : student2;
}
- (Student *)compareHeightWithStudent:(Student *)student
{
    return _height > student.height ? self:student;
}
@end
