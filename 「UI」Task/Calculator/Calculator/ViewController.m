//
//  ViewController.m
//  Calculator
//
//  Created by cuan on 14-1-22.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
  
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _result.enabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (IBAction)number:(UIButton *)sender
{
//    NSInteger number = sender.tag - 100;
    NSInteger number = [sender.currentTitle integerValue];
    
    NSInteger preview = [_result.text integerValue];
    NSInteger value = 10 * preview + number;
    _result.text = [NSString stringWithFormat:@"%ld", value];
    
    NSLog(@"%@", _result.text);
}

- (IBAction)operator:(UIButton *)sender
{
    _previewValue = [_result.text integerValue];
    _currentOperator = sender.currentTitle;
    _result.text = @"";
}

- (IBAction)result:(UIButton *)sender
{
    _currentValue = [_result.text integerValue];
    if ([_currentOperator isEqualToString:@"+"])
    {
        _result.text = [NSString stringWithFormat:@"%ld", _previewValue + _currentValue];
    }
    else if ([_currentOperator isEqualToString:@"-"])
    {
        _result.text = [NSString stringWithFormat:@"%ld", _previewValue - _currentValue];
    }
    else if ([_currentOperator isEqualToString:@"*"])
    {
        _result.text = [NSString stringWithFormat:@"%ld", _previewValue * _currentValue];
    }
    else
    {
         _result.text = [NSString stringWithFormat:@"%ld", _previewValue / _currentValue];
    }
}


- (IBAction)clear:(UIButton *)sender
{
    _result.text = @"";
}


- (void)dealloc {
    [_result release];
    [super dealloc];
}
@end
