//
//  Human.h
//  「OC」代理设计模式(Delegate)
//
//  Created by cuan on 14-1-28.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WatchDoorDelegate.h"
@class Dog;

@interface Human : NSObject <WatchDoorDelegate>

@property (copy, nonatomic) NSString *name;
@property (retain, nonatomic) Dog *dog;

@end
