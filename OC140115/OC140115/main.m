//
//  main.m
//  OC140115
//
//  Created by cuan on 14-1-15.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"

int main(int argc, const char * argv[])
{

//    NSString *string = @"he,l,lo,w,or,ld!";
//    NSArray *array = [string componentsSeparatedByString:@","];
//    NSString *result = [array componentsJoinedByString:@""];
//    NSLog(@"%@", result);
    
//    NSString *string = @"0180go923o08d";
//    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"1234567890"];
//    NSString *result = [[string componentsSeparatedByCharactersInSet:set] componentsJoinedByString:@""];
//    NSLog(@"%@", result);
    
    // 属性
//    Student *student = [[Student alloc] init];
//    student.name = @"Lucy";
//    student.age  = 11;
//    student.code = @"123676512478";
    Student *student = [[Student alloc] initWithName:@"Lucy" age:22 code:@"12414214235235143"];
    NSLog(@"%@", student);
    
    /*
    1.Student增加code特性，并赋值
    2.计算两个Student年龄差
    3.Student的name转大写
    4.将一个Student的name赋值给另外一个Student，使用特性
    */
    Student *student2 = [[Student alloc] init];
    student2.age  = 21;
    student2.name = @"Lily";
    NSLog(@"年龄差值为：%ld",[student AgeDiffBetweenWithStudent:student2]);
    
    [student upperCaseStudentName];
    NSLog(@"%@", student);
    
    [student assignNameWithAStudent:student2];
    
    NSLog(@"%@", student);
    
    [student release];
    [student2 release];
    
    

    return 0;
}

