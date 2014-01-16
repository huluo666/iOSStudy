//
//  Student.m
//  「OC」类的复合、管理者类、传值
//
//  Created by cuan on 14-1-16.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Student.h"

@implementation Student

-(void)dealloc
{
    [_name release];
    [super dealloc];
}

@end
