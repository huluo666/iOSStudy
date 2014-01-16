//
//  Manager.m
//  2014.1.16
//
//  Created by 张鹏 on 14-1-16.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "Manager.h"

@implementation Manager

- (void)dealloc {
    
    [_student release];
    [_teacher release];
    
    [super dealloc];
}

- (NSInteger)agesDifference {
    
    return _teacher.age - _student.age;
}

- (void)exchangeName {
    
    _student.name = [_teacher.name uppercaseString];
}

- (void)exchangeAge {
    
    NSDictionary *dictionary = [Student load];
    _teacher.age = [[dictionary objectForKey:@"age"] integerValue];
}

@end









