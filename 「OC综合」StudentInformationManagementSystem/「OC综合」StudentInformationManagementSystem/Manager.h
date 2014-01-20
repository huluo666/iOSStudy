//
//  Manager.h
//  「OC综合」StudentInformationManagementSystem
//
//  Created by cuan on 14-1-20.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Student;

@interface Manager : NSObject

@property (retain, nonatomic) NSMutableArray *students;
@property (retain, nonatomic) NSMutableArray *studentsForSameAge;

/*!
 *    初始化管理者类
 *
 *    @param students 学生数组
 *
 *    @return 管理者对象
 */
- (id)initWithStudents:(NSMutableArray *)students;

/*!
 *    根据姓氏查询某个学员，并查看当天是否正常到课
 *
 *    @param studentName 学生姓名
 *    @param aDay        哪一天
 */
- (void)searchPresentOfStudent:(NSString *)studentName atDay:(NSInteger)aDay;

/*!
 *    统计学员的到课率,低于75%被淘汰
 */
- (void)countObsoleteStudent;

/*!
 *    插入一个新学员，并根据学号添加到指定位置，数组为有序数组
 *
 *    @param newStudent 新学员对象
 */
- (void)insertANewStudent:(Student *)newStudent;

/*!
 *    与单例对象同龄的同学放入一个数组并输出。
 *
 *    @param singletonStudent 单例对象
 *
 *    @return 同龄学生对象数组
 */
- (NSMutableArray *)studentsHaveSameAgeWithSingletonStudent:(Student *)singletonStudent;


@end
