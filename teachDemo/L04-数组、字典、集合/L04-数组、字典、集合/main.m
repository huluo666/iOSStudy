//
//  main.m
//  L04-数组、字典、集合
//
//  Created by 张鹏 on 14-1-12.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StudentsManager.h"

int main(int argc, const char * argv[])
{
    
#pragma mark - 1.将学员信息存放入一个可变字典，里面包含姓名，年龄，性别，身份证号;
#pragma mark - 2.给学生类增加一个学员信息的NSMutableDictionary成员变量，里面包含他的所有个人资料;
#pragma mark - 3.将所有学员放入一个数组;
    
    NSArray *nameList     = [NSArray arrayWithObjects:@"理查德", @"斯黛拉", @"查尔斯", @"威廉姆", @"凯瑟琳", nil];
    NSArray *ageList      = [NSArray arrayWithObjects:@"21", @"26", @"23", @"21", @"20", nil];
    NSArray *sexList      = [NSArray arrayWithObjects:@"male", @"female", @"male", @"male", @"female", nil];
    NSArray *identityList = [NSArray arrayWithObjects:
                             @"510104198904130012",
                             @"510111198511020011",
                             @"510102198804100112",
                             @"510109199011130012",
                             @"510104199110130019", nil];
    
    NSMutableArray *students = [NSMutableArray arrayWithCapacity:5];
    
    for (int i = 0; i < 5; i++) {
    
        NSMutableDictionary *infoDictionary = [NSMutableDictionary dictionary];
        [infoDictionary setObject:[nameList objectAtIndex:i]     forKey:@"name"];
        [infoDictionary setObject:[ageList objectAtIndex:i]      forKey:@"age"];
        [infoDictionary setObject:[sexList objectAtIndex:i]      forKey:@"sex"];
        [infoDictionary setObject:[identityList objectAtIndex:i] forKey:@"identity"];
        
        Student *student = [[Student alloc] initWithInfoDictionary:infoDictionary];
        
        [students addObject:student];
    }
    
    StudentsManager *manager = [[StudentsManager alloc] initWithStudents:students];
    
#pragma mark - 4.根据身份证号查询某个学员并输出其所有资料;
    
//    [manager printStudentInformationWithIdentity:[identityList objectAtIndex:arc4random() % 5]];
    
#pragma mark - 5.随机选取2名学员查看其姓名，并计算他们年龄的差值;
    
//    NSInteger age = [manager agesBetweenStudentWithIdentity:[identityList objectAtIndex:1]
//                                            anotherIdentity:[identityList objectAtIndex:3]];
//    NSLog(@"age between students is '%ld'.", age);
    
#pragma mark - 6.给其中2名学员的信息字典中增加一项title：@“三好学生”;
    
    [manager makeExcellentStudentWithIdentity:[identityList objectAtIndex:0]];
    [manager makeExcellentStudentWithIdentity:[identityList objectAtIndex:4]];
    
#pragma mark - 7.遍历所有学员信息，从学员中挑出是三好学生并且年龄最小的一位。
    
    Student *youngestExcellentStudent = [manager youngestExcellentStudent];
    NSLog(@"%@", youngestExcellentStudent);
    
    return 0;
}













