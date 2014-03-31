//
//  DDHomeView.m
//  LighterReader
//
//  Created by 萧川 on 14-3-27.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDHomeView.h"

@implementation DDHomeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // ....
        UIImage *image = DDImageWithName(@"mobile-action-poster");
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(0, 0, 100, 100);
        [self addSubview:imageView];
        [imageView release];
    }
    return self;
}


@end
