//
//  Dog.m
//  「OC」代理设计模式(Delegate)
//
//  Created by cuan on 14-1-28.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Dog.h"
#import "Human.h"

@implementation Dog

- (id)init
{
    if (self = [super init])
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)updateTimer
{
    NSLog(@"dog bark times : %ld", _barkCount++);
    
    // 通知狗的主人
    [_delegate bark:self count:_barkCount]; // 调用_delegate(Human)里面的bark:count:方法
}


@end
