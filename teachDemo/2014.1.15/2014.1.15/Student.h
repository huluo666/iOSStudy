//
//  Student.h
//  2014.1.15
//
//  Created by 张鹏 on 14-1-15.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject {
    
    NSString *_name;
    NSInteger _age;
    
    NSString *_code;
    
    double score[4];
    
    NSPoint _location;
}

// 特性帮我们声明了成员变量
// 特性实现了setter及getter
// 特性的关键字        特性的属性            特性的类型       特性名称
@property       (assign, nonatomic)       NSInteger       age;
@property (retain, nonatomic) NSString *name;
@property (retain, nonatomic) NSString *code;
@property (assign, nonatomic) NSPoint location;

- (id)initWithName:(NSString *)name
               age:(NSInteger)age
              code:(NSString *)code;

// 特性的局限:只能生成简单的赋值setter及取值getter方法，不支持多参数
- (void)setScore:(double)score atIndex:(NSInteger)index;
- (double)scoreAtIndex:(NSInteger)index;

/*
  1.Student增加code特性，并赋值
  2.计算两个Student年龄差
  3.Student的name转大写
  4.将一个Student的name赋值给另外一个Student，使用特性
 */

// 计算两个Student年龄差
- (NSInteger)agesBetweenStudent:(Student *)student;


@end


















