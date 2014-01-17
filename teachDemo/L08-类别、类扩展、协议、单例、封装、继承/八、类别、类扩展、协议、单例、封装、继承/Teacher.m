//
//  Teacher.m
//  八、类别、类扩展、协议、单例、封装、继承
//
//  Created by 张鹏 on 13-11-6.
//  Copyright (c) 2013年 张鹏. All rights reserved.
//

#import "Teacher.h"

NSString * const TeacherNotificationName = @"TeacherNotificationName";

@implementation Teacher

- (id)initWithName:(NSString *)name code:(NSString *)code students:(NSArray *)students {
    
    self = [super init];
    if (self) {
        
        _name          = [name copy];
        _code          = [code copy];
        _students      = [students retain];
        _averageScores = [[NSMutableArray alloc] init];
        
    }
    return self;
}

- (void)dealloc {
    
    [_name          release];
    [_code          release];
    [_students      release];
    [_averageScores release];
    
    [super dealloc];
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"\nteacher\nname:%@\ncode:%@",
            _name, _code];
}

- (void)makeStudentProcessAverationScore {
    
    // 向通知中心发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:TeacherNotificationName
                                                        object:self];
}

#pragma mark - <CustomProtocol>

- (NSComparisonResult)compare:(id<CustomProtocol>)object {
    
    return [_name compare:object.name];
}

#pragma mark - <StudentDelegate>

- (void)student:(Student *)student completeProcessAverageScore:(double)averageScore {
    
    // 保存并统计学生信息及平均分
    [_averageScores addObject:@{@"name": student.name,
                                @"averageScore": @(averageScore),
                                @"code": student.code}];
    // 当最后一个学员计算完成后，打印统计的所有信息
    if ([_averageScores count] == [_students count]) {
        NSLog(@"%@", _averageScores);
    }
}

@end









