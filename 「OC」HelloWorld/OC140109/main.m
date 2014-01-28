//
//  main.m
//  OC140109
//
//  Created by Rimi07 on 14-1-9.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Student.h"
#import "Teacher.h"
/*
 熟悉建立工程的步骤
 2.	熟悉类与对象的概念
 3.	熟悉建立类的方法
 4.	熟练写出类的初始化
 5.	掌握基本的类的引用方法
 */


int main(int argc, const char * argv[])
{

    NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"张三", @"01", @"李思", @"02", @"王武", @"03", nil];

    NSLog(@"%@", [mDic objectForKey:@"03"]);
    [mDic setObject:@"Lucy" forKey:@"02"];
    NSLog(@"%@", [mDic objectForKey:@"02"]);
    NSLog(@"%@", [mDic objectForKey:@"03"]);

    printf("-------");
    @autoreleasepool
    {
        
        // insert code here...
        NSLog(@"Hello, World!");
        
    
//        Student *stu = [Student alloc];
//        stu = [stu init];
        Student *stu = [[Student alloc] init];
        NSLog(@"%@", stu);
        [stu print];
        
        stu = [stu initWithName:@"Mike" age:@"24" code:@"124"];
        
        [stu description];
    }
    
    Teacher *te = [[Teacher alloc] initWithName:@"Tom" age:@"28"];
    NSLog(@"%@", te);
    return 0;
}

