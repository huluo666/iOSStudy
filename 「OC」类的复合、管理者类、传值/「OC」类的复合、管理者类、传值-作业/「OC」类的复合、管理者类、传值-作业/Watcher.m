//
//  Watcher.m
//  「OC」类的复合、管理者类、传值-作业
//
//  Created by cuan on 14-1-16.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Watcher.h"
#import "Student.h"
#import "Teacher.h"
#define STUDENT_INFO @"studentInfo"

@implementation Watcher

- (id)initWithStudent:(Student *)student teacher:(Teacher *)teacher
{
    if (self = [super init])
    {
        _student = [student retain];
        _teacher = [teacher retain];
    }
    
    return self;
}

- (void)dealloc
{
    [_student release];
    [_teacher release];
    [super dealloc];
}

- (NSInteger) birthdayDifference
{
    return [_student.birthday timeIntervalSinceDate:_teacher.birthday]/3600/24;
}

- (void)exchangeAge
{
    NSInteger temp = 0;
    temp           = _student.age;
    _student.age   = _teacher.age;
    _teacher.age   = temp;
}

- (NSDictionary *)packStudentInfo
{
    NSMutableDictionary *infoDict = [NSMutableDictionary dictionary];
    [infoDict setObject:_student.name ? _student.name : @"" forKey:@"name"];
    [infoDict setObject:_student.age ? @(_student.age) : @"" forKey:@"age"];
    [infoDict setObject:_student.IDNumber ? _student.IDNumber : @"" forKey:@"IDNumber"];
    [infoDict setObject:_student.birthday ? _student.birthday : @"" forKey:@"birthday"];
    [infoDict setObject:@(_student.age) forKey:@"age"];
    
    return [[infoDict copy] autorelease];
    
}

- (NSDictionary *)packStudentInfoWithStudent:(Student *)student
{
    NSMutableDictionary *infoDict = [NSMutableDictionary dictionary];
    [infoDict setObject:student.name ? student.name : @"" forKey:@"name"];
    [infoDict setObject:student.age ? @(student.age) : @"" forKey:@"age"];
    [infoDict setObject:student.IDNumber ? student.IDNumber : @"" forKey:@"IDNumber"];
    [infoDict setObject:student.birthday ? student.birthday : @"" forKey:@"birthday"];
    [infoDict setObject:@(student.age) forKey:@"age"];

    return [[infoDict copy] autorelease];
}

- (NSDictionary *)packStudentInfoWithTeacher:(Teacher *)teacher
{
    NSMutableDictionary *infoDict = [NSMutableDictionary dictionary];
    [infoDict setObject:teacher.name ? teacher.name : @"" forKey:@"name"];
    [infoDict setObject:teacher.age ? @(teacher.age) : @"" forKey:@"age"];
    [infoDict setObject:teacher.IDNumber ? teacher.IDNumber : @"" forKey:@"IDNumber"];
    [infoDict setObject:teacher.birthday ? teacher.birthday : @"" forKey:@"birthday"];
    [infoDict setObject:@(teacher.age) forKey:@"age"];
    
    return [[infoDict copy] autorelease];
}



- (BOOL)saveStudentInfoToUserDeafults
{
    NSUserDefaults *persistenceUserInfo = [NSUserDefaults standardUserDefaults];
    [persistenceUserInfo setObject:[self packStudentInfo] forKey:STUDENT_INFO];
    if ([persistenceUserInfo synchronize])
        return YES;
    return NO;
}

- (NSDictionary *)loadStudentInfoFromUserDefaults
{
    NSUserDefaults *persistenceUserInfo = [NSUserDefaults standardUserDefaults];
    return [persistenceUserInfo objectForKey:STUDENT_INFO];
}

- (NSArray *)getAgesArrayWithKey:(NSString *)key
{

    NSArray *infoArray = [[NSArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:key]];
    NSMutableArray *agesArray = [[[NSMutableArray alloc] init] autorelease];
    
    for (int i = 0; i< [infoArray count]; i++)
    {
        [agesArray addObject:[infoArray[i] objectForKey:@"age"]];
    }
    
    [infoArray release];
    return agesArray;
}

@end