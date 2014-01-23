//
//  CalculatorBrain.m
//  Caculator
//
//  Created by 张鹏 on 13-12-28.
//  Copyright (c) 2013年 rimi. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain () {
    
    double _lastOperand; // 记录之前的右操作数
}

@end

@implementation CalculatorBrain

- (id)init {
    
    self = [super init];
    if (self) {
        
        _operandsStack = [[NSMutableArray alloc] init];
        _operationType = CalculatorOperationTypeNone;
        _lastOperand   = 0;
        
    }
    return self;
}

- (void)dealloc {
    
    [_operandsStack release];
    
    [super dealloc];
}

#pragma mark - Calculator function methods

- (void)pushOperand:(double)operand {
    
    [_operandsStack addObject:@(operand)];
}

- (double)popOperand {
    
    double operand = [[_operandsStack lastObject] doubleValue];
    if ([_operandsStack count] > 0) {
        [_operandsStack removeLastObject];
    }
    return operand;
}

- (void)clear {
    
    _lastOperand   = 0;
    _operationType = CalculatorOperationTypeNone;
    [_operandsStack removeAllObjects];
}

- (NSNumber *)performOperation:(CalculatorOperationType)operationType {
    
    /* 1.当前操作为空时，进行运算
     * 2.新操作为运算符，但操作数堆栈不满2时，不进行运算
     * 3.记录运算符 
     */
    if (_operationType == CalculatorOperationTypeNone ||
        (operationType != CalculatorOperationTypeEqual && [_operandsStack count] < 2)) {
        
        if (operationType != CalculatorOperationTypeEqual) {
            _operationType = operationType;
        }
        return nil;
    }
    
    double result       = 0;
    double leftOperand  = 0;
    double rightOperand = 0;
    
    // 判断当前运算类型，是用上一个操作数迭代运算，还是用新操作数运算
    if ([_operandsStack count] < 2) {
        rightOperand = _lastOperand;
        leftOperand  = [self popOperand];
    }
    else {
        rightOperand = [self popOperand];
        leftOperand  = [self popOperand];
    }
    
    // 执行运算
    switch (_operationType) {
            
            // 加
        case CalculatorOperationTypePlus: {
            result = leftOperand + rightOperand;
        }
            break;
            
            // 减
        case CalculatorOperationTypeMinus: {
            result = leftOperand - rightOperand;
        }
            break;
            
            // 乘
        case CalculatorOperationTypeMultiple: {
            result = leftOperand * rightOperand;
        }
            break;
            
            // 除
        case CalculatorOperationTypeDivide: {
            if (rightOperand != 0) {
                result = leftOperand / rightOperand;
            }
        }
            break;
            
        default: break;
    }
    
    // 更新操作数及运算类型
    if (operationType != CalculatorOperationTypeEqual) {
        _operationType = operationType;
    }
    _lastOperand = rightOperand;
    // 将当前结果推入操作数堆栈以便后续操作使用
    [self pushOperand:result];
    
    return @(result);
}

@end
