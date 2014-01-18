//
//  Teacher.h
//  「OC」比较器
//
//  Created by cuan on 14-1-18.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Teacher : NSObject

@property (copy, nonatomic  ) NSString  *name;
@property (assign, nonatomic) NSInteger age;
@property (assign, nonatomic) NSInteger code;
@property (assign, nonatomic) NSInteger number;
@property (retain, nonatomic) NSMutableArray *studentsArray;

- (id)initWithName:(NSString *)name
               age:(NSInteger)age
              code:(NSInteger)code
            number:(NSInteger)number;

- (int)calculateStudentsAverageAge;

+ (Teacher *)haveYoungestStudent:(NSMutableArray *)teachersArray;

@end
