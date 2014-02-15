//
//  CustomCell.m
//  「UI」表视图(day08)
//
//  Created by 萧川 on 14-2-14.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *label = [[UILabel alloc] init];
        label.bounds = CGRectMake(0, 0, 32, TABLE_VIEW_ROW_HEIGHT);
        label.center = CGPointMake(CGRectGetMaxX(self.contentView.frame) - label.frame.size.width/2 - 25,
                                   label.frame.size.height/2);
        label.font = [UIFont systemFontOfSize:15.0f];
        label.textColor = [UIColor grayColor];
        label.text = @"New";
        [self.contentView addSubview:label];
        [label release];
        
        UIView *backView = [[UIView alloc] init];
        backView.backgroundColor = [UIColor colorWithRed:1.000 green:0.910 blue:0.348 alpha:1.000];
        self.backgroundView = backView;
        [backView release];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
