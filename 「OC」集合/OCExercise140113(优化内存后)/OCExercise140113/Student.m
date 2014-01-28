//
//  Person.m
//  OCExercise140113
//
//  Created by cuan on 14-1-13.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Student.h"

@implementation Student

/*!
 *    便利初始化一个Student对象
 *
 *    @param name     学生姓名
 *    @param sex      学生性别
 *    @param IDNumber 学生身份证号
 *    @param age      学生年龄
 *
 *    @return 学生对象
 */
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

/*!
 *    学生类析构
 */
-(void)dealloc
{
    [_name release];
    [_sex release];
    [_IDNumber release];
    [_mDic release];
    [super dealloc];
}

/*!
 *    计算两个学生年龄差值
 *
 *    @param student 比较的学生
 *
 *    @return 年龄差值
 */
- (NSInteger) countAgeDiffToStudent:(Student *)student
{
    NSInteger ret = self.age - student.age;
    return ret>0 ? ret:-ret;
}

- (void) addTitle
{
    [self.mDic setObject:@"excellent" forKey:@"title"];
}


+ (void) findStudentByIDNumber:(NSString *)IDNumber fromStudentArray:(NSArray *)studentArray
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

    NSMutableArray *execllentStudentArray = [[NSMutableArray alloc] init]; // 分配的是execllentStudentArray指针的空间
    for (int i=0; i<[studentArray count]; i++)
    {
        if ([[[studentArray[i] mDic] objectForKey:@"title"] isEqualToString:@"excellent"])
        {
            [execllentStudentArray addObject:studentArray[i]];
        }
    }
    
    Student *retStudent = nil;
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
