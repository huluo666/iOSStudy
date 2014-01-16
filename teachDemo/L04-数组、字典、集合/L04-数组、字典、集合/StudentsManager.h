//
//  StudentsManager.h
//  L04-数组、字典、集合
//
//  Created by 张鹏 on 14-1-12.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"

@interface StudentsManager : NSObject {
    
    NSMutableArray *_students;
}

- (id)initWithStudents:(NSMutableArray *)students;

- (void)setStudents:(NSMutableArray *)students;
- (NSMutableArray *)students;

/**
 * @brief: 使用身份证号查询学员
 *
 * @param identity: 身份证号码
 */
- (Student *)searchStudentWithIdentity:(NSString *)identity;

/**
 * @brief: 搜索并打印学生
 *
 * @param identity: 身份证号码
 */
- (void)printStudentInformationWithIdentity:(NSString *)identity;

/**
 * @brief: 输出学生姓名，并计算学生年龄差
 *
 * @param identity       : 第一个学生身份证号码
 * @param anotherIdentity: 第二个学生身份证号码
 *
 * @return: 年龄差
 */
- (NSInteger)agesBetweenStudentWithIdentity:(NSString *)identity
                            anotherIdentity:(NSString *)anotherIdentity;

/**
 * @brief: 构造三好学生
 *
 * @param identity: 身份证号码
 */
- (void)makeExcellentStudentWithIdentity:(NSString *)identity;

/**
 * @brief: 年龄最小的三好学生
 *
 * @return: 目标学员
 */
- (Student *)youngestExcellentStudent;


@end
