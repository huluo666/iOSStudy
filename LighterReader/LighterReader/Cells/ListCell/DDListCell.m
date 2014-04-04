//
//  DDListCell.m
//  LighterReader
//
//  Created by 萧川 on 14-4-3.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDListCell.h"

@interface DDListCell ()

@property (nonatomic, strong) UIImageView *leftImageView;

@end


@implementation DDListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat height = CGRectGetHeight(self.contentView.bounds);
        
        self.leftImageView = [[UIImageView alloc] init];
        self.leftImageView.bounds = CGRectMake(0, 0, height * 0.9, height * 0.9);
        self.leftImageView.center = CGPointMake(height / 2, height / 2);
        [self.contentView addSubview:self.leftImageView];
        self.leftImageView.backgroundColor = [UIColor redColor];
        
        
        self.titleLabel = [[UILabel alloc] initWithFrame:
                           CGRectMake(CGRectGetMaxX(self.leftImageView.frame),
                                      0,
                                      CGRectGetWidth(self.contentView.bounds) -
                                      CGRectGetWidth(self.leftImageView.bounds) - 10,
                                      height * 0.5)];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
        [self.contentView addSubview:self.titleLabel];
//        self.titleLabel.backgroundColor = [UIColor yellowColor];

        self.reviewLabel = [[UILabel alloc] initWithFrame:
                            CGRectMake(CGRectGetWidth(self.leftImageView.bounds) + 5,
                                       CGRectGetMaxY(self.titleLabel.frame) - 5,
                                       CGRectGetWidth(self.titleLabel.bounds),
                                       height * 0.35 - 4)];
        self.reviewLabel.font = [UIFont systemFontOfSize:10];
        self.reviewLabel.numberOfLines = 2;
        self.reviewLabel.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
        [self.contentView addSubview:self.reviewLabel];
//        self.reviewLabel.backgroundColor = [UIColor greenColor];
        
        self.hintLabel = [[UILabel alloc] initWithFrame:
                          CGRectMake(CGRectGetWidth(self.leftImageView.bounds) + 5,
                                     CGRectGetMaxY(self.reviewLabel.frame) + 2,
                                     CGRectGetWidth(self.reviewLabel.bounds),
                                     height * 0.1)];
        self.hintLabel.font = [UIFont systemFontOfSize:8];
        self.hintLabel.numberOfLines = 1;
        self.hintLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.hintLabel];
//        self.hintLabel.backgroundColor = [UIColor cyanColor];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setLeftImage:(UIImage *)leftImage {
    
    [super setLeftImage:leftImage];
    self.imageView.image = self.leftImage;
}

@end
