//
//  main.m
//  OCExercise140115
//
//  Created by cuan on 14-1-15.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"
#import "Utils.h"
/*
 1.	建一个学生类，增加姓名，年龄，身份证号3个属性；
 2.	给学生类增加一个birthday的NSDate只读属性，其设置方式为，在设置身份证号属性的同时设置出生日期；
 3.	给学生类增加一个type的 NSString属性，固定为@“student”；
 4.	给学生类增加一个NSPoint属性，描述学生的座位在几行几列，并计算任意2名学生的距离（假定前后左右相邻的2名同学相拒全部为1米）。
 
 */
int main(int argc, const char * argv[])
{
    Student *student = [[Student alloc]
                        initWithName:@"Mike"
                        age:22
                        IDNumber:@"513030199108131723"
                        pointer:NSMakePoint(1, 5)];
    
    NSLog(@"%@", student);
    
    Student *otherStudent = [[Student alloc] init];
    [otherStudent setPointer:NSMakePoint(2, 6)];

    NSLog(@"%f", [student distanceWithStudent:otherStudent]);
    
    [student release];
    [otherStudent release];
    return 0;
}

