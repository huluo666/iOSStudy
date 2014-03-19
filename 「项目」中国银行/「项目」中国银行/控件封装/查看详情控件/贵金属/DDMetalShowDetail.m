//
//  DDMetalShowDetail.m
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-19.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDMetalShowDetail.h"

@implementation DDMetalShowDetail

- (void)dealloc
{
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame contents:(NSArray *)contents
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat lastMaxY = 150;
        for (int i = 0; i < 6; i++) {
            UILabel *label = [[UILabel alloc] init];
            label.bounds = CGRectMake(0, 0, 200, 60);
            if (i%2) {
                label.center = CGPointMake(550, lastMaxY + CGRectGetMidY(label.bounds));
            } else {
                label.center = CGPointMake(250, lastMaxY + CGRectGetMidY(label.bounds));
            }
            if (i%2) {
                lastMaxY = CGRectGetMaxY(label.frame);
            }
            if (contents.count == 6) {
                label.text = contents[i];
            }
            [self.contentView addSubview:label];
            [label release];
        }
    }
    return self;
}

@end
