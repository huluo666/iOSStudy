//
//  DDOptional.h
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-10.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDCustomCellView : UIView

@property (retain, nonatomic, readonly) UILabel *titleLabel;
@property (retain, nonatomic, readonly) UIView *contentView;
@property (copy, nonatomic) void(^tapDetailAction)(UIButton *sender);
@property (copy, nonatomic) void(^tapBuyAction)(UIButton *sender);

@end
