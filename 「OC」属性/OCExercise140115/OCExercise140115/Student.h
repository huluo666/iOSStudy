//
//  Student.h
//  OCExercise140115
//
//  Created by cuan on 14-1-15.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject

@property (copy, nonatomic)     NSString  *name;
@property (assign, nonatomic)   NSInteger   age;
@property (copy, nonatomic)     NSString  *IDNumber;
@property (copy, readonly, nonatomic) NSDate    *birthday;
@property (copy, readonly, nonatomic) NSString  *type;
@property (assign, nonatomic)   NSPoint   pointer;

/*!
 *    初始化学生
 *
 *    @param name     学生姓名
 *    @param age      学生年龄
 *    @param IDNumber 学生身份证号码
 *    @param pointer  学生位置
 *
 *    @return 初始化好的学生对象
 */
- (id)initWithName:(NSString *)name age:(NSInteger)age
          IDNumber:(NSString *)IDNumber pointer:(NSPoint)pointer;

/*!
 *    析构
 */
- (void)dealloc;

/*!
 *    打印对象
 *
 *    @return 对方字符串
 */
- (NSString *)description;

/*!
 *    两名学生之间的距离
 *
 *    @param student 学生对象
 *
 *    @return 距离
 */
- (CGFloat) distanceWithStudent:(Student *)student;


@end
