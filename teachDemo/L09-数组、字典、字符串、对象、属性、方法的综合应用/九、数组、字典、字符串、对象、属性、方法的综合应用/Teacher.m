//
//  Teacher.m
//  九、数组、字典、字符串、对象、属性、方法的综合应用
//
//  Created by 张鹏 on 13-11-6.
//  Copyright (c) 2013年 张鹏. All rights reserved.
//

#import "Teacher.h"

@implementation Teacher

- (instancetype)initWithName:(NSString *)name
                         age:(NSInteger)age
                        code:(NSString *)code
                      number:(NSString *)number {
    
    self = [super initWithName:name age:age code:code];
    if (self) {
        
        _number = [number copy];
        
    }
    return self;
}

- (void)dealloc {
    
    [_number   release];
    [_students release];
    
    [super dealloc];
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"teacher name:%@  age:%ld  code:%@  number:%@.", _name, _age, _code, _number];
}

#pragma mark Get the teacher

+ (instancetype)getSpecifiedTeacherFromArray:(NSArray *)teachers {
    
    if (!teachers || [teachers count] == 0) {
        return nil;
    }
    
    Teacher *resultTeacher = nil;
    // 最小学生平均年龄
    NSInteger minimumAverageAge = 100;
    for (Teacher *teacher in teachers) {
        NSInteger sum = 0;
        for (Student *student in teacher.students) {
            sum += student.age;
        }
        NSInteger averageAge = sum / [teacher.students count];
        if (minimumAverageAge > averageAge) {
            minimumAverageAge = averageAge;
            resultTeacher = teacher;
        }
    }
    NSLog(@"students' average age:%ld", minimumAverageAge);
    
    return resultTeacher;
}

@end







