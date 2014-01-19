//
//  Teacher.h
//  「OC」类别、类扩展、协议、设计模式(委托、通知、单例)-作业
//
//  Created by cuan on 14-1-17.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Protocol.h"
#import "Student.h"



@interface Teacher : NSObject <Protocol, StudentDelegate>
{
    NSMutableArray *_studentArray;
    NSMutableArray *_averageScores;
}

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *code;
@property (retain, nonatomic) NSMutableArray *studentArray;
@property (retain, nonatomic) NSMutableArray *averageScores;

- (id)initWithName:(NSString *)name
              code:(NSString *)code
      studentArray:(NSMutableArray *)studentArray;
/**
 *  给监听器发送消息
 */
- (void)send;
@end

extern NSString * const TeacherNotificationName;