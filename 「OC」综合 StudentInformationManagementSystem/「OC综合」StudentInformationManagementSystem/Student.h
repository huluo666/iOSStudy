//
//  Student.h
//  「OC综合」StudentInformationManagementSystem
//
//  Created by cuan on 14-1-20.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject

@property (copy, nonatomic  ) NSString  *name;
@property (assign, nonatomic) NSInteger age;
@property (assign, nonatomic) NSInteger studentNumber;
@property (retain, nonatomic) NSArray   *presents;
@property (assign, nonatomic) BOOL      isPass;

/*!
 *    初始化学生对象
 *
 *    @param name          姓名
 *    @param age           年龄
 *    @param studentNumber 学号
 *    @param presents      出勤表
 *
 *    @return 学生对象 
 */
- (id)initWithName:(NSString *)name
               age:(NSInteger)age
     studentNumber:(NSInteger)studentNumber
          presents:(NSArray *)presents;

/*!
 *    学生单例
 *
 *    @return 学生单例对象
 */
+ (instancetype)sharedStudent;

@end
