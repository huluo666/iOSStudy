//
//  CalculatorBrain.h
//  Caculator
//
//  Created by 张鹏 on 13-12-28.
//  Copyright (c) 2013年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    CalculatorOperationTypeEqual,    // 等于
    CalculatorOperationTypePlus,     // 加
    CalculatorOperationTypeMinus,    // 减
    CalculatorOperationTypeMultiple, // 乘
    CalculatorOperationTypeDivide,   // 除
    CalculatorOperationTypeNone      // 无操作
}CalculatorOperationType;

@interface CalculatorBrain : NSObject {
    
    NSMutableArray *_operandsStack; // 操作数堆栈
    CalculatorOperationType _operationType; // 记录当前运算符
}

@property (retain, nonatomic) NSMutableArray *operandsStack;
@property (assign, nonatomic) CalculatorOperationType operationType;

// 推入操作数
- (void)pushOperand:(double)operand;
// 操作数出栈，运算时使用
- (double)popOperand;

// 清空计算器
- (void)clear;

/**
 * @brief: 处理运算符逻辑
 *
 * @param operationType: 新运算符
 *
 * @return: 运算结果，当不进行运算的情况返回nil
 */
- (NSNumber *)performOperation:(CalculatorOperationType)operationType;

@end
