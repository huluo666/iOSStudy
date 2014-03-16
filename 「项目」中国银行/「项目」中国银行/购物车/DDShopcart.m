//
//  DDShopcart.m
//  「项目」中国银行
//
//  Created by 萧川 on 3/7/14.
//  Copyright (c) 2014 CUAN. All rights reserved.
//

#import "DDShopcart.h"

@implementation DDShopcart

- (void)dealloc
{
    NSLog(@"%@ is dealloced", [self class]);
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *backgroundImage = kImageWithName(@"down_05");
        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
        backgroundView.bounds = self.bounds;
        backgroundView.center = CGPointMake(CGRectGetMidX(self.bounds),
                                            CGRectGetMidY(self.bounds));
        backgroundView.userInteractionEnabled = YES;
        [self addSubview:backgroundView];
        
        // 保存订单
        UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        saveButton.bounds = CGRectMake(0, 0, 159, 50);
        saveButton.center = CGPointMake(CGRectGetMidX(backgroundView.bounds) - CGRectGetMidX(saveButton.bounds) * 1.2,
                                        CGRectGetMaxY(backgroundView.bounds) - CGRectGetMidY(saveButton.bounds) * 2);
        [saveButton setBackgroundImage:kImageWithName(@"save") forState:UIControlStateNormal];
        saveButton.tag = kCartButtonTag;
        [saveButton addTarget:self
                       action:@selector(cartButtonAction:)
             forControlEvents:UIControlEventTouchUpInside];
        [backgroundView addSubview:saveButton];
        
        // 提交办理
        UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        submitButton.bounds = CGRectMake(0, 0, 159, 50);
        submitButton.center = CGPointMake(CGRectGetMidX(backgroundView.bounds) + CGRectGetMidX(submitButton.bounds) * 1.2,
                                        CGRectGetMaxY(backgroundView.bounds) - CGRectGetMidY(submitButton.bounds) * 2);
        [submitButton setBackgroundImage:kImageWithName(@"提交办理") forState:UIControlStateNormal];
        submitButton.tag = kCartButtonTag + 1;
        [submitButton addTarget:self
                       action:@selector(cartButtonAction:)
             forControlEvents:UIControlEventTouchUpInside];
        [backgroundView addSubview:submitButton];
        
        // 添加
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.bounds = CGRectMake(0, 0, 50, 50);
        addButton.center = CGPointMake(CGRectGetMaxX(backgroundView.bounds) - 60,
                                          CGRectGetMinY(backgroundView.bounds) + 60);
        [addButton setBackgroundImage:kImageWithName(@"+_10") forState:UIControlStateNormal];
        addButton.tag = kCartButtonTag + 2;
        [addButton addTarget:self
                      action:@selector(cartButtonAction:)
            forControlEvents:UIControlEventTouchUpInside];
        [backgroundView addSubview:addButton];
        
    }
    return self;
}

- (void)cartButtonAction:(UIButton *)sender
{
    NSLog(@"%ld", sender.tag);
}

@end
