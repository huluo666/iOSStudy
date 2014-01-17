//
//  Observer.m
//  七、引用与传值、类与类的关联
//
//  Created by 张鹏 on 13-11-4.
//  Copyright (c) 2013年 张鹏. All rights reserved.
//

#import "Observer.h"

@implementation Observer

- (id)initWithStudent:(Student *)student teacher:(Teacher *)teacher {
    
    self = [super init];
    if (self) {
        
        _student = [student retain];
        _teacher = [teacher retain];
        
    }
    return self;
}

- (void)dealloc {
    
    [_student release];
    [_teacher release];
    
    [super dealloc];
}

- (NSInteger)daysBetweenBirthdays {
    
    if (!_student || !_teacher) {
        return 0;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *studentBirthday = [formatter dateFromString:_student.birthday];
    NSDate *teacherBirthday = [formatter dateFromString:_teacher.birthday];
    NSTimeInterval timeInterval = [teacherBirthday timeIntervalSinceDate:studentBirthday];
    NSInteger days = round(timeInterval) / (3600 * 24);
    [formatter release];
    
    return days;
}

- (void)changeAges {
    
    if (!_student || !_teacher) {
        return;
    }
    
    NSInteger age = _student.age;
    _student.age = _teacher.age;
    _teacher.age = age;
}

+ (NSArray *)agesList {
    
    NSMutableArray *agesList = [NSMutableArray array];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *students = [userDefaults objectForKey:STUDENT_KEY];
    NSArray *teachers = [userDefaults objectForKey:TEACHER_KEY];
    
    for (NSDictionary *dict in students) {
        [agesList addObject:[dict objectForKey:@"age"]];
    }
    for (NSDictionary *dict in teachers) {
        [agesList addObject:[dict objectForKey:@"age"]];
    }
    
    return agesList;
}

@end





