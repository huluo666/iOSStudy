//
//  main.m
//  八、类别、类扩展、协议、单例、封装、继承
//
//  Created by 张鹏 on 13-11-6.
//  Copyright (c) 2013年 张鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+DateComponents.h"
#import "Teacher.h"
#import "Student.h"
#import "GoodStudent.h"

int main(int argc, const char * argv[])
{
    
#pragma mark - 在Student类中使用延展给NSObject类增加一个比较2个对象retainCount值的方法，返回他们的差值
    
//    Student *student = [[Student alloc] init]; // student = 1
//    Student *anotherPerson = [[Student alloc] init]; // anotherPerson = 1
//    
//    [student retain]; // student = 2
//    [student retain]; // student = 3
//    [student retain]; // student = 4
//    
//    NSLog(@"compare retain count:%lu", [student compareRetainCountWithStudent:anotherPerson]); // 3
//    // 释放对象
//    [student release];
//    [student release];
//    [student release];
//    [student release];
//    [anotherPerson release];
    
#pragma mark - 使用类目给NSDate类增加2个方法，分别返回当前时间是几点和几分（NSString类型），如3点58分，分别返回@“3”和@“58”
    
//    NSDate *date = [NSDate date];
//    NSLog(@"%@时 %@分", [date hour], [date minute]);
    
#pragma mark - 给Student设置默认的name和code属性，分别为@“默认”和@“0”，继承它写一个类GoodStudent，同样实现这2个默认属性，并增加一个默认属性type，其值默认为@“good”。
    
//    GoodStudent *goodStudent = [[GoodStudent alloc] init];
//    NSLog(@"%@", goodStudent);

#pragma mark - 将Student中name为@“张三”，code为@“0001”的同学作为单例；

//    Student *singletonStudent = [Student sharedStudent];
//    NSLog(@"%@", singletonStudent);
    
#pragma mark - 为Student添加一个集合属性score成绩，Teacher持有5个Student，让Student计算自身成绩的平均分并告知Teacher，最后Teacher使用集合统计所有学生的平均分并打印。（使用委托和通知的思想）
    
    Teacher *teacher = [[Teacher alloc] initWithName:@"理查德"
                                                code:@"1000"
                                            students:nil];
    
    // 配置学员信息
    NSMutableArray *students = [NSMutableArray arrayWithCapacity:5];
    for (int i = 0; i < 5; i++) {
        
        // 姓名
        NSString *name = [NSString stringWithFormat:@"student%d", i];
        // 编号
        NSString *code = [NSString stringWithFormat:@"%d", arc4random() % 8999 + 1000];
        // 四门课程分数
        NSMutableArray *scores = [NSMutableArray arrayWithCapacity:4];
        for (int j = 0; j < 4; j++) {
            [scores addObject:@(arc4random() % 60 + 40)];
        }
        
        Student *student = [[Student alloc] initWithName:name
                                                    code:code
                                                  scores:scores];
        NSLog(@"%@", student);
        // 将教师设置为学员的委托对象
        student.delegate = teacher;
        [students addObject:student];
        [student release];
    }
    // 教师持有所有学员
    teacher.students = students;
    
    // 教师让所有学员统计自身的平均分，并作统计
    [teacher makeStudentProcessAverationScore];
    
    
    return 0;
}












