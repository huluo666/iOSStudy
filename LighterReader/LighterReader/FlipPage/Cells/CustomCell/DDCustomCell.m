//
//  DDCustomCell.m
//  LighterReader
//
//  Created by 萧川 on 14-4-3.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDCustomCell.h"

@implementation DDCustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect screenBounds = [[UIScreen mainScreen] bounds];
        CGFloat rowHeight = 44;
        CGFloat height = CGRectGetHeight(screenBounds);
        if (480 == height) {
            rowHeight = 83.2;
        } else if (568 == height) {
            rowHeight = 84;
        } else if (1024 == height) {
            rowHeight = 80;
        }
        self.contentView.bounds = CGRectMake(0, 0, CGRectGetWidth(screenBounds), rowHeight);
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
