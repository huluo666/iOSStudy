//
//  WatchDoorDelegate.h
//  「OC」代理设计模式(Delegate)
//
//  Created by cuan on 14-1-28.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Dog;

@protocol WatchDoorDelegate <NSObject>
- (void)bark:(Dog *)aDog count:(NSInteger)count;


@end
