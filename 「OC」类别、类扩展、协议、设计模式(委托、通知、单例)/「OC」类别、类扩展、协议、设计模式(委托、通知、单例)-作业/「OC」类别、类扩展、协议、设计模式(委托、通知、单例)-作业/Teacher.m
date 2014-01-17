//
//  Teacher.m
//  「OC」类别、类扩展、协议、设计模式(委托、通知、单例)-作业
//
//  Created by cuan on 14-1-17.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Teacher.h"

@implementation Teacher
@dynamic name;

- (NSComparisonResult)compare:(id)object
{
    return [[self name] compare:[object name]];
}

@end
