//
//  DDCombo.m
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-10.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDCombo.h"

@implementation DDCombo

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 背景图片
        UIImageView *backgroundImageView = [[UIImageView alloc]
                                            initWithImage:kImageWithName(@"prepare1_01.png")];
        backgroundImageView.bounds = CGRectMake(0, 0, 300, 480);
        backgroundImageView.center = CGPointMake(CGRectGetMidX(self.bounds),
                                                 CGRectGetMidX(self.bounds));
        [self addSubview:backgroundImageView];
        [backgroundImageView release];
        
        // 标题
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.bounds = CGRectMake(0, 0, CGRectGetWidth(backgroundImageView.bounds),
                                       CGRectGetHeight(backgroundImageView.bounds) * 0.2);
        titleLabel.center = CGPointMake(CGRectGetMidX(titleLabel.bounds), CGRectGetMidY(titleLabel.bounds));
        titleLabel.font = [UIFont systemFontOfSize:18];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = @"测试标题";
        _titleLabel = titleLabel;
        [backgroundImageView addSubview:titleLabel];
        [titleLabel release];
    }
    return self;
}

- (void)dealloc
{
    _titleLabel = nil;
    [super dealloc];
}

@end
