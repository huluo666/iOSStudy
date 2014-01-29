//
//  Dog.h
//  「OC」代理设计模式(Delegate)
//
//  Created by cuan on 14-1-28.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol WatchDoorDelegate;

@interface Dog : NSObject

@property (retain, nonatomic) NSTimer *timer;
@property (assign, nonatomic) NSInteger barkCount;
@property (assign, nonatomic) NSInteger ID;
@property (assign, nonatomic) id<WatchDoorDelegate> delegate;

@end
