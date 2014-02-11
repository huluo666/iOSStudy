//
//  MainViewController.h
//  UIViewAnimation
//
//  Created by wei.chen on 13-1-8.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (retain, nonatomic) IBOutlet UIView *myView;

- (IBAction)starAnimation:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UIView *parentView;
- (IBAction)transitionAction:(id)sender;

@end
