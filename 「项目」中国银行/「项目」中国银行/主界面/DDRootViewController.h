//
//  DDRootViewController.h
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-7.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDRootViewController : UIViewController

@property (nonatomic, assign, getter = isLogined) BOOL logined;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *realNameLabel;

@property (nonatomic, retain) NSString *count;      // 购物车计算
@property (nonatomic, retain) UILabel *countLabel;  // 购物车显示标签

// 切换视图
- (void)switchVC:(UIButton *)sender;

@end
