//
//  main.m
//  2014.1.16
//
//  Created by 张鹏 on 14-1-16.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Manager.h"

int main(int argc, const char * argv[])
{
    // 类的复合、管理者类、传值
    // 类的复合：当前类中拥有指向其它类的指针或者成员变量
    
    // 1.Student、Teacher：name、age
    // 2.求Student和Teacher的年龄差
    //   (1)Student和Teacher直接计算
    //   (2)创建Manager，持有Student、Teacher，通过Manager计算年龄差
    
//    Teacher *teacher = [[Teacher alloc] init]; // 1
//    teacher.name = @"理查德";
//    teacher.age = 40;
//    
//    Student *student = [[Student alloc] init]; // 1
//    student.name = @"詹姆斯";
//    student.age = 30;
    
//    student.name = teacher.name;
//    student.age = teacher.age;
    
    
    
    
//
//    // 循环引用：两个对象都，无法释放，内存泄漏
//    teacher.student = student; // 2
//    student.teacher = teacher; // 1
//    
////    NSLog(@"teacher elder age = %ld", [teacher agesDifferent]);
////    NSLog(@"student younger age = %ld", [student agesDifferent]);
//    
//    
//    Manager *manager = [[Manager alloc] init];
//    manager.student = student;
//    manager.teacher = teacher;
//    
//    NSLog(@"ages = %ld", [manager agesDifference]);
//
//    
//    [manager release];
//    [teacher release]; // 0 dealloc   student = 1
//    [student release]; // 0
    
    
    // 传值
    // 1.直接传值
    // 2.在某个对象中，进行数据处理后，再传值
//    Teacher *teacher = [[Teacher alloc] init]; // 1
//    teacher.name = @"teacher li";
//    teacher.age  = 40;
//    
//    Student *student = [[Student alloc] init]; // 1
//    student.name = @"student qiu";
//    student.age  = 30;
//    
//    Manager *manager = [[Manager alloc] init];
//    manager.student = student;
//    manager.teacher = teacher;
//    
//    manager.student.name = @"student qiu";
//    manager.teacher.name = @"teacher li";
//    
//    [manager exchangeName];
//    
//    NSLog(@"student name = %@", manager.student.name);
//    NSLog(@"teacher name = %@", manager.teacher.name);
//    
//    [teacher release];
//    [student release];
//    [manager release];
    
    // 3.通过第三方容器，直接获取传值
    // 数据持久化
    
    // NSUserDefaults:轻量的数据存储，数据持久化功能，文件系统支持
    // 数据库：SQLite
    
    // 单例：唯一的、单独的实例（对象）

//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    
//    NSLog(@"name = %@", [userDefaults objectForKey:@"name"]);
//
//    [userDefaults setObject:@"李xx" forKey:@"name"];
//    [userDefaults removeObjectForKey:@"name"];
//    // 同步到文件系统
//    [userDefaults synchronize];
    
    // 通过特性把Student的age传给Teacher
    // 通过NSUserDefaults把Student的age传给Teacher
    
//    Teacher *teacher = [[Teacher alloc] init];
//    teacher.name = @"teacher li";
//    teacher.age  = 40;
//
//    Student *student = [[Student alloc] init];
//    student.name = @"student qiu";
//    student.age  = 30;
//    
//    [student save];
//    
//    Manager *manager = [[Manager alloc] init];
//    manager.student = student;
//    manager.teacher = teacher;
//    
//    [manager exchangeAge];
//    
//    NSLog(@"student age = %ld", student.age);
//    NSLog(@"teacher age = %ld", teacher.age);
    
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    NSLog(@"%@", [userDefaults objectForKey:@"age"]);
//    [userDefaults setObject:@"bbb" forKey:@"age"];
//    [userDefaults synchronize];
//    NSLog(@"%@", [userDefaults objectForKey:@"age"]);
    
    // 属性列表:plist / .plist = property list
    // 属性列表类:Cocoa知道如何将属性列表类写入文件系统，也可以把属性列表文件加载到内存，初始化相应的对象
    // NSString, NSArray, NSDictionary, NSNumber, NSDate, NSData
    // 以及它们的变体，若存在变体
    // 集合属性列表类需要内部的所有对象都是属性列表类，才能写入文件系统
    // 自定义类的对象可以通过转化字典，或归档为NSData来写入文件系统
    
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setObject:@"student qiu" forKey:@"name"];
    [dictionary setObject:@40 forKey:@"age"];
    [dictionary setObject:@"male" forKey:@"sex"];
    [dictionary setObject:@"1988-10-20" forKey:@"birthday"];
    
    NSString *homeDirectory = NSHomeDirectory();
//    [homeDirectory stringByAppendingString:@"/Desktop"];
    NSString *desktopDirectroy = [homeDirectory stringByAppendingPathComponent:@"Desktop"];
    NSString *filePath = [desktopDirectroy stringByAppendingPathComponent:@"Stringfile.txt"];
    BOOL success = [@"Hello World!" writeToFile:filePath
                                     atomically:YES
                                       encoding:NSUTF8StringEncoding
                                          error:nil];
    if (success) {
        NSLog(@"write to file success!");
    }
    else {
        NSLog(@"failed");
    }
    
    // 沙盒机制：
    // 主路径:NSHomeDirectory()（根目录）
    // Documents:存储用户数据
    // Library:存储系统数据，缓存
    // tmp:存储临时文件，当设备重启的时候，tmp清空
    
    return 0;
}
















