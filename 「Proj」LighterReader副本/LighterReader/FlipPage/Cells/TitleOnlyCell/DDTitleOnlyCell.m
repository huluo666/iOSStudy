//
//  DDTitleOnlyCell.m
//  LighterReader
//
//  Created by 萧川 on 14-4-3.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDTitleOnlyCell.h"

@interface DDTitleOnlyCell ()

@property (strong, nonatomic, readwrite) UILabel *titleLabel;
@property (strong, nonatomic, readwrite) UILabel *reviewLabel;
@property (strong, nonatomic, readwrite) UILabel *hintLabel;

@end

@implementation DDTitleOnlyCell

@synthesize titleLabel = _titleLabel;
@synthesize reviewLabel = _reviewLabel;
@synthesize hintLabel = _hintLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat width = CGRectGetWidth(self.contentView.bounds);
        CGFloat height = CGRectGetHeight(self.contentView.bounds);
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.frame = CGRectMake(5, 10, width - 10, height * 0.5 - 5);
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.font = [UIFont boldSystemFontOfSize:14];
        _titleLabel.numberOfLines = 2;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
        [self.contentView addSubview:_titleLabel];
        
        _reviewLabel = [[UILabel alloc] init];
        _reviewLabel.frame = CGRectMake(5, CGRectGetMaxY(_titleLabel.frame), width - 10, height * 0.3);
        _reviewLabel.font = [UIFont systemFontOfSize:10];
        _reviewLabel.numberOfLines = 2;
        _reviewLabel.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
        [self.contentView addSubview:_reviewLabel];
        
        _hintLabel = [[UILabel alloc] init];
        _hintLabel.frame = CGRectMake(5, CGRectGetMaxY(_reviewLabel.frame) + 2, width - 10, height * 0.1);
        _hintLabel.font = [UIFont systemFontOfSize:8];
        _hintLabel.numberOfLines = 1;
        _hintLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_hintLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
