//
//  NewFontCell.m
//  2014.2.14
//
//  Created by 张鹏 on 14-2-14.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "NewFontCell.h"

@implementation NewFontCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        // 配置cell附件显示类型
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        // 添加背景色
        UIView *backgroundView = [[UIView alloc] init];
        backgroundView.backgroundColor = [UIColor yellowColor];
        self.backgroundView = backgroundView;
        [backgroundView release];
        
        // 添加New标识
        UILabel *label = [[UILabel alloc] init];
        // cell默认宽度320，高度44
        label.bounds = CGRectMake(0, 0, 50, CGRectGetHeight(self.contentView.bounds));
        label.center = CGPointMake(CGRectGetMaxX(self.contentView.bounds) - 20 - CGRectGetMidX(label.bounds), CGRectGetMidY(self.contentView.bounds));
        label.text = @"New";
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor grayColor];
        label.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:label];
        [label release];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end











