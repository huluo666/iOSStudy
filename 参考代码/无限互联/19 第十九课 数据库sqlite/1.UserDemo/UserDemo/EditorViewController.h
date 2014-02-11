//
//  EditorViewController.h
//  UserDemo
//
//  Created by wei.chen on 13-2-27.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditorViewController : UIViewController

@property (retain, nonatomic) IBOutlet UITextField *nameField;
@property (retain, nonatomic) IBOutlet UITextField *passField;
@property (retain, nonatomic) IBOutlet UITextField *ageField;
- (IBAction)submitAction:(id)sender;
@end
