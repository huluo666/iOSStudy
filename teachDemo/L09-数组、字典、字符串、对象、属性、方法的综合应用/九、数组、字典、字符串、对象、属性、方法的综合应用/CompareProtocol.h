//
//  CompareProtocol.h
//  九、数组、字典、字符串、对象、属性、方法的综合应用
//
//  Created by 张鹏 on 13-11-6.
//  Copyright (c) 2013年 张鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CompareProtocol <NSObject>

@property (copy, nonatomic) NSString *code;

- (NSComparisonResult)compareCodeAndNumber:(id<CompareProtocol>)object;

@end














