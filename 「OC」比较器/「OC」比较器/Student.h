//
//  Student.h
//  「OC」比较器
//
//  Created by cuan on 14-1-18.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject

@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger age;
@property (assign, nonatomic) NSInteger code;

- (id)initWithName:(NSString *)name age:(NSInteger)age code:(NSInteger)code;

@end
