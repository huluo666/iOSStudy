//
//  Person.m
//  OCExercise140113
//
//  Created by cuan on 14-1-13.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Student.h"

@implementation Student

- (id) initWithName:(NSString *)name
                sex:(NSString *)sex
           IDNumber:(NSString *)IDNumber
                age:(NSInteger)age
{
    if (self = [super init])
    {
        self.name     = name;
        self.sex      = sex;
        self.IDNumber = IDNumber;
        self.age      = age;
    }
    
    self.mDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 self.name, @"name",
                                 self.sex, @"sex",
                                 self.IDNumber, @"IDNumber",
                                 [NSString stringWithFormat:@"%ld", self.age ], @"age", nil];

    return self;
}

- (NSInteger) countAgeDiffToStudent:(Student *)student
{
    NSInteger ret = self.age - student.age;
    return ret>0 ? ret:-ret;
}

- (void) addTitle
{
    [self.mDic setObject:@"excellent" forKey:@"title"];
}


+ (void) findStudentBwIDNumber:(NSString *)IDNumber fromStudentArray:(NSArray *)studentArray
{
    int i=0;
    for (; i<studentArray.count; i++)
    {
        if ([[studentArray[i] IDNumber] isEqualToString:IDNumber])
        {
            NSLog(@"name = %@, sex = %@, IDNumber = %@, age = %ld",
                  [studentArray[i] name],
                  [studentArray[i] sex],
                  [studentArray[i] IDNumber],
                  [studentArray[i] age]);
            break;
        }
    }
    if (i == studentArray.count)
    {
        NSLog(@"Sorry, your target is not found");
    }
}

+ (Student *) findTheYoungestExcellentStudent:(NSArray *)studentArray
{
    NSMutableArray *execllentStudentArray = [[NSMutableArray alloc] init];
    for (int i=0; i<[studentArray count]; i++)
    {
        if ([[[studentArray[i] mDic] objectForKey:@"title"] isEqualToString:@"excellent"])
        {
            [execllentStudentArray addObject:studentArray[i]];
        }
    }
    
    Student *retStudent = [[Student alloc] init];
    NSInteger minAge = [execllentStudentArray[0] age];
    for (int i=1; i<[execllentStudentArray count]; i++)
    {
        if ([execllentStudentArray[i] age] < minAge)
        {
            retStudent = execllentStudentArray[i];
        }
    }
    
    [execllentStudentArray release];
    return retStudent;
}

@end
