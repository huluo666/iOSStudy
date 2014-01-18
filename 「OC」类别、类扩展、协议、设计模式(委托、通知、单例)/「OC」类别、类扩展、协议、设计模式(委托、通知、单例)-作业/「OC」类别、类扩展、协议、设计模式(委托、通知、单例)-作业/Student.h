//
//  Student.h
//  「OC」类别、类扩展、协议、设计模式(委托、通知、单例)-作业
//
//  Created by cuan on 14-1-17.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Protocol.h"

@class Student;

@protocol StudentDelegate <NSObject>

- (void) printStudent:(Student *)student averageScore:(double)averageScore;

@end

@interface Student : NSObject <Protocol>
{
    NSString *_code;
    NSString *_name;
    NSMutableArray *_scores;
    
    id<StudentDelegate> _delegate;
}

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *code;
@property (retain, nonatomic) NSMutableArray *scores;
@property (assign, nonatomic) id<StudentDelegate> delegate;


- (id)initWithName:(NSString *)name code:(NSString *)code;
- (id)initWithName:(NSString *)name code:(NSString *)code scores:(NSMutableArray *)scores;
- (double)calculateAvg;

/*!
 *    计算自身成绩
 */
- (void)calculateAverageScore;

+ (instancetype)sharedStudent;


@end

@interface Student ()

- (NSInteger)comareRetainCount:(Student *)student;

@end




