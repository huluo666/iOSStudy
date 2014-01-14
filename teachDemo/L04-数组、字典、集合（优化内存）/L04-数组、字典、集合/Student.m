//
//  Student.m
//  L04-数组、字典、集合
//
//  Created by 张鹏 on 14-1-12.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "Student.h"

@implementation Student

- (id)initWithInfoDictionary:(NSMutableDictionary *)infoDictionary {
    
    self = [super init];
    if (self) {
        
        _infoDictionary = [infoDictionary retain];
        
    }
    return self;
}

- (void)dealloc {
    
    [_infoDictionary release];
    
    [super dealloc];
}

- (void)setInfoDictionary:(NSMutableDictionary *)infoDictionary {
    
    if (_infoDictionary != infoDictionary) {
        [_infoDictionary release];
        _infoDictionary = [infoDictionary retain];
    }
}

- (NSMutableDictionary *)infoDictionary {
    
    return _infoDictionary;
}

// 对象描述方法：被动调用，对象打印的时候调用
- (NSString *)description {
    
    NSString *name     = [_infoDictionary objectForKey:@"name"];
    NSString *age      = [_infoDictionary objectForKey:@"age"];
    NSString *sex      = [_infoDictionary objectForKey:@"sex"];
    NSString *identity = [_infoDictionary objectForKey:@"identity"];
    
    return [NSString stringWithFormat:@"\nStudent:\nname:%@\nage%@\nsex:%@\nidentity:%@",
            name,
            age,
            sex,
            identity];
}

@end