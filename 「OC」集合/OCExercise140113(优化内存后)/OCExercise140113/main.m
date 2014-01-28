//
//  main.m
//  OCExercise140113
//
//  Created by cuan on 14-1-13.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"
/*
1.	将学员信息存放入一个可变字典，里面包含姓名，年龄，性别，身份证号。
2.	给学生类增加一个学员信息的NSMutableDictionary属性，里面包含他的所有个人资料。
3.	将所有学员放入一个数组；
4.	根据身份证号查询某个学员并输出其所有资料。
5.	随机选取2名学员查看其姓名，并计算他们年龄的差值。
6.	给其中2名学员的信息字典中增加一项title：@“三好学生”。
7.	遍历所有学员信息，从学员中挑出是三好学生并且年龄最小的一位。
*/

int main(int argc, const char * argv[])
{

        
    // 1
    NSLog(@"1.\n");
    NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                @"Lucy", @"name",
                                @"23", @"age",
                                @"female", @"sex",
                                @"513020199208121523", @"IDNumber",nil];
//    NSLog(@"retainCount = %ld", [mDic retainCount]);
    NSLog(@"name= %@, age = %@, sex = %@, IDNumber = %@",
          [mDic objectForKey:@"name"],
          [mDic objectForKey:@"age"],
          [mDic objectForKey:@"sex"],
          [mDic objectForKey:@"IDNumber"]);
    
    
     NSLog(@"retainCount = %ld", [mDic retainCount]);
    
    
    
    // 2
    
    // 3
    Student *stu1 = [[Student alloc] initWithName:@"Mike" sex:@"Male" IDNumber:@"513020199208121521" age:22 ];
    Student *stu2 = [[Student alloc] initWithName:@"Lili" sex:@"Famale" IDNumber:@"513020199208121541" age:27];
    Student *stu3 = [[Student alloc] initWithName:@"Matt" sex:@"Male" IDNumber:@"513020199208121110" age:24];
    
    NSMutableArray *studentArray = [NSMutableArray arrayWithObjects:stu1, stu2, stu3, nil];
    
    // 4
    NSLog(@"4.\n");
    NSString *IDNumberString = @"513020199208121541";
    [Student findStudentByIDNumber:IDNumberString fromStudentArray:studentArray];
    
    
    // 5
    NSLog(@"5.\n");
    NSLog(@"name = %@, name = %@, age diff = %ld", stu2.name, stu3.name,  [stu2 countAgeDiffToStudent:stu1]);
    
    // 6
    [stu2 addTitle];
    [stu3 addTitle];
    
    // 7
    NSLog(@"7.\n");
    Student *reslut =  [Student findTheYoungestExcellentStudent:studentArray];
    NSLog(@"%@", [reslut name]);
    
    NSLog(@"=====%@", [studentArray[0] name]);
    
//    [studentArray release];
    [stu1 release];
    [stu2 release];
    [stu3 release];

    
    return 0;
}