//
//  Manager.h
//  「OC」类的复合、管理者类、传值
//
//  Created by cuan on 14-1-16.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Student;
@class Teacher;

@interface Manager : NSObject

@property (retain, nonatomic) Student *student;
@property (retain, nonatomic) Teacher *teacher;
@property (retain, nonatomic) NSUserDefaults *userDefaults;

/*!
 *    老师名字大写赋给学生
 */
- (void)changeStudentName;

/*!
 *    计算老师和学生的年龄差值
 *
 *    @param student 学生对象
 *    @param teacher 老师对象
 *
 *    @return 年龄差值
 */

- (void)assignStudentAgeToTeacher;
- (void)assignStudentAgeToTeacherByUserDefaults;
+ (NSInteger)calculateAgeDifferenceBetweenStudent:(Student *)student teacher:(Teacher *)teacher;

@end
