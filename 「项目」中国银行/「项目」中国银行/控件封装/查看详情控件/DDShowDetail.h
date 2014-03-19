//
//  DDShowDetail.h
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-10.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDShowDetail : UIView

@property (retain, nonatomic, readonly) UILabel *titleLabel; // 详情标题
@property (retain, nonatomic, readonly) UIView *contentView; // 内容视图
@property (assign, nonatomic) BOOL buyButtonHidden;

@property (copy, nonatomic) void (^buyAction)(UIButton *sender);

@end
