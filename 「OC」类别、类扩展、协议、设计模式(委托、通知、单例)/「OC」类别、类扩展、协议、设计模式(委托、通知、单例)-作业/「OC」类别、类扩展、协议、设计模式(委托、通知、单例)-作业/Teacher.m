//
//  Teacher.m
//  「OC」类别、类扩展、协议、设计模式(委托、通知、单例)-作业
//
//  Created by cuan on 14-1-17.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Teacher.h"

NSString * const TeacherNotificationName = @"TeacherNotificationName";

@implementation Teacher

- (id)initWithName:(NSString *)name
              code:(NSString *)code
      studentArray:(NSMutableArray *)studentArray
{
    if (self = [super init])
    {
        _name = [name copy];
        _code = [code copy];
        _studentArray = studentArray;
        _averageScores = [[NSMutableArray alloc] init];
    }
    return  self;
}

- (void)dealloc
{
    [_name release];
    [_code release];
    [_studentArray release];
    [_averageScores release];
    [super dealloc];
}


- (NSComparisonResult)compare:(id)object
{
    return [[self name] compare:[object name]];
}

- (void)printStudent:(Student *)student averageScore:(double)averageScore
{
    // 保存并统计学生信息以及平均分
    [_averageScores addObject:@{@"name":student.name, @"averageScore":@(averageScore), @"code":student.code}];
    
    if ([_averageScores count] == [_studentArray count])
    {
        NSLog(@"%@", _averageScores);
    }
}

- (void)send
{
    [[NSNotificationCenter defaultCenter] postNotificationName:TeacherNotificationName object:self];
}


@end
