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
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:kImageWithName(@"prepare1_01.png")];
        backgroundImageView.bounds = CGRectMake(0, 0, 200, 400);
        backgroundImageView.center = self.center;
        [self addSubview:backgroundImageView];
        [backgroundImageView release];
    }
    return self;
}


@end
