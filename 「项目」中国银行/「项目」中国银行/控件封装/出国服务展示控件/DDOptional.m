//
//  DDOptional.m
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-10.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDOptional.h"

@implementation DDOptional

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, 300, 300);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.frame];
        imageView.image = [UIImage imageNamed:@"未标题-1_01"];
        [self addSubview:imageView];
        [imageView release];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.bounds = CGRectMake(0,
                                       0,
                                       CGRectGetWidth(imageView.bounds),
                                       CGRectGetHeight(imageView.bounds) * 0.2);
        titleLabel.center = CGPointMake(CGRectGetMidX(imageView.bounds),
                                        CGRectGetMidY(titleLabel.bounds));
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = @"test";
        [imageView addSubview:titleLabel];
        [titleLabel release];
        
        // 详情按钮
        UIButton *detailButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        detailButton.bounds = CGRectMake(0, 0, 60, 30);
        detailButton.tag = kDetailButtonTag;
        detailButton.center = CGPointMake(CGRectGetMidX(titleLabel.bounds) - CGRectGetMidX(detailButton.bounds) - 10,
                                    CGRectGetMaxY(imageView.bounds) - CGRectGetHeight(detailButton.bounds));
        [detailButton setBackgroundImage:[UIImage imageNamed:@"详情_01"] forState:UIControlStateNormal];
        [detailButton addTarget:self
                   action:@selector(processTap:)
         forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:detailButton];
        
        // 选购按钮
        UIButton *chooseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        chooseButton.bounds = detailButton.bounds;
        detailButton.tag = kChooseButtonTag;
        chooseButton.center = CGPointMake( CGRectGetWidth(imageView.bounds) - CGRectGetMidX(detailButton.frame),
                                    detailButton.center.y);
        [chooseButton setBackgroundImage:[UIImage imageNamed:@"选购_03"] forState:UIControlStateNormal];
        [chooseButton addTarget:self
                   action:@selector(processTap:)
         forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:chooseButton];
    }
    return self;
}

- (void)processTap:(UIButton *)sender
{
    if (_processTap) {
        _processTap(sender);
    }
}

@end
