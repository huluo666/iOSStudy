//
//  GoodStudent.m
//  「OC」类别、类扩展、协议、设计模式(委托、通知、单例)-作业
//
//  Created by cuan on 14-1-17.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "GoodStudent.h"

@implementation GoodStudent

- (id)init
{
    if (self = [super init])
    {
        _type = @"good";
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"name = %@, code = %@, type = %@", _name, _code, _type];
}

@end
