//
//  DDReadView.m
//  LighterReader
//
//  Created by 萧川 on 14-4-10.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDReadView.h"
#import "DDPullUp.h"
#import "UIView+FindUIViewController.h"

@implementation DDReadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        DDPullUp *pullUp = [DDPullUp pullUp];
        pullUp.scrollView = self;
        
        pullUp.beginRefreshBaseView = ^(DDRefreshBaseView *refreshBaseView) {
            [[self viewController].navigationController popViewControllerAnimated:YES];
            
        };
    }
    return self;
}


@end
