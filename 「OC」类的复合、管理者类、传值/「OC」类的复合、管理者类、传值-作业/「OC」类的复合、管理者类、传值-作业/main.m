//
//  main.m
//  「OC」类的复合、管理者类、传值-作业
//
//  Created by cuan on 14-1-16.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"
#import "Teacher.h"
#import "Watcher.h"
/*
 1.	建立一个学生类，建立一个老师类，增加3个属性，姓名，年龄，身份证号，出生日期，并使他们通过属性互相引用；
 2.	设定一个观察者类，并在这个类中计算一个学生与一个老师出生日期的天数差；
 3.	实现年龄的交换方法，将一个学生的年龄与一个老师互换；
 4.	将一个学生的所有资料存放进userdefault中，并成功读取出这个学生；
 5.	将2个学生与2个老师的资料存放进userdefault中，实现一个方法返回userdefault中所有人（学生和老师）的年龄集合的方法。
 
*/

NSDate *getBirthdayDateFromString(NSString *birthString)
{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat: @"yyyyMMdd"];
    return [dateFormatter dateFromString:birthString];
}

int main(int argc, const char * argv[])
{

#pragma mark - 初始化操作
#pragma mark 初始化学生和老师并互相持有,初始化一个管理者类并持有学生和老师
    
    Student *student = [[Student alloc] initWithName:@"Student" age:22 IDNumber:@"51301019921032" birthday:getBirthdayDateFromString(@"19920102")];
    Teacher *teacher = [[Teacher alloc] initWithName:@"Teacher" age:30 IDNumber:@"51101019911034" birthday:getBirthdayDateFromString(@"19860406")];
    student.teacher = teacher;
    teacher.student = student;
    
    Student *anotherStudent = [[Student alloc] initWithName:@"anotherStudent" age:21 IDNumber:@"51301019931032" birthday:getBirthdayDateFromString(@"19910102")];
    Teacher *anotherTeacher = [[Teacher alloc] initWithName:@"anotherTeacher" age:31 IDNumber:@"51101019911032" birthday:getBirthdayDateFromString(@"19840406")];
    anotherStudent.teacher = anotherTeacher;
    anotherTeacher.student = anotherStudent;
    
    Watcher *watcher = [[Watcher alloc] initWithStudent:student teacher:teacher];

#pragma mark - 作业内容
#pragma mark 计算老师和学生的生日天数差值
    
    NSLog(@"生日天数差值为：%ld", [watcher birthdayDifference]);
    
#pragma mark 交换老师和学的年龄
    
    NSLog(@"student age = %ld", student.age);
    NSLog(@"teacher age = %ld", teacher.age);
    [watcher exchangeAge];
    NSLog(@"student age = %ld", student.age);
    NSLog(@"teacher age = %ld", teacher.age);
    
#pragma mark 将一个学生的所有资料存放进userdefault中，并读取出这个学生；
    
    [watcher saveStudentInfoToUserDeafults];
    NSDictionary *studentInfo =  [watcher loadStudentInfoFromUserDefaults];
    NSLog(@"%@", studentInfo);
    
#pragma mark 将2个学生与2个老师的资料存放进userdefault中；打印userdefault中所有人（学生和老师）的年龄集合的方法
    
    NSDictionary *studentDict = [watcher packStudentInfoWithStudent:student];
    NSDictionary *anotherStudentDict = [watcher packStudentInfoWithStudent:anotherStudent];
    NSDictionary *teacherDict = [watcher packStudentInfoWithTeacher:teacher];
    NSDictionary *anotherTeacherDict = [watcher packStudentInfoWithTeacher:anotherTeacher];
    
    // 将学生和老师信息封装进数组
    NSArray *infoArray = [[NSArray alloc] initWithObjects:studentDict, anotherStudentDict, teacherDict, anotherTeacherDict, nil];
    
    // 将数组信息持久化存储
    NSUserDefaults *persistenceUserInfo = [NSUserDefaults standardUserDefaults];
    [persistenceUserInfo setObject:infoArray forKey:@"infoArray"];
    [persistenceUserInfo synchronize];
    NSArray *agesArray = [watcher getAgesArrayWithKey:@"infoArray"];
    // 打印返回的年龄数组
    NSLog(@"%@", agesArray);
    
#pragma mark - 释放空间
    
    [student release];
    [teacher release];
    [anotherStudent release];
    [anotherTeacher release];
    [infoArray release];
    [watcher release];
    return 0;
}

