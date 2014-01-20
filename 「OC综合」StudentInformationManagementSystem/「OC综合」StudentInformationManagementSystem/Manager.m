//
//  Manager.m
//  「OC综合」StudentInformationManagementSystem
//
//  Created by cuan on 14-1-20.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Manager.h"
#import "Student.h"

@implementation Manager

- (void)dealloc
{
    [_students release];
    [_studentsForSameAge release];
    [super dealloc];
}

- (id)initWithStudents:(NSMutableArray *)students
{
    self = [super init];
    if (self)
    {
        _students = [students retain];
        _studentsForSameAge = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)searchPresentOfStudent:(NSString *)studentName atDay:(NSInteger)aDay
{
    aDay -= 1;
    for (Student *student in _students)
    {
        if ([[student name] isEqualToString:studentName])
        {
            BOOL result = [[[student presents] objectAtIndex:aDay] boolValue];
            NSLog(@"%@", result == 0 ? @"NO" : @"YES");
        }
    }
}

- (void)countObsoleteStudent
{
    for ( Student *student in _students)
    {
        int noPresentCount = 0;
        
        for (NSNumber *item in [student presents])
        {
            if ([item isEqual:@NO])
            {
                noPresentCount++;
            }
        }
        
        if (noPresentCount > [[student presents] count] * 0.25)
        {
            student.isPass = NO;
            NSLog(@"%@", student);
        }
    }
}

- (void)insertANewStudent:(Student *)newStudent
{
    BOOL isInserted = NO;
    
    for (int i = 0; i < [_students count]; i++)
    {
        if (newStudent.studentNumber <= [_students[i] studentNumber])
        {
            [_students retain];
            [_students insertObject:newStudent atIndex:i];
            isInserted = YES;
            [_students release];
            break;
        }
    }
    
    if (!isInserted)
    {
        [_students retain];
        [_students addObject:newStudent];
        [_students release];
    }
    
    NSLog(@"%@", _students);
}

- (NSMutableArray *)studentsHaveSameAgeWithSingletonStudent:(Student *)singletonStudent
{
    for (Student *student in _students)
    {
        if (student.age == singletonStudent.age)
        {
            [_studentsForSameAge addObject:student];
        }
    }
    
    return _studentsForSameAge;
}

@end
