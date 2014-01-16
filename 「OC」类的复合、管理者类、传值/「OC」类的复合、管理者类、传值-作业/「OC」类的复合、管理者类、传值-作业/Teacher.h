//
//  Teacher.h
//  「OC」类的复合、管理者类、传值-作业
//
//  Created by cuan on 14-1-16.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Student;

@interface Teacher : NSObject

@property (copy, nonatomic)   NSString  *name;
@property (assign, nonatomic) NSInteger   age;
@property (copy, nonatomic)   NSString  *IDNumber;
@property (retain, nonatomic) NSDate    *birthday;
@property (retain, nonatomic) Student   *student;

- (id) initWithName:(NSString *)name
                age:(NSInteger)age
           IDNumber:(NSString *)IDNumber
           birthday:(NSDate *)birthday;

@end
