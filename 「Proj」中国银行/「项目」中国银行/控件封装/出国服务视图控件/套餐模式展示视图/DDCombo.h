//
//  DDCombo.h
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-10.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDCombo : UIView

@property (nonatomic, retain, readonly) UILabel *titleLabel;
@property (copy, nonatomic) void(^showDetail)(void);

@end
