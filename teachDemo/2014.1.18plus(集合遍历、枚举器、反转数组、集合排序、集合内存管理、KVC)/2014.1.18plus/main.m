//
//  main.m
//  2014.1.18plus
//
//  Created by 张鹏 on 14-1-18.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Teacher.h"
#import "Student.h"

int main(int argc, const char * argv[])
{
    // 1.简单回顾：
    //   类：人、学生、妹纸， 抽象的集合、群体（结构）
    //   对象：student qiu是对象、班长，对象是类的具体表现
    //   特性、存取方法：setter、getter需要在外面访问类中的成员变量的时候
    //   特性：声明成员变量及setter和getter方法
    //        协议 中可以声明特性，要求遵守协议的类实现特性
    //        类别 中声明特性不会声明成员变量，@dynamic动态来合成setter和getter， 手动编写
    //        延展 中可以声明似有特性
    
    // 集合：数组NSArray，字典NSDictionary，以及其变体
    //      只能存储对象，不能存储nil，nil作为结束符存在
    //   数组：有序的，通过索引取值
    //   字典：散列表，通过键值对存取数据
    //   NSNull：是对象，表示空，可以作为集合的占位符
    
    /*
     NSNull:表示为空的对象
     null:表示为空的其它数据类型
     NO:假
     Nil:表示为空的类，编译器会生成类对象
     nil:表示为空的对象
     \0:
     0:
     faulse:
     @"":
     */
//    NSArray *array = [NSArray arrayWithObjects:[NSNull null], [NSNull null], nil];
//    NSLog(@"%@", array);
    
    // 特性属性：
    /*
     assign:简单复杂数据类型、避免循环引用、SEL
     retain:对象持有
     copy:NSString、不可变性、block
     readwrite:默认
     readonly:只合成getter
     atomic:默认，保证原子性线程安全
     nonatomic:
     strong:
     weak:
     __unsafe_unretained:
     getter = 
     setter =
     */
    
    // 初始化：自定义初始化alloc ＋ init、便利初始化（autorelease）
    
    
    // 集合遍历：
    // 数组遍历：
    // for循环：可以拿到下标、跳跃遍历，遍历很灵活
    // for in（快速枚举）：简单高效
    
    // 简单好用，大数据时没有快速枚举高效
//    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        NSLog(@"object = %@ index = %lu", obj, idx);
////        if (idx == 50) {
////            *stop = YES;
////        }
//    }];
    
    // 枚举器
//    NSEnumerator *enumerator = [array objectEnumerator];
//    id object = nil;
//    while (object = [enumerator nextObject]) {
//        NSLog(@"%@", object);
//    }
    
    // 获取逆向数组
//    NSArray *reveredArray = [[array reverseObjectEnumerator] allObjects];
//    NSLog(@"%@", reveredArray);
    
    // 1-100字符串的数组，过滤50以下的元素
    // 数组过滤：在集合遍历的过程中不能修改数组，使用临时集合容纳待过滤元素，遍历结束时统一删除
    
//    NSMutableArray *array = [NSMutableArray array];
//    for (int i = 0; i < 100; i++) {
//        [array addObject:[NSString stringWithFormat:@"%d", i + 1]];
//    }
//    
//    NSMutableArray *removeArray = [NSMutableArray array];
//    for (NSString *string in array) {
//        if ([string integerValue] < 50) {
//            [removeArray addObject:string];
//        }
//    }
//    [array removeObjectsInArray:removeArray];
//    NSLog(@"%@", array);
    
    // 集合排序：
    
//    Teacher *teacher = [[Teacher alloc] initWithName:@"teacher" age:40];
//    Student *student1 = [[Student alloc] initWithName:@"student1" age:24];
//    Student *student2 = [[Student alloc] initWithName:@"student2" age:50];
//    
//    NSArray *array = @[teacher, student2, student1];
//    NSArray *sortedArray = [array sortedArrayUsingSelector:@selector(compareAge:)];
//    NSLog(@"%@", sortedArray);
    
    // 集合内存管理：
    // 加入集合：集合会持有对象一次
    // 移除集合：集合会release对象一次
    // 集合销毁：所有对象被release一次
    // 集合被持有：集合中对象不会被再次持有，retaincount不变
    
    
    //
//    Teacher *teacher = [[Teacher alloc] initWithName:@"teacher" age:40];
//    Student *student1 = [[Student alloc] initWithName:@"student1" age:24];
//    Student *student2 = [[Student alloc] initWithName:@"student2" age:50];
//    
//    NSInteger sum = 0;
//    NSArray *array = @[teacher, student2, student1, @"10", @10];
//    for (id object in array) {
//        if ([object conformsToProtocol:@protocol(CompareProtocol)] &&
//            [object respondsToSelector:@selector(age)]) {
//            sum += [(id<CompareProtocol>)object age];
//        }
//        else if ([object isKindOfClass:[NSString class]]) {
//            sum += [(NSString *)object integerValue];
//        }
//        else {
//            sum += [(NSNumber *)object integerValue];
//        }
//        NSLog(@"sum = %ld", sum);
//    }
//    NSLog(@"sum = %ld", sum);
//    
//    [teacher release];
//    [student1 release];
//    [student2 release];
    
    // isKindOfClass:满足当前类及其子类
    // isMemberOfClass:满足当前类
    
    
    // 功能优化：
    // 内存优化：Analyze、dealloc
    // 调试：断点调试、暴力调试、description
    // 暴力调试：强制输出对象或数据信息，NSLog
    
    
    // KVC  &  block
    
    // KVC:Key value coding
    
    Student *student = [[Student alloc] initWithName:@"student" age:24];
    Teacher *teacher = [[Teacher alloc] initWithName:@"teacher" age:40 student:student];
//    NSLog(@"%@", teacher);
    // key:name  -> 特性@property name -> 成员变量 name/_name
    // 添加、报错、什么不做、崩溃
    // 不足：没有检查机制
//    [teacher setValue:@"理查德" forKey:@"name"];
//    [teacher valueForKey:@"name"];
    
    [teacher setValue:@"student qiu" forKeyPath:@"student.name"];
    [teacher valueForKeyPath:@"student.name"];
    NSLog(@"%@", student);
    
//    NSLog(@"%@", teacher);
    
    return 0;
}



















