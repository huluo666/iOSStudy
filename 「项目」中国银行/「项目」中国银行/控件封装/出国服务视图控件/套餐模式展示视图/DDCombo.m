//
//  DDCombo.m
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-10.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDCombo.h"

@implementation DDCombo

- (void)dealloc
{
    NSLog(@"%@ is dealloced", [self class]);    
    [_titleLabel release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = CGRectMake(0, 80, 300, 400);
        
        // 背景图片
        UIImageView *backgroundImageView = [[UIImageView alloc]
                                            initWithImage:kImageWithName(@"prepare1_01.png")];
        backgroundImageView.bounds = CGRectMake(0, 0, 300, 480);
        backgroundImageView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
        backgroundImageView.userInteractionEnabled = YES;
        backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:backgroundImageView];
        [backgroundImageView release];
        
        // 标题
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.bounds = CGRectMake(0, 0, CGRectGetWidth(backgroundImageView.bounds),
                                       CGRectGetHeight(backgroundImageView.bounds) * 0.2);
        _titleLabel.center = CGPointMake(CGRectGetMidX(_titleLabel.bounds), CGRectGetMidY(_titleLabel.bounds));
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"测试标题";
        [backgroundImageView addSubview:_titleLabel];
        
        // 详情
        UIButton *detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [detailButton setBackgroundImage:[UIImage imageNamed:@"未选中_23"] forState:UIControlStateNormal];
        detailButton.bounds = CGRectMake(0, 0, 100, 50);
        detailButton.center = CGPointMake(CGRectGetMidX(backgroundImageView.bounds),
                                          CGRectGetMaxY(backgroundImageView.bounds) - CGRectGetMaxY(detailButton.bounds) * 1.5);
        [detailButton addTarget:self
                         action:@selector(showDetail:)
               forControlEvents:UIControlEventTouchUpInside];
        detailButton.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [backgroundImageView addSubview:detailButton];
    }
    return self;
}

- (void)showDetail:(UIButton *)sender
{
    NSLog(@"showDetail");
}


@end
