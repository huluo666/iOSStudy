//
//  Teacher.m
//  「OC」类的复合、管理者类、传值
//
//  Created by cuan on 14-1-16.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Teacher.h"

@implementation Teacher

-(void)dealloc
{
//    [_name release];
    self.name = nil;
    [super dealloc];
}

@end
