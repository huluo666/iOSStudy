//
//  Watcher.h
//  「OC」类的复合、管理者类、传值-作业
//
//  Created by cuan on 14-1-16.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Student;
@class Teacher;

@interface Watcher : NSObject

@property (retain, nonatomic) Student *student;
@property (retain, nonatomic) Teacher *teacher;

- (id)initWithStudent:(Student *)student teacher:(Teacher *)teacher;

/*!
 *    计算老师和学生的生日天数差值
 *
 *    @return 天数
 */
- (NSInteger)birthdayDifference;

/*!
 *    交换老师和学生的年龄
 */
- (void)exchangeAge;

/*!
 *    打包学生信息到dictionary
 *
 *    @return 打包好的学生信息
 */
- (NSDictionary *)packStudentInfo;

/*!
 *    打包学生信息到dictionary,传人一个学生对象
 *
 *    @param student 学生对象
 *
 *    @return return 打包好的学生信息
 */
- (NSDictionary *)packStudentInfoWithStudent:(Student *)student;

/*!
 *    打包老师信息到dictionary,传人一个老师对象
 *
 *    @param teacher 老师对象
 *
 *    @return return 打包好的老师信息
 */
- (NSDictionary *)packStudentInfoWithTeacher:(Teacher *)teacher;

/*!
 *    将一个学生的所有资料存放进userdefault中持久化存储
 *
 *    @return 是否存储成功
 */
- (BOOL)saveStudentInfoToUserDeafults;

/*!
 *    载入持久化存储的学生信息
 *
 *    @return 载入的学生信息字典
 */
- (NSDictionary *)loadStudentInfoFromUserDefaults;

/*!
 *    返回所有学生和老师的年龄数组
 *
 *    @param key UserDefaults关键字
 *
 *    @return 年龄数组
 */
- (NSArray *)getAgesArrayWithKey:(NSString *)key;

@end
