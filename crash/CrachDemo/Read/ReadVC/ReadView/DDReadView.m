//
//  DDReadView.m
//  LighterReader
//
//  Created by 萧川 on 14-4-10.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDReadView.h"
#import "UIView+FindUIViewController.h"
#import "DDPullUpControl.h"

@interface DDReadView ()

@property (strong, nonatomic) DDPullUpControl *pullUpControl;

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
        DDPullUpControl * _pullUpControl1 = [[DDPullUpControl alloc] init];
        self.pullUpControl = _pullUpControl1;
        
        [self addSubview:self.pullUpControl];
//        _pullUpControl.pullControlWillBeginAction = ^(DDPullControl *pullControl){
//            DDReadView *strongSelf = weakSelf;
//            [[strongSelf viewController].navigationController popViewControllerAnimated:YES];
//        };
       
        
//        self.font = [UIFont systemFontOfSize:15];
//        self.textAlignment = NSTextAlignmentLeft;
//        self.textColor = [UIColor blackColor];
//        self.editable = NO;
//        self.alwaysBounceVertical = YES;
    }
    return self;
}

@end
