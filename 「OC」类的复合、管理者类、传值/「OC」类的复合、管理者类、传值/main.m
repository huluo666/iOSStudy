//
//  main.m
//  「OC」类的复合、管理者类、传值
//
//  Created by cuan on 14-1-16.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"
#import "Teacher.h"
#import "Manager.h"

int main(int argc, const char * argv[])
{
    // 类的复合、管理者类、传值
    // 类的复合：当前类中拥有指向其他类的指针或者成员变量
    
    Student *student = [[Student alloc] init];
    student.age = 23;
    student.name = @"Mike";

    Teacher *teacher = [[Teacher alloc] init];
    teacher.age = 27;
    teacher.name = @"Damon";

    NSInteger ageDiff = [Manager calculateAgeDifferenceBetweenStudent:student teacher:teacher];
    NSLog(@"%ld", ageDiff);
    
    Manager *manager = [[Manager alloc] init];
    manager.student = student;
    manager.teacher = teacher;
    [manager changeStudentName];
    NSLog(@"%@", student.name);
    
    
    
    // 第三方容器，直接取传值 数据持久化,文件系统支持
    // 数据库：SQLite
    
    // 单例：唯一的，单独的实例对象
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"name = %@", [userDefaults objectForKey:@"name"]);
    [userDefaults setObject:@"Mike" forKey:@"name"];
    [userDefaults synchronize];
    NSLog(@"name = %@", [userDefaults objectForKey:@"name"]);
    
    [userDefaults removeObjectForKey:@"name"];
    [userDefaults synchronize];
    NSLog(@"name = %@", [userDefaults objectForKey:@"name"]);
    
    // ...
    
//    NSLog(@"teacher's age = %ld", teacher.age);
//    [manager assignStudentAgeToTeacher];
//    NSLog(@"teacher's age = %ld", teacher.age);
    
    
    manager.userDefaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"-----");
    NSLog(@"teacher's age = %ld", teacher.age);
    [manager assignStudentAgeToTeacherByUserDefaults];
    NSLog(@"teacher's age = %ld", teacher.age);
    
    
    // 属性列表
    // 属性列表类：Cocoa知道如何将属性列表类写入文件系统，也可以吧属性列表文件加载到内存，初始化响应的对象
    // NSString, NSArray, NSDictionary, NSNumber, NSDate, NSData以及他们的变体(Mutable)
    
    
    
    [student release];
    [teacher release];
    [manager release];
    return 0;
}

