//
//  Teacher.h
//  九、数组、字典、字符串、对象、属性、方法的综合应用
//
//  Created by 张鹏 on 13-11-6.
//  Copyright (c) 2013年 张鹏. All rights reserved.
//

#import "Student.h"

@interface Teacher : Student {
    
    NSString *_number;
    NSArray *_students;
}

@property (copy, nonatomic) NSString *number;
@property (retain, nonatomic) NSArray *students;

- (instancetype)initWithName:(NSString *)name
                         age:(NSInteger)age
                        code:(NSString *)code
                      number:(NSString *)number;

+ (instancetype)getSpecifiedTeacherFromArray:(NSArray *)teachers;

@end
