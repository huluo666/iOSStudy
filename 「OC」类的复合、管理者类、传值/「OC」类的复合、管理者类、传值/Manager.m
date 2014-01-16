//
//  Manager.m
//  「OC」类的复合、管理者类、传值
//
//  Created by cuan on 14-1-16.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Manager.h"
#import "Student.h"
#import "Teacher.h"

@implementation Manager

- (void)changeStudentName
{
    _student.name =  [_teacher.name uppercaseString];
}

- (void)assignStudentAgeToTeacherByUserDefaults
{
    
    [_userDefaults setInteger:_student.age forKey:@"studentAge"];
    [_userDefaults synchronize];
    _teacher.age = [[_userDefaults objectForKey:@"studentAge"] integerValue];
}

+ (NSInteger)calculateAgeDifferenceBetweenStudent:(Student *)student teacher:(Teacher *)teacher
{
    NSInteger ret = student.age - teacher.age;
    return  ret > 0 ? ret:-ret;
}

- (void)assignStudentAgeToTeacher
{
    _teacher.age = _student.age;
}

- (void)dealloc
{
    [_student release];
    [_teacher release];
    [super dealloc];
}



@end