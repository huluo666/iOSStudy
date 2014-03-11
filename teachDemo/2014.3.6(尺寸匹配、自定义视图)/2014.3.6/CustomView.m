//
//  CustomView.m
//  2014.3.6
//
//  Created by 张鹏 on 14-3-6.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "CustomView.h"

// 全局静态变量
static NSString * const kInformationImageKey   = @"image";
static NSString * const kInformationNameKey    = @"name";
static NSString * const kInformationYearKey    = @"year";
static NSString * const kInformationContentKey = @"content";

@implementation CustomView

- (id)initWithFrame:(CGRect)frame infoDict:(NSDictionary *)infoDict
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        
        // 头像
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.bounds = CGRectMake(0, 0, 150, 150);
        imageView.center = CGPointMake(CGRectGetMidX(imageView.bounds),
                                       CGRectGetHeight(frame) / 2 - 5 - CGRectGetMidY(imageView.bounds));
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = [UIImage imageNamed:infoDict[kInformationImageKey]];
        [self addSubview:imageView];
        
        // 姓名
        UILabel *nameDisplay = [[UILabel alloc] init];
        nameDisplay.bounds = CGRectMake(0, 0, CGRectGetWidth(frame) - 10 - CGRectGetWidth(imageView.bounds), CGRectGetMidY(imageView.bounds));
        nameDisplay.center = CGPointMake(CGRectGetMaxX(imageView.frame) + 10 + CGRectGetMidX(nameDisplay.bounds), CGRectGetMinY(imageView.frame) + CGRectGetMidY(nameDisplay.bounds));
        nameDisplay.font = [UIFont systemFontOfSize:20];
        nameDisplay.text = infoDict[kInformationNameKey];
        [self addSubview:nameDisplay];

        // 年
        UILabel *yearDisplay = [[UILabel alloc] init];
        yearDisplay.bounds = nameDisplay.bounds;
        yearDisplay.center = CGPointMake(CGRectGetMidX(nameDisplay.frame),
                                         CGRectGetMaxY(nameDisplay.frame) + CGRectGetMidY(yearDisplay.bounds));
        yearDisplay.font = [UIFont systemFontOfSize:18];
        yearDisplay.textColor = [UIColor grayColor];
        yearDisplay.text = infoDict[kInformationYearKey];
        [self addSubview:yearDisplay];

        // 简介
        UITextView *textView = [[UITextView alloc] init];
        textView.bounds = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame) / 2 - 5);
        textView.center = CGPointMake(CGRectGetWidth(frame) / 2, CGRectGetHeight(frame) / 2 + 5 + CGRectGetMidY(textView.bounds));
        textView.font = [UIFont systemFontOfSize:15];
        textView.userInteractionEnabled = NO;
        textView.bounces = NO;
        textView.text = infoDict[kInformationContentKey];
        [self addSubview:textView];
        
        [self showCustomView];
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self dismissCustomView];
}

- (void)showCustomView {
    
    // 首先瞬间缩小及隐藏
    self.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(self.bounds));
    self.alpha = 0.0;
    // 动画放大及显示
    // iOS7
    [UIView animateWithDuration:0.5
                          delay:0.0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1.0;
    } completion:nil];
}

- (void)dismissCustomView {
    
    [UIView animateWithDuration:0.4 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(self.bounds));
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        // 动画结束，移除视图
        [self removeFromSuperview];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end













