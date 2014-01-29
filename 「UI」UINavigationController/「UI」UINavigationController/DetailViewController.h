//
//  DetailViewController.h
//  「UI」UINavigationController
//
//  Created by cuan on 14-1-29.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <UIKit/UIKit.h>

// 写一个用于反向传值的协议
@protocol SendValue <NSObject>

- (void)sendButtonTitle:(NSString *)title;

@end

@interface DetailViewController : UIViewController

@property (assign, nonatomic) id<SendValue> delegate; // 用于反向传值
@property (copy, nonatomic) NSString *currentTitle;   // 用于正向传值

@end
