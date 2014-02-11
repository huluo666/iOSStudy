//
//  ViewController.h
//  Calculator
//
//  Created by cuan on 14-1-22.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (retain, nonatomic) IBOutlet UITextField *result;
@property (assign, nonatomic) NSInteger previewValue;
@property (assign, nonatomic) NSInteger currentValue;
@property (copy, nonatomic) NSString *currentOperator;

@end
