//
//  DDTableViewCell.m
//  面试职通车
//
//  Created by 萧川 on 14-4-17.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDTableViewCell.h"

@implementation DDTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
//        self.accessoryView = [UIImageView alloc] initWithImage:DDImageWithName(@"<#string#>")];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        CGRect lineBounds = CGRectMake(0,
                                       0,
                                       CGRectGetWidth(self.contentView.bounds) * 0.9,
                                       1);
        
        _grayLineView = [[UIView alloc] init];
        _grayLineView.bounds = lineBounds;
        _grayLineView.center = CGPointMake(CGRectGetMidX(self.contentView.bounds), CGRectGetMidY(lineBounds) - 0.5);
        _grayLineView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_grayLineView];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
