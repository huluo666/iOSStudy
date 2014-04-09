//
//  DDListCell.m
//  LighterReader
//
//  Created by 萧川 on 14-4-3.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDListCell.h"

@interface DDListCell ()

@property (strong, nonatomic, readwrite) UILabel *titleLabel;
@property (strong, nonatomic, readwrite) UILabel *reviewLabel;
@property (strong, nonatomic, readwrite) UILabel *hintLabel;
@property (strong, nonatomic, readwrite) UIImageView *leftImageView;

@end

@implementation DDListCell

@synthesize titleLabel = _titleLabel;
@synthesize reviewLabel = _reviewLabel;
@synthesize hintLabel = _hintLabel;
@synthesize leftImageView = _leftImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat height = CGRectGetHeight(self.contentView.bounds);
        
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.bounds = CGRectMake(0, 0, height * 0.9, height * 0.9);
        _leftImageView.center = CGPointMake(height / 2, height / 2);
        [self.contentView addSubview:_leftImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:
                       CGRectMake(CGRectGetMaxX(_leftImageView.frame),
                                    0,
                                    CGRectGetWidth(self.contentView.bounds) -
                                    CGRectGetWidth(_leftImageView.bounds) - 10,
                                    height * 0.5)];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.font = [UIFont boldSystemFontOfSize:14];
        _titleLabel.numberOfLines = 2;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
        [self.contentView addSubview:_titleLabel];

        _reviewLabel = [[UILabel alloc] initWithFrame:
                            CGRectMake(CGRectGetWidth(_leftImageView.bounds) + 5,
                                       CGRectGetMaxY(_titleLabel.frame) - 5,
                                       CGRectGetWidth(_titleLabel.bounds),
                                       height * 0.35 - 4)];
        _reviewLabel.font = [UIFont systemFontOfSize:10];
        _reviewLabel.numberOfLines = 2;
        _reviewLabel.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
        [self.contentView addSubview:_reviewLabel];
        
        _hintLabel = [[UILabel alloc] initWithFrame:
                          CGRectMake(CGRectGetWidth(_leftImageView.bounds) + 5,
                                     CGRectGetMaxY(_reviewLabel.frame) + 2,
                                     CGRectGetWidth(_reviewLabel.bounds),
                                     height * 0.1)];
        _hintLabel.font = [UIFont systemFontOfSize:8];
        _hintLabel.numberOfLines = 1;
        _hintLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_hintLabel];
    }
    return self;
}

@end
