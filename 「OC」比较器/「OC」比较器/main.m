//
//  main.m
//  「OC」比较器
//
//  Created by cuan on 14-1-18.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"
#import "Teacher.h"
/*
 1.	构建一个Student类，增加name，age，code属性，并完成其description方法和dealloc方法；
 2.	在一个数组中加入3个student，并按code排序；
 3.	构建一个Teacher类，并增加一个number属性，在上述数组中加入2个Teacher实例，并对这个数组按code和number排序；
 4.	给Teacher类增加一个NSMutableArray属性，描述其所有学生，构建3个Teacher对象，分别拥有1个，2个，3个学生；
 5.	将上述3个Teacher对象放入数组中，写一个方法，返回3个Teacher对应的3组学生中，平均年龄最小的那个Teacher对象
 
 */
int main(int argc, const char * argv[])
{
    
#pragma mark 初始化对象
    
    // 2.
    Student *student1 = [[Student alloc] initWithName:@"student1" age:22 code:1];
    Student *student2 = [[Student alloc] initWithName:@"student2" age:29 code:3];
    Student *student3 = [[Student alloc] initWithName:@"student3" age:27 code:11];
    
    NSMutableArray *idArray = [NSMutableArray arrayWithObjects:student1, student2, student3, nil];
    
    // 3.
    Teacher *teacher1 = [[Teacher alloc] initWithName:@"teacher1" age:32 code:11 number:27];
    Teacher *teacher2 = [[Teacher alloc] initWithName:@"teacher2" age:40 code:11 number:22];
    
    // 4.
    Teacher *teacher3 = [[Teacher alloc] initWithName:@"teacher3" age:41 code:21 number:29];
    
    Student *student4 = [[Student alloc] initWithName:@"student4" age:28 code:111];
    Student *student5 = [[Student alloc] initWithName:@"student5" age:19 code:23];
    Student *student6 = [[Student alloc] initWithName:@"student6" age:24 code:23];
    
#pragma mark 按照code排序
    
    NSLog(@"%@", idArray);
    
    [idArray sortUsingComparator:^NSComparisonResult(id obj1, id obj2)
    {
        return [@([obj1 code]) compare:@([obj2 code])];
    }];
    
    NSLog(@"%@", idArray);
    
#pragma mark 按照code和number排序
    
    [idArray addObject:teacher1];
    [idArray addObject:teacher2];
    
    NSLog(@"%@", idArray);
    
    [idArray sortUsingComparator:^NSComparisonResult(id obj1, id obj2)
    {
        if ([obj1 code] == [obj2 code])
        {
            if ([obj1 isKindOfClass:[Teacher class]] && [obj2 isKindOfClass:[Teacher class]])
            {
                return [@([obj1 number]) compare:@([obj2 number])];
            }
            else
            {
                return NSOrderedSame;
            }
            
        }
        else
        {
            return [@([obj1 code]) compare:@([obj2 code])];
        }
    }];
    
    NSLog(@"%@", idArray);
    
    
#pragma mark 分别拥有1，，2，3个学生
    
    [teacher1.studentsArray addObject:student1];
    
    [teacher2.studentsArray addObject:student2];
    [teacher2.studentsArray addObject:student3];
    
    [teacher3.studentsArray addObject:student4];
    [teacher3.studentsArray addObject:student5];
    [teacher3.studentsArray addObject:student6];
    
#pragma mark 平均年龄最小的那个Teacher对象
    
    NSMutableArray *teachersArray = [NSMutableArray arrayWithObjects:teacher1, teacher2, teacher3, nil];
    Teacher *teacher = [Teacher haveYoungestStudent:teachersArray];
    NSLog(@"%@", teacher);
    
#pragma mark 释放空间
    
    [student1 release];
    [student2 release];
    [student3 release];
    [student4 release];
    [student5 release];
    [student6 release];
    [teacher1 release];
    [teacher2 release];
    [teacher3 release];
    
    return 0;
}

