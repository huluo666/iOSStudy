//
//  main.m
//  2014.1.17
//
//  Created by 张鹏 on 14-1-17.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Manager.h"

int main(int argc, const char * argv[])
{
    // 1.创建Student类，拥有name、age、score
    // 2.创建Manager类，使其持有5个学生
    // 3.将学生按照年龄从小到大排序
    // 4.找出分数最高的学生
    
    NSMutableArray *students = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        NSString *name = [NSString stringWithFormat:@"student%d", i];
        NSInteger age = arc4random() % 20 + 20;
        double score = arc4random() % 40 + 60;
        Student *student = [[Student alloc] initWithName:name
                                                     age:age
                                                   score:score];
        [students addObject:student];
        [student release];
    }
    
    Manager *manager = [[Manager alloc] initWithStudents:students];
    [manager sortStudents];
    
    Student *student = [manager highestScoreStudent];
    NSLog(@"student name = %@  score = %.2f", student.name, student.score);
    
    
    return 0;
}













