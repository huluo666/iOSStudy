//
//  main.m
//  2014.1.15
//
//  Created by 张鹏 on 14-1-15.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"

int main(int argc, const char * argv[])
{
    // HelloWorld!
//    NSString *string = @"He,l,lo,W,or,ld,!";
//    NSArray *charaters = [string componentsSeparatedByString:@","];
////    NSLog(@"%@", charaters);
//    NSString *resultString = [charaters componentsJoinedByString:@""];
//    NSLog(@"%@", resultString);
    
    
//    NSString *string = @"08go17o55d";
//    NSMutableString *filteredString = [NSMutableString string];
//    for (int i = 0; i < [string length]; i++) {
//        char charater = [string characterAtIndex:i];
//        if (!(charater >= '0' && charater <= '9')) {
//            [filteredString appendString:[NSString stringWithFormat:@"%c", charater]];
//        }
//    }
//    NSLog(@"%@", [filteredString uppercaseString]);
    
//    NSString *string = @"08go17o55d";
//    // 字符集
//    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"1234567890"];
//    NSString *filteredString = [[string componentsSeparatedByCharactersInSet:set] componentsJoinedByString:@""];
//    NSLog(@"%@", [filteredString uppercaseString]);
    
#pragma mark - 特性（属性）
    
    Student *student = [[Student alloc]
                        initWithName:@"richade"
                        age:40
                        code:@"10"];
    
    Student *anotherStudent = [[Student alloc]
                               initWithName:@"james"
                               age:44
                               code:@"11"];
    
//    NSLog(@"%@", student);
//    
//    // setter             getter
//    student.name = anotherStudent.name;
//    NSLog(@"%@", student.name); // getter
//    [student.name stringByAppendingString:@"-二世"]; // getter
    
    // setter：出现在"="运算符左边
    // getter：出现在"="运算符右边，方法、函数内部
    
//    NSLog(@"%@", student);
//    NSLog(@"%@", anotherStudent);
    
    
    // 对于结构体的特性，只能整体赋值（setter方法），而不能使用连续点语法为结构体的成员变量单一赋值
    // 可以使用连点访问结构体的成员变量
//    student.location.x = 10;
//    student.location.y = 10;
//    
//    NSLog(@"x = %.1f  y = %.1f", student.location.x, student.location.y);
    
    [student release];
    [anotherStudent release];
    
    // NSObject *
    // 父类的指针，变量可以引用子类，对象实质还是子类对象
//    NSString *string = [NSMutableString stringWithFormat:@"123"];
//    NSLog(@"%@", string);
    
    // 特性的属性总结：
    // assign:直接赋值，简单、复杂数据类型、SEL（@selector()） 默认属性
    //        避免循环引用（无法释放对象）－－delegate：委托、代理设计模式
    // retain:引用计数值＋1，拥有持有对象，适用对象类型
    // copy:适用于对象，复制，NSString
    // readonly:只生成getter
    // readwrite：默认，setter、getter
    // nonatomic：非原子性
    // atomic：默认，原子性
    // strong：ARC、强引用，对象类型
    // weak：ARC、弱引用，对象类型
    // __unsafe_unretained：类似于assign
    // getter = ：规定getter方法的名称
    
    
    
    
    
    return 0;
}



















