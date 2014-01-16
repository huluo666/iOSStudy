//
//  Person.h
//  demotext
//
//  Created by 张鹏 on 14-1-10.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>

// 类声明的开始
@interface Person : NSObject {

// @protected // 被保护的：变量仅能被当前类及子类访问
// @public
// @private
    NSString *_name;
    NSInteger _age;
}


// +:类方法：对类直接进行调用
+ (void)classPrint;
- (void)instancePrint;

// -:对象方法，实例方法：对对象调用
- (id)init;
// 自定义初始化方法      中缀符
- (id)initWithName      :(NSString *)name age:(NSInteger)age;
+ (Person *)person;
+ (Person *)personWithName:(NSString *)name age:(NSInteger)age;

- (void)print;

//+ (int)maxWithNumber:(int)number anotherNumber:(int)anotherNumber;
- (int)maxWithNumber:(int)number anotherNumber:(int)anotherNumber;

// 1.方法：传入NSInteger返回一个NSString     1  ->  @"1"
+ (NSString *)convertNSIntegerToString:(NSInteger)integer;
// 2.方法：传入NSString返回一个NSInteger   @"1" ->  1
+ (NSInteger)convertNSStringToInteger:(NSString *)string;


// 访问器方法：setter   getter
// setter
- (void)setName:(NSString *)name;
// getter
- (NSString *)name;

- (void)setAge:(NSInteger)age;
- (NSInteger)age;








@end

























