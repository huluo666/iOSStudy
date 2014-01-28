//
//  main.m
//  「OC」NSFileManager
//
//  Created by cuan on 14-1-28.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // 创建一个单例fileManager对象
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        // 显示当前路径下的所有内容
        NSError *error = nil;
        // 浅度遍历
        NSArray *contentArray =  [fileManager contentsOfDirectoryAtPath:@"/Users/cuan" error:&error];
        NSLog(@"%@", contentArray);
        
        // 深度遍历
        contentArray = [fileManager subpathsOfDirectoryAtPath:@"/Users/cuan/Github" error:&error];
        NSLog(@"%@", contentArray);
        
        // 创建目录, YES补全中间目录
        [fileManager createDirectoryAtPath:@"/Users/cuan/Desktop/test" withIntermediateDirectories:YES attributes:nil error:&error];
        
        // 创建文件
        [fileManager createFileAtPath:@"/Users/cuan/Desktop/echo.txt" contents:[@"hello,wolrd" dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
        
        // 文件(夹)的删除
        [fileManager removeItemAtPath:@"/Users/cuan/Desktop/test" error:&error];
        
        // 文件(夹)的拷贝
        [fileManager copyItemAtPath:@"/Users/cuan/Desktop/echo.txt" toPath:@"/Users/cuan/Desktop/echo2.txt" error:&error];
        
        // 文件(夹)的移动
        [fileManager copyItemAtPath:@"/Users/cuan/Desktop/echo.txt" toPath:@"/Users/cuan/Desktop/mv/echo.txt" error:&error];
    }
    return 0;
}

