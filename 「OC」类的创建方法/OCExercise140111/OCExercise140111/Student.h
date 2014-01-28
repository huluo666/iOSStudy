//
//  Student.h
//  OCExercise140111
//
//  Created by cuan on 14-1-10.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@class Teacher;

@interface Student:Person
{

}
- (NSString *) name;
- (NSInteger) age;
- (NSInteger) height;

+ (Student *)compareHeightWithStudent1:(Student *)student1 Student2:(Student *)student2;
- (Student *)compareHeightWithStudent:(Student *)student;

@end
