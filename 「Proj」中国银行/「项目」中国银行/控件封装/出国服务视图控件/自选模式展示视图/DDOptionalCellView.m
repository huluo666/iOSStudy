//
//  DDOptionalCellView.m
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-18.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDOptionalCellView.h"

@implementation DDOptionalCellView

- (void)dealloc
{
    NSLog(@"%@ dealloc", [self class]);
    [_displayLabel release];
    [super dealloc];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _displayLabel = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        _displayLabel.textColor = [UIColor blackColor];
        _displayLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_displayLabel];
    }
    return self;
}

@end
