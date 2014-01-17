//
//  Student.m
//  2014.1.17
//
//  Created by 张鹏 on 14-1-17.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "Student.h"

@implementation Student

- (id)initWithName:(NSString *)name
               age:(NSInteger)age
             score:(double)score {
    
    self = [super init];
    if (self) {
        
        _name  = [name copy];
        _age   = age;
        _score = score;
        
    }
    return self;
}

- (void)dealloc {
    
    [_name release];
    
    [super dealloc];
}

- (NSComparisonResult)compareScore:(Student *)student {
    
    NSComparisonResult result;
    if (_score == student.score) {
        result = NSOrderedSame;
    }
    else if (_score > student.score) {
        result = NSOrderedDescending;
    }
    else {
        result = NSOrderedAscending;
    }
    return result;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"student name:%@ age%ld score:%.2f", _name, _age, _score];
}

@end










