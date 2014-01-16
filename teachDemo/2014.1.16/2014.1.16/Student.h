//
//  Student.h
//  2014.1.16
//
//  Created by 张鹏 on 14-1-16.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>

// @class:1.避免类在头文件相互导入，出现的编译错误
//        2.告诉编译器，这是一个类，你不用知道它内部的实现，直接是用即可
@class Teacher;

#define STUDENT_KEY @"Student"

@interface Student : NSObject {
    
    NSString *_name;
    NSInteger _age;
    
    Teacher *_teacher;
}

@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger age;
@property (assign, nonatomic) Teacher *teacher;

- (NSInteger)agesDifferent;
- (NSDictionary *)dictionary;
- (void)save;
+ (NSDictionary *)load;

@end











