//
//  Teacher.m
//  2014.1.18plus
//
//  Created by 张鹏 on 14-1-18.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "Teacher.h"

@implementation Teacher

- (id)initWithName:(NSString *)name age:(NSInteger)age student:(Student *)student {
    
    self = [super init];
    if (self) {
        
        _name = [name copy];
        _age = age;
        _student = [student retain];
        
    }
    return self;
}

- (void)dealloc {
    
    [_name release];
    [_student release];
    
    [super dealloc];
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"teacher name = %@ age = %ld",
            _name, _age];
}

- (NSComparisonResult)compareAge:(id<CompareProtocol>)object {
    
    NSComparisonResult result;
    if (_age == [object age]) {
        result = NSOrderedSame;
    }
    else if (_age > [object age]) {
        result = NSOrderedDescending;
    }
    else {
        result = NSOrderedAscending;
    }
    return result;
}

@end
