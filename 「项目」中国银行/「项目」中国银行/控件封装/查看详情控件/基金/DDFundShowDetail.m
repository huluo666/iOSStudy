//
//  DDFundShowDetail.m
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-19.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDFundShowDetail.h"

@implementation DDFundShowDetail

- (id)initWithFrame:(CGRect)frame contents:(NSArray *)contents;
{
    self = [super initWithFrame:frame];
    if (self) {
        if (self) {
            CGFloat lastMaxY = 30;
            for (int i = 0; i < 5; i++) {
                UILabel *label = [[UILabel alloc] init];
                label.bounds = CGRectMake(0, 0, 600, 60);
                label.center = CGPointMake(CGRectGetMidX(self.contentView.bounds),
                                           lastMaxY + CGRectGetMidY(label.bounds));

                lastMaxY = CGRectGetMaxY(label.frame);
                if (contents.count == 5) {
                    label.text = contents[i];
                }
                [self.contentView addSubview:label];
                [label release];
            }
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
