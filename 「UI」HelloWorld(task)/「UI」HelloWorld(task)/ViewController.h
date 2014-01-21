//
//  ViewController.h
//  「UI」HelloWorld(task)
//
//  Created by cuan on 14-1-21.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (retain, nonatomic) IBOutlet UILabel *label;
@property (retain, nonatomic) IBOutlet UITextField *textField;
- (IBAction)buttonPressed:(UIButton *)sender;

@end
