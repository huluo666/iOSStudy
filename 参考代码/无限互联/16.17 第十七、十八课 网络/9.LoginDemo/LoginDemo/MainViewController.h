//
//  MainViewController.h
//  LoginDemo
//
//  Created by wei.chen on 13-1-15.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
@property (retain, nonatomic) IBOutlet UILabel *loginLabel;

- (IBAction)loginAction:(id)sender;
- (IBAction)photoAction:(id)sender;
- (IBAction)clearAction:(id)sender;
- (IBAction)addActon:(id)sender;
@end
