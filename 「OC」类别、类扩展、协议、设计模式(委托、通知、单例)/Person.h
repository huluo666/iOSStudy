//
//  Person.h
//  「OC」类别、类扩展、协议、设计模式(委托、通知、单例)
//
//  Created by cuan on 14-1-17.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger age;

- initWithName:(NSString *)name age:(NSInteger)age;

@end
