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
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(0, 0, 200, 144);
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        
        // 添加点击事件
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
                                              initWithTarget:self
                                              action:@selector(titleViewSingleTapAction:)];
        tapGesture.numberOfTapsRequired = 1;
        [titleLabel addGestureRecognizer:tapGesture];
        [tapGesture release];

        titleLabel.text = @"dddddd";
        titleLabel.backgroundColor = [UIColor greenColor];
        [self addSubview:titleLabel];
        [titleLabel release];
        
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.frame = CGRectMake(100, 100, 80, 44);
        [titleButton addTarget:self
                        action:@selector(titleButtonAction:)
              forControlEvents:UIControlEventTouchUpInside];
        [titleButton setTitle:@"button" forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self addSubview:titleButton];
    }
    return self;
}


- (void)titleViewSingleTapAction:(UITapGestureRecognizer *)singleTap {
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)titleButtonAction:(UIButton *)sender {
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

@end
