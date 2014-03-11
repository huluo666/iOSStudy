//
//  DDBlockButton.m
//  「UI」BlockCircularReference
//
//  Created by 萧川 on 3/4/14.
//  Copyright (c) 2014 CUAN. All rights reserved.
//

#import "DDBlockButton.h"

@implementation DDBlockButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self
                 action:@selector(clickButton)
       forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)clickButton
{
    _clickBlock(self);
}

- (void)dealloc
{
    [_clickBlock release];
    [super dealloc];
}

@end
