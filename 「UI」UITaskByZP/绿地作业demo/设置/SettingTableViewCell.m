//
//  SettingTableViewCell.m
//  绿地作业demo
//
//  Created by 张鹏 on 14-2-15.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "SettingTableViewCell.h"

@implementation SettingTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.backgroundColor = [UIColor clearColor];
        
        CGRect bounds = self.contentView.bounds;
        
        _titleImageView = [[UIImageView alloc] init];
        _titleImageView.bounds = CGRectMake(0, 0, 30, 30);
        _titleImageView.center = CGPointMake(CGRectGetMinX(bounds) + 10 + CGRectGetMidX(_titleImageView.bounds),
                                             CGRectGetMidY(bounds));
        [self.contentView addSubview:_titleImageView];
        
        _titleDisplay = [[UILabel alloc] init];
        _titleDisplay.bounds = CGRectMake(0, 0, 100, CGRectGetHeight(bounds));
        _titleDisplay.center = CGPointMake(CGRectGetMaxX(_titleImageView.frame) + 10 + CGRectGetMidX(_titleDisplay.bounds),
                                           CGRectGetMidY(bounds));
        _titleDisplay.font = [UIFont systemFontOfSize:15];
        _titleDisplay.textColor = [UIColor colorWithWhite:1.0 alpha:0.8];
        _titleDisplay.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_titleDisplay];
        
        _subTitleDisplay = [[UILabel alloc] init];
        _subTitleDisplay.bounds = CGRectMake(0, 0, 100, CGRectGetHeight(bounds));
        _subTitleDisplay.center = CGPointMake(CGRectGetMaxX(bounds) - 30 - CGRectGetMidX(_subTitleDisplay.bounds),
                                              CGRectGetMidY(bounds));
        _subTitleDisplay.font = [UIFont systemFontOfSize:15];
        _subTitleDisplay.textColor = [UIColor colorWithWhite:1.0 alpha:0.8];
        _subTitleDisplay.textAlignment = NSTextAlignmentRight;
        _subTitleDisplay.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_subTitleDisplay];
        
    }
    return self;
}

- (void)dealloc {
    
    [_titleImageView  release];
    [_titleDisplay    release];
    [_subTitleDisplay release];
    
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
