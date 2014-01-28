//
//  Person.h
//  「OC」NSKeyedArchiver
//
//  Created by cuan on 14-1-28.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject <NSCoding>

@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger age;
@property (retain, nonatomic) Person *child;

@end
