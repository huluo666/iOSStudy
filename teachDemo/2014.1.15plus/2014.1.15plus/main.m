//
//  main.m
//  2014.1.15plus
//
//  Created by 张鹏 on 14-1-15.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{
    // 需要手动管理内存的对象：alloc、new、copy、mutableCopy
    
//    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", nil]; // 1
//    // copy:不可变复制 /  浅复制
//    NSArray *copyArray = [array copy];
//    // array = 1
//    // copyArray = 1
//    NSLog(@"array = %lu", [array retainCount]);
//    NSLog(@"copyArray = %lu", [copyArray retainCount]);
    
    
    // copy:不可变复制，对可变对象复制是深复制，其它时候一律浅复制
    // mutableCopy:可变深复制
    
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", nil];
    NSMutableArray *copyArray = [array mutableCopy];
    // array = 1
    // copyArray = 1
    NSLog(@"array = %lu", [array retainCount]);
    NSLog(@"copyArray = %lu", [copyArray retainCount]);
    
    
//    [copyArray addObject:@"3"];
//    NSLog(@"%@", copyArray);
    
    
    
    return 0;
}
















