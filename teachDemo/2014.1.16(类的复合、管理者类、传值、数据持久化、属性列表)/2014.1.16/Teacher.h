//
//  Teacher.h
//  2014.1.16
//
//  Created by 张鹏 on 14-1-16.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"

@interface Teacher : NSObject {
    
    NSString *_name;
    NSInteger _age;
    
    Student *_student;
}

@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger age;
@property (retain, nonatomic) Student *student;

- (NSInteger)agesDifferent;

@end






