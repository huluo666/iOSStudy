//
//  main.m
//  2014.1.17plus
//
//  Created by 张鹏 on 14-1-17.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+NumberCompare.h"
#import "Person+Compare.h"
#import "CustomProtocol.h"

#import "Student.h"
#import "Teacher.h"

int main(int argc, const char * argv[])
{
    // 类别、类扩展（延展）、协议、设计模式（委托、通知、单例）
    
    // 类别：为   现有类   添加新的   方法
    // 现有类：
    // 1.系统预定义类：NSString、NSObject、NSArray、NS....
         // 不可以继承，原因：类簇前台的表现
    // 2.用户自定义：Person、Student、Teacher
    
    // 要点：
    // 1.只要保证类别名称唯一，可以为一个类添加任意多个类别
    // 2.当类别中出现与类中方法重名的情况，类别方法具有更高的优先级（方法重写）
    // 3.类别无法添加成员变量，但是可以声明特性（@property），必须是用@dynamic
    
    
    // 类扩展（延展）：匿名类别
    // 声明定义一个类的私有接口
    // 定义方法、成员变量、特性property
    // 在当前类的.m文件（实现文件）中定义，在当前类的实现中实现
    
    
    // 协议（protocol）:命名的方法列表
    // 协议包含方法的声明，而没有实现部分，协议方法的实现在遵守协议的类的实现中进行实现
    
//    Person *person = [[Person alloc] init];
//    person.name = @"理查德";
//    person.age = 40;
//    person.code = @"510104198808100012";
//    
//    if ([person conformsToProtocol:@protocol(CustomProtocol)] && [person respondsToSelector:@selector(processBirthday)]) {
//        [person processBirthday];
//    }
//
//    NSLog(@"person birthday = %@", [person birthday]);
    
    // 设计模式：委托、通知
    
//    Teacher *teacher = [[Teacher alloc] initWithName:@"理查德"];
//    Student *student1 = [[Student alloc] initWithName:@"student 1"];
//    student1.delegate = teacher;
//    Student *student2 = [[Student alloc] initWithName:@"student 2"];
//    student2.delegate = teacher;
//    [teacher askQuestion:@"what is your sex?"];
    
    
    // 单例：对象，与程序生命周期相同，程序运行期间只能实例化一个单例对象，每次访问同一个对象
    // 系统单例：NSUserDefault、NSNotificationCenter
    [NSUserDefaults standardUserDefaults];
    [NSNotificationCenter defaultCenter];
    
    
    
    return 0;
}















