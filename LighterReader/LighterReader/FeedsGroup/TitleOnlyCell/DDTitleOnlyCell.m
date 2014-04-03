//
//  DDTitleOnlyCell.m
//  LighterReader
//
//  Created by 萧川 on 14-4-3.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDTitleOnlyCell.h"

@implementation DDTitleOnlyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat width = CGRectGetWidth(self.contentView.bounds);
        CGFloat height = CGRectGetHeight(self.contentView.bounds);
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.frame = CGRectMake(5, 10, width - 10, height * 0.5 - 5);
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
        [self.contentView addSubview:self.titleLabel];
//        self.titleLabel.backgroundColor = [UIColor yellowColor];
        
        self.reviewLabel = [[UILabel alloc] init];
        self.reviewLabel.frame = CGRectMake(5, CGRectGetMaxY(self.titleLabel.frame), width - 10, height * 0.3);
        self.reviewLabel.font = [UIFont systemFontOfSize:10];
        self.reviewLabel.numberOfLines = 2;
        self.reviewLabel.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
        [self.contentView addSubview:self.reviewLabel];
//        self.reviewLabel.backgroundColor = [UIColor greenColor];
        
        self.hintLabel = [[UILabel alloc] init];
        self.hintLabel.frame = CGRectMake(5, CGRectGetMaxY(self.reviewLabel.frame) + 2, width - 10, height * 0.1);
        self.hintLabel.font = [UIFont systemFontOfSize:8];
        self.hintLabel.numberOfLines = 1;
        self.hintLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.hintLabel];
//        self.hintLabel.backgroundColor = [UIColor cyanColor];
        
//        self.viaLabel = [[UILabel alloc] init];
//        self.viaLabel.frame = CGRectMake(CGRectGetMaxX(self.sizeLabel.frame), CGRectGetMinY(self.sizeLabel.frame), width * 0.1, height * 0.2);
//        self.viaLabel.font = [UIFont systemFontOfSize:8];
//        self.viaLabel.textColor = [UIColor grayColor];
//        [self.contentView addSubview:self.viaLabel];
//        self.viaLabel.backgroundColor = [UIColor orangeColor];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
