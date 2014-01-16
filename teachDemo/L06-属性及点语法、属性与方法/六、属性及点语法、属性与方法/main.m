//
//  main.m
//  四、属性及点语法、属性与方法
//
//  Created by 张鹏 on 13-11-2.
//  Copyright (c) 2013年 张鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"

int main(int argc, const char * argv[])
{
    Student *student1 = [[Student alloc] initWithName:@"理查德"
                                                  age:40
                                             identity:@"510101197710150004"
                                             location:NSMakePoint(1, 1)];
    
    Student *student2 = [[Student alloc] initWithName:@"詹姆斯"
                                                  age:33
                                             identity:@"510104198408090011"
                                             location:NSMakePoint(5, 5)];
    NSLog(@"%@", student1);
    NSLog(@"%@", student2);
    
    float distance = [student1 distanceWithStudent:student2];
    NSLog(@"\ndistance betwenn two students = %.2f", distance);
    
    return 0;
}

