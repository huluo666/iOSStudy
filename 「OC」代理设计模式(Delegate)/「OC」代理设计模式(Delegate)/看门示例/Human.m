//
//  Human.m
//  「OC」代理设计模式(Delegate)
//
//  Created by cuan on 14-1-28.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Human.h"
#import "WatchDoorDelegate.h"
#import "Dog.h"

@implementation Human

- (void)dealloc
{
    [_name release];
    [_dog release];
    [super dealloc];
}

- (id)init
{
    if (self = [super init])
    {
        _name = [@"Lucy" copy];
    }
    return self;
}

// 当狗叫的时候来调用人的这个方法
- (void)bark:(Dog *)aDog count:(NSInteger)count
{
    NSLog(@"%@'s dog %ld bark %ld", [self name], aDog.ID, count);
}

@end
