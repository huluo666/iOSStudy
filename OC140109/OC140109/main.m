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
#define min(a, b) a>b ? a:b

int main(int argc, const char * argv[])
{
    
    int a = 4>>1, b = 0;
    printf("a=%d, b=%d\n", a, b);
    printf("-----%d\n", min(1^0,0));
    

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

