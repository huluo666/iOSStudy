//
//  main.m
//  九、数组、字典、字符串、对象、属性、方法的综合应用
//
//  Created by 张鹏 on 13-11-6.
//  Copyright (c) 2013年 张鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"
#import "Teacher.h"

int main(int argc, const char * argv[])
{
    
#pragma mark - 在一个数组中加入3个student，并按code排序
    
    Student *student1 = [[Student alloc] initWithName:@"student1" age:24 code:@"1110"];
    Student *student2 = [[Student alloc] initWithName:@"student2" age:26 code:@"1000"];
    Student *student3 = [[Student alloc] initWithName:@"student2" age:22 code:@"1200"];
    NSMutableArray *array = [NSMutableArray arrayWithObjects:student1, student2, student3, nil];
    [student1 release];
    [student2 release];
    [student3 release];
//    NSLog(@"%@", array);
//    [array sortUsingSelector:@selector(compareCode:)];
//    NSLog(@"sorted:%@", array);
    
#pragma mark - 构建一个Teacher类，并增加一个number属性，在上述数组中加入2个Teacher实例，并对这个数组按code和number排序
    
    Teacher *teacher1 = [[Teacher alloc] initWithName:@"teacher1" age:33 code:@"2000" number:@"1"];
    Teacher *teacher2 = [[Teacher alloc] initWithName:@"teacher2" age:30 code:@"2000" number:@"0"];
    [array addObject:teacher1];
    [array addObject:teacher2];
    [teacher1 release];
    [teacher2 release];
//    NSLog(@"%@", array);
//    [array sortUsingSelector:@selector(compareCodeAndNumber:)];
//    NSLog(@"sorted:%@", array);
    
#pragma mark - 给Teacher类增加一个NSMutableArray属性，描述其所有学生，构建3个Teacher对象，分别拥有1个，2个，3个学生
    
    Teacher *teacher3 = [[Teacher alloc] initWithName:@"teacher3" age:30 code:@"2000" number:@"2"];
    [teacher1 setStudents:@[student1]];
    [teacher2 setStudents:@[student1, student2]];
    [teacher3 setStudents:@[student1, student2, student3]];
    
    NSArray *teachers = @[teacher1, teacher2, teacher3];
    Teacher *theTeacher = [Teacher getSpecifiedTeacherFromArray:teachers];
    NSLog(@"%@", theTeacher);
    
    return 0;
}












