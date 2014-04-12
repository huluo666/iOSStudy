//
//  DDPopVIew.m
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-12.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDPopVIew.h"

@implementation DDPopVIew

- (void)dealloc
{
    NSLog(@"%@ pop dealloced", [self class]);
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 10;
    }
    return self;
}

@end
