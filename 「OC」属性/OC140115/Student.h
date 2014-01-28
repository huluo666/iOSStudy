//
//  Student.h
//  OC140115
//
//  Created by cuan on 14-1-15.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject

// 特性自动声明成员变量
// 特性自动实现了setter及getter
@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger age;
@property (copy, nonatomic) NSString *code;

- (void)dealloc;
- (id) initWithName:(NSString *)name age:(NSInteger)age code:(NSString *)code;
- (NSString *)description;
- (NSInteger)AgeDiffBetweenWithStudent:(Student *)student;
- (void)upperCaseStudentName;
- (void)assignNameWithAStudent:(Student *)aStudent;

@end
