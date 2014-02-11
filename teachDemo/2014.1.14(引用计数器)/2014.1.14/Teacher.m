//
//  Teacher.m
//  2014.1.14
//
//  Created by 张鹏 on 14-1-14.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "Teacher.h"

@implementation Teacher

- (id)initWithStudent:(Student *)student {
    
    self = [super init];
    if (self) {
        _student = [student retain];
    }
    return self;
}

+ (Teacher *)teacher {
    
    Teacher *teacher = [[Teacher alloc] init];
    
    return [teacher autorelease];
}

+ (Teacher *)teacherWithStudent:(Student *)student {
    
    Teacher *teacher = [[Teacher alloc] initWithStudent:student];
    
    return [teacher autorelease];
}

// 析构函数
- (void)dealloc {
    
    [_student release];
    
    NSLog(@"teacher dealloced.");
    
    [super dealloc];
}

- (void)setStudent:(Student *)student {
    
    // 排除了对象相同情况出现的异常
    if (_student != student) {
        [_student release];
        _student = [student retain];
    }
}

- (Student *)student {
    
    return _student;
}

@end












