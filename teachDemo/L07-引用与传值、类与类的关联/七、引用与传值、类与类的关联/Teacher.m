//
//  Teacher.m
//  七、引用与传值、类与类的关联
//
//  Created by 张鹏 on 13-11-4.
//  Copyright (c) 2013年 张鹏. All rights reserved.
//

#import "Teacher.h"
#import "Student.h"

@implementation Teacher

- (void)dealloc {
    
    [_student release];
    
    [super dealloc];
}

@end
