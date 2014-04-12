//
//  DDInsureShowDetail.m
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-19.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDInsureShowDetail.h"

@implementation DDInsureShowDetail

- (id)initWithFrame:(CGRect)frame contents:(NSArray *)contents
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat lastMaxY = 10;
        for (int i = 0; i < 6; i++) {
            UILabel *label = [[UILabel alloc] init];
            label.bounds = CGRectMake(0, 0, 600, 60);
            label.center = CGPointMake(CGRectGetMidX(self.contentView.bounds),
                                       lastMaxY + CGRectGetMidY(label.bounds));
            lastMaxY = CGRectGetMaxY(label.frame);
            if (contents.count == 6) {
                label.text = contents[i];
            }
            [self.contentView addSubview:label];
            [label release];
        }
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
