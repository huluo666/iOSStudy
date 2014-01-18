//
//  Student.h
//  九、数组、字典、字符串、对象、属性、方法的综合应用
//
//  Created by 张鹏 on 13-11-6.
//  Copyright (c) 2013年 张鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CompareProtocol.h"

#pragma mark - 构建一个Student类，增加name，age，code属性，并完成其description方法和dealloc方法

@interface Student : NSObject <CompareProtocol> {
    
    NSString *_name;
    NSString *_code;
    NSInteger _age;
}

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *code;
@property (assign, nonatomic) NSInteger age;

- (instancetype)initWithName:(NSString *)name age:(NSInteger)age code:(NSString *)code;

- (NSComparisonResult)compareCode:(Student *)object;

@end









