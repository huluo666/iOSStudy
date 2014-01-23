//
//  ViewController.m
//  Caculator
//
//  Created by 张鹏 on 13-12-28.
//  Copyright (c) 2013年 rimi. All rights reserved.
//

#import "ViewController.h"
#import "CalculatorBrain.h"

#define NUMBER_BUTTON_TAG          10
#define OPERATION_BUTTON_TAG       30
#define CLEAR_BUTTON_TAG           40
#define OPERAND_PROCESS_BUTTON_TAG 50

@interface ViewController () {
    
    CalculatorBrain *_calculatorBrain; // 计算器模型
    BOOL _numberEditing; // 跟踪用户是否输入一个新的操作数
}

- (void)initializeDataSource;
- (void)initializeUserInterface;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)dealloc {
    
    [_resultDisplay   release];
    [_calculatorBrain release];
    
    [super dealloc];
}

#pragma mark - Initialize methods

- (void)initializeDataSource {
    
    _calculatorBrain = [[CalculatorBrain alloc] init];
}

- (void)initializeUserInterface {
    
    [_resultDisplay setText:@"0"];
    _numberEditing = NO;
}

#pragma mark - Button function methods

- (IBAction)clear:(UIButton *)sender {
    
    [_resultDisplay setText:@"0"];
    _numberEditing = NO;
    [_calculatorBrain clear];
}

- (IBAction)operationButtonPressed:(UIButton *)sender {
    
    NSInteger index = sender.tag - OPERATION_BUTTON_TAG;
    
    // 若当前为操作数输入状态，则向计算器推入操作数
    if (_numberEditing) {
        [_calculatorBrain pushOperand:[_resultDisplay.text doubleValue]];
        _numberEditing = NO;
    }
    // 处理运算符逻辑
    NSNumber *result = [_calculatorBrain performOperation:(CalculatorOperationType)index];
    if (result) {
        [_resultDisplay setText:[NSString stringWithFormat:@"%g", [result doubleValue]]];
    }
}

- (IBAction)operandProcess:(UIButton *)sender {
    
    NSInteger index = sender.tag - OPERAND_PROCESS_BUTTON_TAG;
    NSString *numberString = _resultDisplay.text;
    // 取反
    if (index == 0) {
        numberString = [@(-[numberString doubleValue]) stringValue];
        // 此处是为了保证在计算一次以上情况下直接对计算结果进行取反，需要更新已经推入操作数堆栈的数据
        if (!_numberEditing && [_calculatorBrain.operandsStack count] == 1) {
            [_calculatorBrain pushOperand:-[_calculatorBrain popOperand]];
        }
    }
    // 百分制
    else {
        numberString = [@([numberString doubleValue] / 100.f) stringValue];
    }
    [_resultDisplay setText:numberString];
}

- (IBAction)numberButtonPressed:(UIButton *)sender {
    
    // 限制操作数输入长度
    if (_resultDisplay.text.length >= 10) {
        return;
    }
    
    NSInteger number = sender.tag - NUMBER_BUTTON_TAG;
    NSString *numberString = _resultDisplay.text;
    
    // 处理0输入情况
    if (number == 0 && [_resultDisplay.text isEqualToString:@"0"]) {
        return;
    }
    // 处理小数点情况
    if (number == 10) {
        if ([numberString rangeOfString:@"."].location == NSNotFound) {
            [_resultDisplay setText:[numberString stringByAppendingString:@"."]];
            _numberEditing = YES;
        }
        return;
    }
    // 判断是否为操作数编辑状态
    if (_numberEditing) {
        // 操作数编辑状态下处理小数点情况
        [_resultDisplay setText:[numberString stringByAppendingFormat:@"%d", number]];
    }
    else {
        [_resultDisplay setText:[NSString stringWithFormat:@"%d", number]];
        // 进入操作数编辑状态
        _numberEditing = YES;
    }
}

@end
