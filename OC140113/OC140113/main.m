//
//  main.m
//  OC140113
//
//  Created by cuan on 14-1-13.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // insert code here...
        NSLog(@"Hello, World!");
        
    }
    
    // 数组：nil作为数组结束标志
    // 数组只能存对象

    
    
//    NSString *string = [NSString stringWithFormat:@"12345"];
//    NSLog(@"%lu", [string rangeOfString:@"23"].length);
    
    // SEL:方法选择器，@select(method),类似于函数指针，简单数据类型
    
    
    
    NSArray *array       = [NSArray arrayWithObjects:@"10", @"0", @"2", @"5", @"8", @"1", nil];
    NSArray *sortedArray = [array sortedArrayUsingSelector:@selector(compare:)];
    NSLog(@"%@", sortedArray);
    
    array       = [NSArray arrayWithObjects:@"d", @"g", @"a", @"A", @"E", @"l", nil];
    sortedArray = [array sortedArrayUsingSelector:@selector(compare:)];
    NSLog(@"%@", sortedArray);
    
    array       = [NSArray arrayWithObjects:@"8", @"h", @"1", @"d", @"E", @"2", nil];
    sortedArray = [array sortedArrayUsingSelector:@selector(compare:)];
    NSLog(@"%@", sortedArray);
    
    NSMutableArray *mArray = [NSMutableArray arrayWithObjects:@"8", @"h", @"1", @"d", @"E", @"2", nil];
    for (int i=0; i< [mArray count]; i++)
    {
//        NSLog(@"%@", mArray[i]);
        if ([mArray[i] isEqual:@"h"])
        {
            [mArray replaceObjectAtIndex:i withObject:@"D"];
        }
    }
    NSLog(@"----"); 
    
    for (id obj in mArray)
    return 0;
}

