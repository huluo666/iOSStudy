//
//  PlayItem.m
//  「OC」KVC(KeyValueCoding)
//
//  Created by cuan on 14-1-27.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "PlayItem.h"

@implementation PlayItem

- (void)dealloc
{
    [_name release];
    [super dealloc];
}

// 如果设置里面不存在的key就会触发该方法
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"function %@ is called", NSStringFromSelector(_cmd));
}

@end
