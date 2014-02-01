//
//  main.m
//  「OC综合」StudentInformationManagementSystem
//
//  Created by cuan on 14-1-20.
//  Copyright (c) 2014年 cuan. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Student.h"
#import "Manager.h"
/*
 一、制作实习生班学员信息管理系统：
 1、将所有学员按学号排序并输出；
 2、根据姓氏查询某个学员，并查看当天是否正常到课（自设）；
 3、统计学员4天的到课率，低于75%将被淘汰（设为BOOL）；
 4、插入一个新学员，并根据学号添加到指定位置，并输出所有学员信息；
 5、将新学员设置为单例，并将所有与之同龄的同学放入一个数组并输出。
 
 */
int main(int argc, const char * argv[])
{

#pragma mark 初始化数据
    Student *student1 = [[Student alloc] initWithName:@"sutdent1" age:21 studentNumber:3 presents:@[@YES,@YES,@YES,@YES]];
    Student *student2 = [[Student alloc] initWithName:@"sutdent2" age:22 studentNumber:23 presents:@[@YES,@YES,@YES,@YES]];
    Student *student3 = [[Student alloc] initWithName:@"sutdent3" age:25 studentNumber:17 presents:@[@NO,@NO,@YES,@YES]];
    Student *student4 = [[Student alloc] initWithName:@"sutdent4" age:17 studentNumber:4 presents:@[@YES,@NO,@YES,@YES]];
    
//    NSArray *students = @[student1, student2, student3, student4];
    NSMutableArray *students = [NSMutableArray arrayWithObjects:student1, student2, student3, student4, nil];
    
    Manager *manager = [[Manager alloc] initWithStudents:students];
    
#pragma mark 使用block排序,将所有学员按学号排序并输出；
    [students sortUsingComparator:^NSComparisonResult(id obj1, id obj2)
    {
        if (![obj1 isKindOfClass:[Student class]] || ![obj2 isKindOfClass:[Student class]])
        {
            NSLog(@"请使用学生对象做比较！");
            exit(0);
        }
        
        return [@([obj1 studentNumber]) compare:@([obj2 studentNumber])];
    }];
    
    NSLog(@"%@", students);
  
#pragma mark 根据姓氏查询某个学员，并查看当天是否正常到课
    [manager searchPresentOfStudent:@"sutdent4" atDay:2];
    
#pragma mark 统计学员4天的到课率，低于75%将被淘汰（设为BOOL）
    [manager countObsoleteStudent];
    
#pragma mark 插入一个新学员，并根据学号添加到指定位置，并输出所有学员信息
//    Student *newStudent = [[Student alloc] initWithName:@"newStudent" age:2 studentNumber:111 presents:@[@YES,@NO,@YES,@YES]];
    Student *newStudent = [Student sharedStudent];
    [manager insertANewStudent:newStudent];
    
#pragma mark 将新学员设置为单例，并将所有与之同龄的同学放入一个数组并输出
    NSMutableArray *theSameAgeStudents = [manager studentsHaveSameAgeWithSingletonStudent:newStudent];
    NSLog(@"%@", theSameAgeStudents);
    
#pragma mark 释放空间
    [student1 release];
    [student2 release];
    [student3 release];
    [student4 release];
    [manager release];
    return 0;
}

