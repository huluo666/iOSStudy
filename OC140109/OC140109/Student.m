//
//  Student.m
//  OC140109
//
//  Created by  on 14-1-9.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Student.h"

@implementation Student
- (void)print
{
    NSLog(@"dddd");
}

// id == NSObject * == void *
- (id)init
{
    self = [super init];
    if (self)
    {
        _name = @"Lucy";
        _age = @"22";
    }
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"name=%@ code=%@ code:%@",_name, _age, _code];
}

- (id)initWithName:(NSString *) name age:(NSString *) age code:(NSString *) code
{
    self = [super init];
    if (self)
    {
        _name = name;
        _age  = age;
        _code = code;
    }
    return self;
}
@end
// NULL: 标识为空一种结构
// nil : 标识为空的对象