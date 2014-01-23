//
//  ViewController.h
//  Caculator
//
//  Created by 张鹏 on 13-12-28.
//  Copyright (c) 2013年 rimi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (retain, nonatomic) IBOutlet UILabel *resultDisplay;

// 清空
- (IBAction)clear:(UIButton *)sender;

// 计算操作
- (IBAction)operationButtonPressed:(UIButton *)sender;
// 操作数处理
- (IBAction)operandProcess:(UIButton *)sender;

// 数字输入
- (IBAction)numberButtonPressed:(UIButton *)sender;

@end
