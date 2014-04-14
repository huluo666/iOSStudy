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


@end

@implementation DDReadView

- (void)dealloc {

    NSLog(@"%@, dealloced", [self class]);
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        __weak DDReadView *weakSelf = self;
        DDPullUpControl *pullUpControl = [[DDPullUpControl alloc] init];
        pullUpControl.pullToAction = @"Pull to close";
        pullUpControl.pullReleaseToAction = @"Release to close";
        pullUpControl.indicatorView = nil;
        pullUpControl.pullAction = @"";
        pullUpControl.pullControlWillBeginAction = ^(DDPullControl *pullControl){
            [[weakSelf viewController].navigationController popViewControllerAnimated:YES];
        };
        [self addSubview:pullUpControl];
        
        self.font = [UIFont systemFontOfSize:15];
        self.textAlignment = NSTextAlignmentLeft;
        self.textColor = [UIColor blackColor];
        self.editable = NO;
        self.alwaysBounceVertical = YES;
    }
    return self;
}

- (void)setContent:(NSString *)content {
    
    self.text = content;
    // 调整布局
    [self adjustLayoutWithContent:content];
}

- (void)adjustLayoutWithContent:content {
    
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 20;
    CGSize size = [self sizeWithString:content
                                  font:[UIFont systemFontOfSize:15]
                        constraintSize:CGSizeMake(width, NSIntegerMax)];
    CGFloat height = CGRectGetHeight([[UIScreen mainScreen] bounds]);
    CGSize contentSize = CGSizeMake(width, height);
    if (height > size.height) {
        contentSize.height = height;
    }
    self.contentSize = contentSize;
}

- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font constraintSize:(CGSize)constraintSize
{
    CGRect rect = [string boundingRectWithSize:constraintSize
                                       options:NSStringDrawingTruncatesLastVisibleLine |
                   NSStringDrawingUsesFontLeading |
                   NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
                                       context:nil];
    return rect.size;
}

@end
