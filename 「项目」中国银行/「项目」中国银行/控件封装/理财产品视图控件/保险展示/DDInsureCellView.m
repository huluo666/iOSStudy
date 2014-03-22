//
//  DDInsureCellView.m
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-18.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDInsureCellView.h"

@implementation DDInsureCellView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _categoryNameLabel = [self label];
        _categoryNameLabel.center = CGPointMake(CGRectGetMidX(self.bounds), 30);
        [self.contentView addSubview:_categoryNameLabel];
        
        _characteristicLabel = [self label];
        _characteristicLabel.center = CGPointMake(CGRectGetMidX(self.bounds),
                                                     CGRectGetMaxY(_categoryNameLabel.frame) +
                                                  CGRectGetMidY(_characteristicLabel.bounds));
        [self.contentView addSubview:_characteristicLabel];
        
        _companyLabel = [self label];
        _companyLabel.center = CGPointMake(CGRectGetMidX(self.bounds),
                                              CGRectGetMaxY(_characteristicLabel.frame) +
                                           CGRectGetMidY(_companyLabel.bounds));
        [self.contentView addSubview:_companyLabel];
        
        _crowdAgeLabel = [self label];
        _crowdAgeLabel.center = CGPointMake(CGRectGetMidX(self.bounds),
                                            CGRectGetMaxY(_companyLabel.frame) +
                                            CGRectGetMidY(_crowdAgeLabel.bounds));
        [self.contentView addSubview:_crowdAgeLabel];
        
        _timesLabel = [self label];
        _timesLabel.center = CGPointMake(CGRectGetMidX(self.bounds),
                                            CGRectGetMaxY(_crowdAgeLabel.frame) +
                                         CGRectGetMidY(_timesLabel.bounds));
        [self.contentView addSubview:_timesLabel];
    }
    return self;
}

- (void)dealloc
{
    _categoryNameLabel = nil;
    _characteristicLabel = nil;
    _companyLabel = nil;
    _crowdAgeLabel = nil;
    _timesLabel = nil;
    [super dealloc];
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
