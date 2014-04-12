//
//  DDCollectionCellView.m
//  「项目」中国银行
//
//  Created by 萧川 on 3/9/14.
//  Copyright (c) 2014 CUAN. All rights reserved.
//

#import "DDCollectionCellView.h"

#pragma mark - 显示视图封装


@implementation DDCollectionCellView

- (instancetype)initWithFrame:(CGRect)frame projectShowViewType:(DDCollectionCellViewType)type
{
    if (self = [super initWithFrame:frame]) {
        CGRect bounds = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
        
        // 背景图片效果
        UIImage *backgroundImage = [UIImage imageNamed:@"底_14"];
        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
        backgroundView.userInteractionEnabled = YES;
        backgroundView.frame = frame;
        [self addSubview:backgroundView];
        [backgroundView release];
        
        if (DDCollectionCellViewDefault == type) {
            // 默认布局
            // 图片
            CGRect imageViewFrame = CGRectMake(0,
                                               0,
                                               bounds.size.width,
                                               bounds.size.height * 0.8);
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            [self addSubview:imageView];
            [imageView release];
            _imageView = imageView;

            // 显示文本
            CGRect textLabelFrame = CGRectMake(0,
                                               bounds.size.height * 0.8,
                                               bounds.size.width,
                                               bounds.size.height * 0.2);
            UILabel *textLabel = [[UILabel alloc] initWithFrame:textLabelFrame];
            textLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:textLabel];
            [textLabel release];
            _textLabel = textLabel;

            // 添加单击手势
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
                                                  initWithTarget:self
                                                  action:@selector(processTap:)];
            [self addGestureRecognizer:tapGesture];
            [tapGesture release];
            
        } else {
            // 详细信息布局
            // 图片
            CGRect imageViewBounds = CGRectMake(0,
                                                0,
                                                bounds.size.width / 3,
                                                bounds.size.height * 0.9);
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.bounds = imageViewBounds;
            imageView.center = CGPointMake(CGRectGetMidX(imageViewBounds) + 5,
                                           bounds.size.height / 2);
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.userInteractionEnabled = YES;
            [self addSubview:imageView];
            [imageView release];
            _imageView = imageView;
            
            
            // 显示信息文本
            CGRect textLabelBounds = CGRectMake(0,
                                                0,
                                                bounds.size.width / 3 * 2 - 15,
                                                bounds.size.height / 3);
            UILabel *textLabel = [[UILabel alloc] init];
            textLabel.bounds = textLabelBounds;
            textLabel.center = CGPointMake(CGRectGetMidX(textLabel.bounds) + CGRectGetWidth(imageViewBounds) + 10,
                                           CGRectGetMidY(textLabel.bounds));
            [self addSubview:textLabel];
            [textLabel release];
            _textLabel = textLabel;
            
            // 显示详细信息文本
            UILabel *detailTextLabel = [[UILabel alloc] init];
            detailTextLabel.bounds = textLabelBounds;
            detailTextLabel.center = CGPointMake(textLabel.center.x,
                                                 textLabel.center.y + CGRectGetHeight(textLabel.bounds));
            [self addSubview:detailTextLabel];
            [detailTextLabel release];
            _detailTextLabel = detailTextLabel;

            // 详情button
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            button.bounds = CGRectMake(0, 0, 60, 30);
            button.center = CGPointMake(CGRectGetWidth(bounds) / 6 * 5,
                                        CGRectGetMaxY(bounds) - CGRectGetMidY(button.bounds) - 5);
            [button setBackgroundImage:[UIImage imageNamed:@"详情_01"] forState:UIControlStateNormal];
            [button addTarget:self
                       action:@selector(processTap:)
             forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            _button = button;
        }
    }
    return self;
}

- (void)dealloc
{
    _imageView = nil;
    _textLabel = nil;
    _detailTextLabel = nil;
    _button = nil;
    [_processTap release];
    [super dealloc];
}

- (void)processTap:(UIView *)view
{
    if (_processTap) {
        NSLog(@"点击回调方法");
        _processTap(view);
    }
}

@end
