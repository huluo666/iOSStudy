//
//  DDDetailViewController.h
//  「UI」代码块反向传值
//
//  Created by 萧川 on 14-2-24.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

//typedef void (^SendValue)(NSString *str);

#import <UIKit/UIKit.h>

@interface DDDetailViewController : UIViewController

@property (copy, nonatomic) void (^sendValue)(NSString *);

- (id)initWithBlock:(void (^)(NSString *))block;

@end
