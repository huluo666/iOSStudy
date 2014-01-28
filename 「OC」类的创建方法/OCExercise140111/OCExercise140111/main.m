//
//  main.m
//  OCExercise140111
//
//  Created by cuan on 14-1-10.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"
#import "Teacher.h"
/*
1.	建立一个学生类，包含姓名、年龄、身高成员变量；
2.	给学生类实现获取姓名、年龄、身高的实例方法；
3.	给学生类实现自定义初始化方法；
4.	建立一个老师类，包含姓名、年龄、学生成员变量，实现其自定义初始化方法，并使其与学生类能互相引用，计算老师与学生年龄的差值；
5.	给学生类增加一个比较2名学生身高的方法，返回身高较高的那位，分别实现类方法与实例方法。
*/

int main(int argc, const char * argv[])
{
    Student *student = [[Student alloc] initWithName:@"Mike" age:22 height:178];
    NSLog(@"name:%@, age:%ld, height:%ld", [student name], [student age], [student height]);
    NSLog(@"name:%@, age:%ld, height:%ld", student.name, student.age, (long)student.height);
    
    Teacher *teacher = [[Teacher alloc] initWithName:@"Tom" age:56 height:187 student:student];
    NSLog(@"%ld", [teacher ageDifferenceWith:student]);
    
    Student *student2 = [[Student alloc] initWithName:@"Peny" age:21 height:192];
    NSLog(@"%@", [[Student compareHeightWithStudent1:student Student2:student2] name]); // +
    NSLog(@"%@", [[student compareHeightWithStudent:student2] name]);   // -
    return 0;
}

