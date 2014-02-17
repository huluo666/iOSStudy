//
//  ViewController.h
//  UITask
//
//  Created by cuan on 14-1-22.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (nonatomic, retain) UIView *leftView;
@property (nonatomic, retain) UIView *rightView;
@property (nonatomic, assign, getter = isLeftViewShow) BOOL leftViewShow;
@property (nonatomic, retain) UILabel *label;

@end
