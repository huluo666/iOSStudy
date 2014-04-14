//
//  main.m
//  「OC」统计代码行数
//
//  Created by cuan on 14-1-27.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
NSUInteger codeLineCount(NSString *path);

int main(int argc, const char * argv[])
{
//    NSString *path = @"/Users/cuan/Github/rimiedu";
    NSString *path = @"/Users/rimi1/Desktop/「Proj」LighterReader";
    NSLog(@"代码总行数为：%ld", codeLineCount(path));
    return 0;
}

NSUInteger codeLineCount(NSString *path)
{
    // 获取文件管理者
    NSFileManager *fileManger = [NSFileManager defaultManager];
    
    // 标记是否为文件夹
    BOOL isDirectory = NO;
    
    // 标记路径是否存在,是否为文件夹
    BOOL isExist = [fileManger fileExistsAtPath:path isDirectory:&isDirectory];
    
    // 不存在结束方法
    if (!isExist)
    {
        NSLog(@"请设置有效路径");
        return 0;
    }
    
    // 是目录
    if (isDirectory)
    {
        // 获取当前目录下的所有内容
        NSArray *directoryContent = [fileManger contentsOfDirectoryAtPath:path error:nil];
        
        // 记录代码行数
        NSInteger count = 0;
        
        // 遍历数组中的所有子文件(夹)
        for (NSString *fileName in directoryContent)
        {
            // 获取子文件(夹)全路径
            NSString *fullPath = [NSString stringWithFormat:@"%@/%@", path, fileName];
            
            // 累加所有代码行数
            count += codeLineCount(fullPath);
        }
        
        return count;
    }
    else // 是文件
    {
        // 过滤文件
        NSString *extension = [[path pathExtension] lowercaseString]; // 获取文件扩展名
        if (/*![extension isEqualToString:@"h"]
            && */![extension isEqualToString:@"m"]
            && ![extension isEqualToString:@"c"])
        {
            return 0;
        }
        
        // 加载文件内容
        NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        
        // 按每一行切割
        NSArray *array = [content componentsSeparatedByString:@"\n"];
        
        NSInteger count = array.count;
        for (int i = 0; i < array.count; i++)
        {
            // 有效代码行数
            if ([array[i] hasPrefix:@"//"] ||  [array[i] isEqualToString:@""] || [array[i] isEqualToString:@"#"])
            {
                count--;
            }
        }
        
        // 打印每个有效文件的有效行数
//        NSRange range = [path rangeOfString:@"/Users/cuan/Github/rimiedu/"];
//        NSString *filePath = [path stringByReplacingCharactersInRange:range withString:@""];
//        NSLog(@"%@:%ld", filePath, count);
        
        NSLog(@"%@:%ld", path, count);
        
        return count;
    }
}

