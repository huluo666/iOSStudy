//
//  DDListCell.m
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-21.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDListCell.h"

@implementation DDListCell

- (void)dealloc
{
    [_nameLabel release];
    [_orderNumberLabel release];
    [_buttonTapAction release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
        buttonStyle:(DDButtonSyle)buttonStyle
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        _nameLabel = [[UILabel alloc] init];
        _nameLabel.bounds = CGRectMake(0, 0, 120, 50);
        _nameLabel.center = CGPointMake(CGRectGetMidX(_nameLabel.bounds),
                                        CGRectGetMidY(self.contentView.bounds));
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_nameLabel];
        
        _orderNumberLabel = [[UILabel alloc] init];
        _orderNumberLabel.bounds = CGRectMake(0, 0, 500, 50);
        _orderNumberLabel.center = CGPointMake(CGRectGetMidX(_orderNumberLabel.bounds) +
                                               CGRectGetMaxX(_nameLabel.frame),
                                        CGRectGetMidY(self.contentView.bounds));
        _orderNumberLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_orderNumberLabel];
        
        UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        buyButton.bounds = CGRectMake(0, 0, 159, 50);
        buyButton.center = CGPointMake(CGRectGetMidX(buyButton.bounds) +
                                       CGRectGetMaxX(_orderNumberLabel.frame),
                                       CGRectGetMidY(self.contentView.bounds));
        if (buttonStyle == DDSubmit) {
            [buyButton setBackgroundImage:[UIImage imageNamed:@"提交办理"]
                                 forState:UIControlStateNormal];
        } else {
            [buyButton setBackgroundImage:[UIImage imageNamed:@"查询详情"]
                                 forState:UIControlStateNormal];
        }

        [buyButton addTarget:self
                      action:@selector(buyButtonPressed)
            forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:buyButton];

    }
    return self;
}

- (void)buyButtonPressed
{
    if (_buttonTapAction) {
        _buttonTapAction();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
