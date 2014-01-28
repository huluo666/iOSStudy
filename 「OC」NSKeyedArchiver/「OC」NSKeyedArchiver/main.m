//
//  main.m
//  「OC」NSKeyedArchiver
//
//  Created by cuan on 14-1-28.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

#define PATH @"/Users/cuan/Desktop/serialization.plist"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
#pragma mark 归档数据
        
        // 创建字典并存值
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"Lucy", @"name",
                                    @"22", @"age", nil];
    //        [dictionary  writeToFile:PATH atomically:YES];
        
        // 创建数组典并存值
        NSArray *array = [NSArray arrayWithObjects:@"Lucy", @"22", nil];
    //        [array writeToFile:PATH atomically:YES];
        
        // 创建数据容器
        NSMutableData *archiverData = [NSMutableData data];
        // 关联容器与归档管理器
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:archiverData];
        // 通过归档管理器将数据归档
        [archiver encodeObject:array forKey:@"array"];
        [archiver encodeObject:dictionary forKey:@"dictionary"];
        // 完成编码，(这步很重要)
        [archiver finishEncoding];
        // 将归档好的数据写入文件
        [archiverData writeToFile:PATH atomically:YES];
        
        [archiver release];
        
    #pragma mark 读取归档数据
        
        // 创建解档数据容器
        NSData *unarchiverData = [[NSData alloc] initWithContentsOfFile:PATH]; // 关联解档管理器与数据
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:unarchiverData];
        // 通过解档管理器和key解档数据
        NSArray *unArray = [unarchiver decodeObjectForKey:@"array"];
        NSDictionary *unDictionary = [unarchiver decodeObjectForKey:@"dictionary"];
        NSLog(@"%@\n%@", unArray, unDictionary);
        
        [unarchiverData release];
        [unarchiver release];

    #pragma mark 普通对象的归档与解档
        
        Person *father = [[Person alloc] init];
        Person *son = [[Person alloc] init];
        
        father.name = @"Father";
        father.age = 32;
        father.child = son;
        
        // 获取归档数据
        NSData *personData = [NSKeyedArchiver archivedDataWithRootObject:father];
        // 将归档数据写入文件
        [personData writeToFile:PATH atomically:YES];
        // 读出归档数据
        NSData *unPersonDate = [NSData dataWithContentsOfFile:PATH];
        // 解档数据
        Person *unPerson = [NSKeyedUnarchiver unarchiveObjectWithData:unPersonDate];
        NSLog(@"name = %@, age = %ld, child = %@", unPerson.name, unPerson.age, unPerson.child);
        
        [father release];
        [son release];
        
    }
    return 0;
}

