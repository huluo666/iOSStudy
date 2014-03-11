//
//  DDCustomView.m
//  「UI」设备尺寸匹配(day19)
//
//  Created by 萧川 on 14-3-6.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDCustomView.h"

@implementation DDCustomView

- (id)initWithFrame:(CGRect)frame infoDict:(NSDictionary *)infoDict
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        // 头像
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.bounds = CGRectMake(0, 0, 150, 150);
        CGPoint center = self.center;
        imageView.center = CGPointMake(center.x / 2,
                                       center.y - CGRectGetMidY(imageView.bounds) - 10);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = [UIImage imageNamed:infoDict[DDInfoDictImage]];
        [self addSubview:imageView];

        // 姓名
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.bounds = CGRectMake(0, 0, center.x - 5, CGRectGetHeight(imageView.bounds) / 2);
        nameLabel.center = CGPointMake(center.x + CGRectGetMidX(nameLabel.bounds),
                                       CGRectGetMidY(imageView.frame) - CGRectGetMidY(nameLabel.bounds));
        nameLabel.font = [UIFont systemFontOfSize:18];
        nameLabel.textColor = [UIColor grayColor];
        nameLabel.text = infoDict[DDInfoDictName];
        [self addSubview:nameLabel];
        
        // 年龄
        UILabel *ageLabel = [[UILabel alloc] init];
        ageLabel.bounds = CGRectMake(0, 0, center.x - 5, CGRectGetHeight(imageView.bounds) / 2);
        ageLabel.center = CGPointMake(center.x + CGRectGetMidX(nameLabel.bounds),
                                       CGRectGetMaxY(imageView.frame) - CGRectGetMidY(ageLabel.bounds));
        ageLabel.font = [UIFont systemFontOfSize:18];
        ageLabel.textColor = [UIColor grayColor];
        ageLabel.textColor = [UIColor grayColor];
        ageLabel.text = infoDict[DDInfoDictage];
        [self addSubview:ageLabel];
        
        // 简介
        UITextView *infoView = [[UITextView alloc] init];
        infoView.bounds = CGRectMake(0, 0, CGRectGetMaxX(nameLabel.frame) - CGRectGetMinX(imageView.frame),
                                     CGRectGetHeight(self.frame) - center.y);
        infoView.center = CGPointMake(center.x, center.y + CGRectGetMidY(infoView.bounds));
        infoView.editable = NO;
        infoView.font = [UIFont systemFontOfSize:15];
        infoView.text = infoDict[DDInfoDictInfo];
        infoView.textColor = [UIColor grayColor];
        [self addSubview:infoView];
    }
    
    [self showCustomView];
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismissCustomView];
}

- (void)showCustomView
{
    // 瞬间缩小以及隐藏
    self.transform = CGAffineTransformMakeScale(0.1, 0.1);
    self.alpha = 0.0f;
    
    // 动画放大显示
    [UIView animateWithDuration:0.4f
                          delay:0.0f
         usingSpringWithDamping:0.5f
          initialSpringVelocity:0.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1.0f;
    }
                     completion:nil];
}

- (void)dismissCustomView
{
    [UIView animateWithDuration:0.4f animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
