//
//  BlockButton.m
//  BlockButton
//
//  Created by wei.chen on 13-1-4.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BlockButton.h"

@implementation BlockButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


- (void)clickAction {
    _block(self);
}

- (void)dealloc {
    [super dealloc];
    [_block release];
//    Block_release(_block);
}

@end
