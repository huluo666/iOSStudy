//
//  Manager.m
//  2014.1.17
//
//  Created by 张鹏 on 14-1-17.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "Manager.h"

@implementation Manager

- (id)initWithStudents:(NSMutableArray *)students {
    
    self = [super init];
    if (self) {
        
        _students = [students retain];
        
    }
    return self;
}

- (void)dealloc {
    
    [_students release];
    
    [super dealloc];
}

- (void)sortStudents {
    
    if (_students && [_students count] > 0) {
        [_students sortUsingSelector:@selector(compareScore:)];
        NSLog(@"%@", _students);
    }
}

- (Student *)highestScoreStudent {
    
    Student *resultStudent = nil;
    double maximumScore = 0.0;
    for (Student *student in _students) {
        if (maximumScore < student.score) {
            maximumScore = student.score;
            resultStudent = student;
        }
    }
    return resultStudent;
}

@end








