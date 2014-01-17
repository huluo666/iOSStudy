//
//  Teacher.h
//  七、引用与传值、类与类的关联
//
//  Created by 张鹏 on 13-11-4.
//  Copyright (c) 2013年 张鹏. All rights reserved.
//

#import "Person.h"

#define TEACHER_KEY @"TeacherKey"

@class Student;

@interface Teacher : Person {
    
    Student *_student;
}

@property (retain, nonatomic) Student *student;

@end










