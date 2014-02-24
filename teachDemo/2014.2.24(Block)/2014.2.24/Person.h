//
//  Person.h
//  2014.2.24
//
//  Created by 张鹏 on 14-2-24.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef int CustomInt;
// 为block取别名
typedef NSInteger (^ProcessBlock)(NSInteger a, NSInteger b);

@interface Person : NSObject {
    
    // 声明block类型成员变量
    void (^_completionHandler)(void);
}
// 声明block类型特性
@property (copy, nonatomic) void (^completionHandler)(void);

+ (void)excuteBlock:(void (^)(void))block;
+ (NSInteger)processNumber1:(NSInteger)number1
                    number2:(NSInteger)number2
                  withBlock:(ProcessBlock)block;
+ (NSArray *)filteredArray:(NSArray *)array
                usingBlock:(BOOL (^)(id obj))block;

@end



















