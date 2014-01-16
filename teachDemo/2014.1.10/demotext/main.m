//
//  main.m
//  demotext
//
//  Created by 张鹏 on 14-1-10.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"

int max(int a, int b);

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // 常量字符串（对象）       alloc  +  initWith.....
        // 便利初始化方法/ 便利构造
//        NSString *string = [NSString stringWithFormat:@"%@ age = %@", @"student", @"20"];
//        NSLog(@"%@", string);
        
        // 1.方法：传入NSInteger返回一个NSString     1  ->  @"1"
//        NSLog(@"%@", [Person convertNSIntegerToString:1000]);
        
        // 2.方法：传入NSString返回一个NSInteger   @"1" ->  1
//        NSLog(@"%ld", (long)[Person convertNSStringToInteger:@"1000"]);
    
        
        Student *student1 = [[Student alloc] initWithName:@"理查德" age:33 telephone:nil code:nil];
        Student *student2 = [[Student alloc] initWithName:@"理查德 - 二世" age:9 telephone:nil code:nil];
        
        [Student elderStudent:student1 anotherStudent:student2];
        Student *elderStudent = [student1 elderStudent:student2];
        [elderStudent print];
        
        
        
        
        
        
    }
    return 0;
}

int max(int a, int b) {
    
    return a > b ? a : b;
}


















