//
//  Student.m
//  九、数组、字典、字符串、对象、属性、方法的综合应用
//
//  Created by 张鹏 on 13-11-6.
//  Copyright (c) 2013年 张鹏. All rights reserved.
//

#import "Student.h"
#import "Teacher.h"

@implementation Student

- (instancetype)initWithName:(NSString *)name age:(NSInteger)age code:(NSString *)code {
    
    self = [super init];
    if (self) {
        
        _name = [name copy];
        _code = [code copy];
        _age  = age;
        
    }
    return self;
}

- (void)dealloc {
    
    [_name release];
    [_code release];
    
    [super dealloc];
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"student name:%@  age:%ld  code:%@.",
            _name, _age, _code];
}

- (NSComparisonResult)compareCode:(Student *)object {
    
    if (object.code.length == 0) {
        return NSOrderedDescending;
    }
    return [_code compare:object.code options:NSNumericSearch];
}

- (NSComparisonResult)compareCodeAndNumber:(id<CompareProtocol>)object {
    
    if (object.code.length == 0) {
        return NSOrderedDescending;
    }
    if ([self isKindOfClass:[Teacher class]] &&
        [object isKindOfClass:[Teacher class]] &&
        [_code isEqualToString:object.code]) {
        return [[(Teacher *)self number] compare:[(Teacher *)object number]
                                         options:NSNumericSearch];
    }
    else return [_code compare:object.code options:NSNumericSearch];
}

@end













