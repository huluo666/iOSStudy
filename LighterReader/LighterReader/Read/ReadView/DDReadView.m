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

@interface DDReadView ()

@end

@implementation DDReadView

- (void)dealloc {
    
    NSLog(@"%@, dealloced", [self class]);
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

//        __weak DDReadView *weakSelf = self;
//        
//        DDPullUp *pullUp = [DDPullUp pullUp];
//        pullUp.scrollView = weakSelf;
//        pullUp.beginRefreshBaseView = ^(DDRefreshBaseView *refreshBaseView) {
//            [[weakSelf viewController].navigationController popViewControllerAnimated:YES];
//        };
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 40)];
        label.font = [UIFont systemFontOfSize:24];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"Reading...";
        label.backgroundColor = [UIColor grayColor];
        [self addSubview:label];
    }
    return self;
}


@end
