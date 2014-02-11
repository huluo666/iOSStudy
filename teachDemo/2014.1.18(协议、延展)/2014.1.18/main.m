//
//  main.m
//  2014.1.18
//
//  Created by 张鹏 on 14-1-18.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Person+Compare.h"

int main(int argc, const char * argv[])
{
    // 1.声明一个协议，age、code必选特性，一个uppercaseName方法
    // 2.让Person类遵守并实现协议方法；(uppercaseName姓名转大写)
    // 3.使用类别为Person类添加一个排序方法，按照age及code排序
    
    
    Person *person1 = [[Person alloc] initWithName:@"person1"
                                               age:@"24"
                                              code:@"10"];
    Person *person2 = [[Person alloc] initWithName:@"person2"
                                               age:@"26"
                                              code:@"12"];
    Person *person3 = [[Person alloc] initWithName:@"person3"
                                               age:@"26"
                                              code:@"11"];
    
    [person1 uppercaseName];
//    NSLog(@"%@", person1);
    
    
    NSMutableArray *persons = [NSMutableArray array];
    [persons addObject:person3];
    [persons addObject:person2];
    [persons addObject:person1];
    NSLog(@"%@", persons);
    [persons sortUsingSelector:@selector(compareAgeAndCode:)];
    NSLog(@"%@", persons);
    
    
    return 0;
}















