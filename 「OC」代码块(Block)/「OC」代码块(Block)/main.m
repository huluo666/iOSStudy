//
//  main.m
//  「OC」代码块(Block)
//
//  Created by 萧川 on 14-2-24.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>

int max(int a, int b)
{
    return a > b ? a : b;
}

typedef void (^BlockLog)(void);
typedef int (^ProcessNumer)(int, int);
typedef NSArray * (^FilterArray)(NSArray *);

int main(int argc, const char * argv[])
{
    // Block: 代码块、匿名函数、闭包
    /* 函数指针方式实现 */
    int (*maxNumberFunc)(int, int) = max;
    int dd = maxNumberFunc(12, 67);
    NSLog(@"max number is %d", dd);
    /* block方式实现 */
    int (^maxNumber)(int, int) = ^(int a, int b){
        return a > b ? a : b;
    };
    int c = maxNumber(10, 11);
    NSLog(@"max numer is : %d",c);
    /* block类型 */
    BlockLog logNumer = ^{
        NSLog(@"log numer...");
    };
    logNumer();
    
    ProcessNumer sumNumer = ^(int a, int b){
        return a + b;
    };
    int sum = sumNumer(12, 43);
    NSLog(@"sum is %d", sum);
    
    /* 过滤数组 */
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 99; i++) {
        NSString *item = [NSString stringWithFormat:@"%d", arc4random() % 99];
        [array addObject:item];
    }
    NSLog(@"array: %@", array);
    
    FilterArray newArray = ^(NSArray *anArray){
        NSMutableArray *returnArray = [[[NSMutableArray alloc] init] autorelease];
        for (NSString *item in anArray) {
            if ([item integerValue] <= 50) {
                [returnArray addObject:item];
            }
        }

        return returnArray;
    };
    NSLog(@"After Filter: %@", newArray(array));
    
    return 0;
}

/*
// 函数指针
void (*function)(void);
// 指针函数
void *fun(void);
// 代码块
void (^func)(void);
 */
