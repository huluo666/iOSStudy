//
//  DDPageView.m
//  「Demo」上下翻页
//
//  Created by 萧川 on 14-4-2.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDPageView.h"

#define kRandomColor [UIColor colorWithRed:arc4random() % 128 / 255.0f green:arc4random() % 64 / 255.0f blue:arc4random() % 255 / 255.0f alpha:1.000]

@implementation DDPageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = kRandomColor;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
