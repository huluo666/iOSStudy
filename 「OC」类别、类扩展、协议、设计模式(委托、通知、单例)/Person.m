//
//  Person.m
//  「OC」类别、类扩展、协议、设计模式(委托、通知、单例)
//
//  Created by cuan on 14-1-17.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Person.h"

@implementation Person

- (id)initWithName:(NSString *)name age:(NSInteger)age
{
    if (self = [super init])
    {
        _name = [name copy];
        _age  = age;
    }
    return self;
}

- (void)dealloc
{
    [_name release];
    [super dealloc];
}

@end
