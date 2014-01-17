//
//  Student.h
//  八、类别、类扩展、协议、单例、封装、继承
//
//  Created by 张鹏 on 13-11-6.
//  Copyright (c) 2013年 张鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomProtocol.h"

// 使用@class关键字为了在定义协议中使用Student类
@class Student;

// 声明StudentDelegate委托协议，此协议应该由Student对象的委托对象来遵守并实现
@protocol StudentDelegate <NSObject>

/**
 * @brief: 学员统计平均分完成后，委托对象执行的方法
 *
 * @param student     : 学员对象
 * @param averageScore: 学员计算完成的平均分
 */
- (void)student:(Student *)student
        completeProcessAverageScore:(double)averageScore;

@end

@interface Student : NSObject <CustomProtocol> {
    
    NSString *_name;
    NSString *_code;
    NSArray *_scores; // 分数集合
    
    id <StudentDelegate> _delegate; // 委托对象，不需要知道委托对象具体是什么类，只需要知道这个类遵守委托协议，可以执行委托方法即可
}

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *code;
@property (retain, nonatomic) NSArray *scores;
@property (assign, nonatomic) id <StudentDelegate> delegate;

- (id)initWithName:(NSString *)name
              code:(NSString *)code
            scores:(NSArray *)scores;

/**
 * @brief: 单例访问方法，此处仅实现了简单的单例
 *
 * @return: 唯一单例对象
 */
+ (instancetype)sharedStudent;

/**
 * @brief: 学员注册通知，监听教师发出的通知以响应通知执行方法
 */
- (void)registerNotification;

/**
 * @brief: 学员计算自身平均分
 */
- (void)processAverageScore;

@end

@interface Student ()

/**
 * @brief: 计算retainCount值
 *
 * @param object: 另一个Student对象
 *
 * @return: retainCount差
 */
- (NSUInteger)compareRetainCountWithStudent:(Student *)student;

@end










