//
//  GoodStudent.m
//  八、类别、类扩展、协议、单例、封装、继承
//
//  Created by 张鹏 on 13-11-6.
//  Copyright (c) 2013年 张鹏. All rights reserved.
//

#import "GoodStudent.h"

@implementation GoodStudent

- (id)init {
    
    self = [super init];
    if (self) {
        
        _type = @"good";
        
    }
    return self;
}

- (void)dealloc {
    
    [_type release];
    
    [super dealloc];
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"\nstudent:\nname:%@\ncode:%@\ntype:%@\nscores:%@",
            _name, _code, _type, _scores];
}

@end
