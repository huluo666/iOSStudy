//
//  DDNaviCell.m
//  面试职通车
//
//  Created by 萧川 on 14-4-17.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDNaviCell.h"

@implementation DDNaviCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect bounds = self.bounds;
        
        _label = [[UILabel alloc] init];
        _label.bounds = CGRectMake(0, 0, CGRectGetWidth(bounds), CGRectGetHeight(bounds) * 0.2);
        _label.center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMaxY(self.contentView.bounds) - CGRectGetMidY(_label.bounds));
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor whiteColor];
        _label.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:_label];
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.bounds = CGRectMake(0, 0, 60, 60);
        _button.center = CGPointMake(CGRectGetMidX(bounds), CGRectGetHeight(bounds) * 0.4);
        [_button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_button];
    }
    return self;
}

- (void)buttonAction {
    
    if (_cellButtonDidTap) {
        _cellButtonDidTap();
    }
}

@end
