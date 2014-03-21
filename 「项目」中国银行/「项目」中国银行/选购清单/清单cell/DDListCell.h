//
//  DDListCell.h
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-21.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//
typedef enum {
    DDSubmit,
    DDDetail
} DDButtonSyle;

#import <UIKit/UIKit.h>

@interface DDListCell : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier buttonStyle:(DDButtonSyle)buttonStyle;

@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *orderNumberLabel;
@property (copy, nonatomic) void(^buttonTapAction)(void);

@end
