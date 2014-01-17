//
//  main.m
//  七、引用与传值、类与类的关联
//
//  Created by 张鹏 on 13-11-3.
//  Copyright (c) 2013年 张鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Observer.h"

#define CLEAR 1

int main(int argc, const char * argv[])
{
//    if (CLEAR) {
#if CLEAR
        NSUserDefaults *userDefuats = [NSUserDefaults standardUserDefaults];
        [userDefuats removeObjectForKey:STUDENT_KEY];
        [userDefuats removeObjectForKey:TEACHER_KEY];
        [userDefuats synchronize];
#endif
//    }

#pragma mark - 建立一个学生类，建立一个老师类，增加3个属性，姓名，年龄，身份证号，出生日期，并使他们通过属性互相引用
    
    Teacher *teacher = [[Teacher alloc] initWithName:@"teacher"
                                                 age:35
                                            identity:@"510110197808220010"];
    Student *student = [[Student alloc] initWithName:@"student"
                                                 age:23
                                            identity:@"510102199004110010"];
    teacher.student = student;
    student.teacher = teacher;
    
#pragma mark - 设定一个观察者类，并在这个类中计算一个学生与一个老师出生日期的天数差
    
    Observer *observer = [[Observer alloc] initWithStudent:student teacher:teacher];
    NSInteger days = [observer daysBetweenBirthdays];
    NSLog(@"%ld", days);
    
#pragma mark - 实现年龄的交换方法，将一个学生的年龄与一个老师互换
    
    [observer changeAges];
    NSLog(@"student's age:%ld teahcer's age:%ld", student.age, teacher.age);
    
#pragma mark - 将一个学生的所有资料存放进userdefault中，并成功读取出这个学生
    
    [student saveInformationForKey:STUDENT_KEY];
    NSLog(@"%@", [Student loadInformationsForKey:STUDENT_KEY]);
    
#pragma mark - 将2个学生与2个老师的资料存放进userdefault中，实现一个方法返回userdefault中所有人（学生和老师）的年龄集合的方法。
    
    Teacher *teacher2 = [[Teacher alloc] initWithName:@"teacher"
                                                  age:35
                                             identity:@"510110197808220010"];
    Student *student2 = [[Student alloc] initWithName:@"student"
                                                  age:23
                                             identity:@"510102198504110010"];
    teacher2.student = student2;
    student2.teacher = teacher2;
    
    [teacher saveInformationForKey:TEACHER_KEY];
    [teacher2 saveInformationForKey:TEACHER_KEY];
    [student2 saveInformationForKey:STUDENT_KEY];
    
    NSArray *agesList = [Observer agesList];
    NSLog(@"%@", agesList);
    
    return 0;
}







