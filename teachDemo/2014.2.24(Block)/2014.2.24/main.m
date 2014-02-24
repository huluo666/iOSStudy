//
//  main.m
//  2014.2.24
//
//  Created by 张鹏 on 14-2-24.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

void fun(void);
int maxNumber(int number1, int number2);

int number = 10;

int main(int argc, const char * argv[])
{
    // block：代码块、匿名函数、闭包
    // 函数指针：指向函数的指针变量
    // 指针函数：返回值为指针类型的函数
    
//    void (*function)(void); // 函数指针
//    void (^block)(void); // block变量（指针）
//    
//    // 赋值
//    function = fun; // 将函数地址赋值给函数指针
//    block = ^{
//        NSLog(@"Hello World!");
//    };
    
    // 可以在声明变量的时候赋值
//    void (*function)(void) = fun;
//    void (^block)(void) = ^{
//        NSLog(@"Hello World!");
//    };
    
    // 执行
    // block可以直接被执行
//    function();
//    block();
    
    // 求两个数的最大值，使用函数指针和block两种方式
    // 函数指针
//    int (*max)(int a, int b) = maxNumber;
//    NSLog(@"max = %d", max(10, 5));
//    // block
//    int (^maxBlock)(int a, int b) = ^int (int number1, int number2) {
//        return number1 > number2 ? number1 : number2;
//    };
//    NSLog(@"max = %d", maxBlock(10, 5));
    
    // block作为传入参数
//    [Person excuteBlock:^{
//        NSLog(@"student qiu!");
//    }];
//    NSInteger result = [Person processNumber1:10
//                                      number2:5
//                                    withBlock:^NSInteger(NSInteger a, NSInteger b) {
//        NSInteger result = a - b;
//        return result;
//    }];
//    NSLog(@"result = %ld", result);
    
    // 过滤数组，100空间大小的数组，包含1-100的字符串，过滤小于50的，使用block
//    NSMutableArray *array = [NSMutableArray arrayWithCapacity:100];
//    for (int i = 0; i < 100; i++) {
//        [array addObject:[NSString stringWithFormat:@"%d", arc4random() % 100 + 1]];
//    }
//    NSArray *results = [Person filteredArray:array usingBlock:^BOOL(id obj) {
//        // 判断是否该被过滤逻辑
//        BOOL shouldFilter = NO;
//        if ([obj integerValue] >= 50) {
//            shouldFilter = YES;
//        }
//        return shouldFilter;
//    }];
//    NSLog(@"%@", results);
    
    
    // block对变量的访问
    // 局部变量（block外部变量）
    // 简单、复杂数据类型：复制、只读
    // 全局、静态变量
    // 全局、静态变量：直接访问，不复制或持有，可读写
    // 成员变量/实例变量：直接访问，简单、复杂数据类型不进行复制处理，对象类型进行持有，可读写
    // __block：告诉编译器，block中直接访问这个变量，而不是复制或者持有，可读写，不是只读的
    
//    __block int a = 10;
//    void (^block)(void) = ^{
//        NSLog(@"a = %d", a);
//    };
//    a++;
//    NSLog(@"a = %d", a);
//    block();
    
    // 对象类型：持有retain、只读（地址无法被更改）
//    __block NSMutableString *string = [NSMutableString stringWithString:@"Student Qiu!"];
//    void (^block)(void) = ^{
//        string = [NSMutableString stringWithString:@"Hello World!"];
//        NSLog(@"%@", string);
//    };
//    block();

    static NSInteger newNumber = 10;
    void (^block)(void) = ^{
        NSLog(@"number = %ld", ++newNumber);
    };
    block();
    
    // block内存管理：block对代码片段进行了对象化封装，需要进行内存管理
    // 持有：copy
    // 释放：release
    // @property中也是使用copy
    
    
    
    
    return 0;
}

void fun(void) {
    
    printf("Hello World!\n");
}

int maxNumber(int number1, int number2) {
    
    return number1 > number2 ? number1 : number2;
}





















