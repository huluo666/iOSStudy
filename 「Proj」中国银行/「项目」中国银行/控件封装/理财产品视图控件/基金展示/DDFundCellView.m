//
//  DDFundCellView.m
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-18.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDFundCellView.h"

@implementation DDFundCellView

- (void)dealloc
{
    _nameLabel = nil;
    _accumulativeValueLabel = nil;
    _assetValueLabel = nil;
    _stopTimeLabel = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _nameLabel = [self label];
        _nameLabel.center = CGPointMake(CGRectGetMidX(self.bounds), 30);
        [self.contentView addSubview:_nameLabel];
        
        _accumulativeValueLabel = [self label];
        _accumulativeValueLabel.center = CGPointMake(CGRectGetMidX(self.bounds),
                                                     CGRectGetMaxY(_nameLabel.frame) +
                                                     CGRectGetMidY(_accumulativeValueLabel.bounds));
        [self.contentView addSubview:_accumulativeValueLabel];

        _assetValueLabel = [self label];
        _assetValueLabel.center = CGPointMake(CGRectGetMidX(self.bounds),
                                              CGRectGetMaxY(_accumulativeValueLabel.frame) +
                                              CGRectGetMidY(_assetValueLabel.bounds));
        [self.contentView addSubview:_assetValueLabel];

        _stopTimeLabel = [self label];
        _stopTimeLabel.center = CGPointMake(CGRectGetMidX(self.bounds),
                                              CGRectGetMaxY(_assetValueLabel.frame) +
                                            CGRectGetMidY(_stopTimeLabel.bounds));
        [self.contentView addSubview:_stopTimeLabel];
    }
    return self;
}

- (UILabel *)label
{
    UILabel *label = [[[UILabel alloc] init] autorelease];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    label.bounds = CGRectMake(0, 0, CGRectGetWidth(self.bounds) * 0.8, 30);
    return label;
}

@end
