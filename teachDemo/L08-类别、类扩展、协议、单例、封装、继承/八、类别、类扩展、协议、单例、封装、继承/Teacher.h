//
//  Teacher.h
//  八、类别、类扩展、协议、单例、封装、继承
//
//  Created by 张鹏 on 13-11-6.
//  Copyright (c) 2013年 张鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomProtocol.h"
#import "Student.h"

@interface Teacher : NSObject <CustomProtocol, StudentDelegate> {
    
    NSString *_name;
    NSString *_code;
    
    NSArray *_students;
    NSMutableArray *_averageScores; // 平均分数组
}

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *code;

@property (retain, nonatomic) NSArray *students;
@property (retain, nonatomic) NSMutableArray *averageScores;

- (id)initWithName:(NSString *)name
              code:(NSString *)code
          students:(NSArray *)students;

/**
 * @brief: 发出通知，让所有学员执行计算平均分
 */
- (void)makeStudentProcessAverationScore;

@end

extern NSString * const TeacherNotificationName;


















