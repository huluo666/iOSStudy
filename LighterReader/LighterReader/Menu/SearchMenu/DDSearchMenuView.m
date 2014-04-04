//
//  DDSearchMenuView.m
//  LighterReader
//
//  Created by 萧川 on 14-4-4.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDSearchMenuView.h"

@implementation DDSearchMenuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.863 alpha:1.000];

        CGFloat width = [[UIScreen mainScreen] bounds].size.width;
        CGFloat height = [[UIScreen mainScreen] bounds].size.height;
        self.bounds = CGRectMake(0, 0, width - 40, height - 20);

        // swip right gesture
        UISwipeGestureRecognizer *swipRight = [[UISwipeGestureRecognizer alloc]
                                              initWithTarget:self
                                              action:@selector(swipRightAction)];
        swipRight.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:swipRight];
    }
    return self;
}

- (void)swipRightAction {

    if (_handleSwipRight) {
        _handleSwipRight();
    }
}

@end
