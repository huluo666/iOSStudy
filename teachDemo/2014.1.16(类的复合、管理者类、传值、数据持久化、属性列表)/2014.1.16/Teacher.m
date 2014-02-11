//
//  Teacher.m
//  2014.1.16
//
//  Created by 张鹏 on 14-1-16.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "Teacher.h"

@implementation Teacher

- (void)dealloc {
    
    [_name    release];
    [_student release];
    
    NSLog(@"teacher dealloced.");
    
    [super dealloc];
}

- (NSInteger)agesDifferent {
    
    return _age - _student.age;
}

@end
