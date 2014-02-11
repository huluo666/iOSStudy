//
//  main.m
//  2014.1.14
//
//  Created by 张鹏 on 14-1-14.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"
#import "Teacher.h"

int main(int argc, const char * argv[])
{
    // 初始化：alloc ＋ init
    // 持有对象：retain
    // 释放对象：release
    // 查看引用计数：retainCount
    // 销毁对象：dealloc，禁止手动调用（description）
    
//    Student *student = [[Student alloc] init]; // retainCount = 1
//    NSLog(@"retain count = %lu", [student retainCount]);
//    [student retain]; // retainCount = 2
//    NSLog(@"retain count = %lu", [student retainCount]);
//    [student retain]; // retainCount = 3
//    NSLog(@"retain count = %lu", [student retainCount]);
//    [student release]; // retainCount = 2
//    NSLog(@"retain count = %lu", [student retainCount]);
//    [student retain]; // retainCount = 3
//    NSLog(@"retain count = %lu", [student retainCount]);
//    [student release]; // retainCount = 2
//    NSLog(@"retain count = %lu", [student retainCount]);
//    [student release]; // retainCount = 1
//    NSLog(@"retain count = %lu", [student retainCount]);
//    [student release]; // retainCount = 1 : 悬垂指针
    
//    Student *student = [[Student alloc] init]; // 1
//    Teacher *teacher = [[Teacher alloc] initWithStudent:student]; // 2
//    [student release];
//    [teacher release];
    
    
    // 自动释放池 autorelease
//    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
//    Student *student = [[Student alloc] init];
//    NSLog(@"retain count = %lu", [student retainCount]); // 1
//    [student retain];
//    NSLog(@"retain count = %lu", [student retainCount]); // 2
//    [student retain];
//    NSLog(@"retain count = %lu", [student retainCount]); // 3
//    // 把对象加入自动释放池,让对象自动释放1次
//    [student autorelease];
//    NSLog(@"retain count = %lu", [student retainCount]); // 3
//    [student autorelease];
//    NSLog(@"retain count = %lu", [student retainCount]); // 3
//    [student autorelease];
//    NSLog(@"retain count = %lu", [student retainCount]); // 3
    
//    Student *student = [[[Student alloc] init] autorelease]; // 1
//    Teacher *teacher = [[Teacher alloc] init];
//    [teacher setStudent:student]; // 2
    // 自动释放池销毁的时候，会将加入池中的对象全部release一次
//    [pool release];
//    NSLog(@"%lu", [student retainCount]);
    
    
    // Cocoa内存管理规则：
    // 1.使用alloc、new（alloc + init）、copy、mutableCopy生成的对象需要手动释放，默认retainCount为1，这些对象称为：堆上的拥有对象
    // 2.使用以上4中方法以外的方法（便利初始化）生成的对象，默认retainCount为1，并且设置为自动释放，这些对象可以称作：（栈上的临时对象），局部变量，方法或者函数传参，会在方法或函数作用域结束后自动释放。
    // 3.使用retain方法持有的对象，需要手动release进行释放，并且保持retain以及release次数相同。
    // 内存泄漏
    
    Student *student = [[Student alloc] init]; // 1
    NSArray *array = [[NSArray alloc] initWithObjects:student, nil]; // 2
    [student release];
    NSLog(@"%lu", [student retainCount]); // 1
    [array retain];
    NSLog(@"array retaincount = %lu", [array retainCount]);
    NSLog(@"student retaincount = %lu", [student retainCount]);
    
    
    
    
    
    
    return 0;
}




















