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

- (void)dealloc
{
    NSLog(@"%@ is dealloced", [self class]);
    [_imageView release];
    [_textLabel release];
    [_detailTextLabel release];
    _button = nil;
    [_processTap release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
          projectShowViewType:(DDCollectionCellViewType)type
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
            _imageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
            _imageView.contentMode = UIViewContentModeScaleAspectFill;
            _imageView.clipsToBounds = YES;
            [self addSubview:_imageView];

            // 显示文本
            CGRect textLabelFrame = CGRectMake(0,
                                               bounds.size.height * 0.8,
                                               bounds.size.width,
                                               bounds.size.height * 0.2);
            _textLabel = [[UILabel alloc] initWithFrame:textLabelFrame];
            _textLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:_textLabel];

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
            _imageView = [[UIImageView alloc] init];
            _imageView.bounds = imageViewBounds;
            _imageView.center = CGPointMake(CGRectGetMidX(imageViewBounds) + 5,
                                           bounds.size.height / 2);
            _imageView.contentMode = UIViewContentModeScaleAspectFill;
            _imageView.clipsToBounds = YES;
            _imageView.userInteractionEnabled = YES;
            [self addSubview:_imageView];
            
            // 显示信息文本
            CGRect textLabelBounds = CGRectMake(0,
                                                0,
                                                bounds.size.width / 3 * 2 - 15,
                                                bounds.size.height / 3);
            _textLabel = [[UILabel alloc] init];
            _textLabel.bounds = textLabelBounds;
            _textLabel.center = CGPointMake(CGRectGetMidX(_textLabel.bounds) +
                                            CGRectGetWidth(imageViewBounds) + 10,
                                            CGRectGetMidY(_textLabel.bounds));
            [self addSubview:_textLabel];
            
            // 显示详细信息文本
            _detailTextLabel = [[UILabel alloc] init];
            _detailTextLabel.bounds = textLabelBounds;
            _detailTextLabel.center = CGPointMake(_textLabel.center.x,
                                                 _textLabel.center.y +
                                                  CGRectGetHeight(_textLabel.bounds));
            [self addSubview:_detailTextLabel];

            // 详情button
            _button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            _button.bounds = CGRectMake(0, 0, 60, 30);
            _button.center = CGPointMake(CGRectGetWidth(bounds) / 6 * 5,
                                        CGRectGetMaxY(bounds) -
                                         CGRectGetMidY(_button.bounds) - 5);
            [_button setBackgroundImage:[UIImage imageNamed:@"详情_01"]
                               forState:UIControlStateNormal];
            [_button addTarget:self
                       action:@selector(processTap:)
             forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_button];
        }
    }
    return self;
}

- (void)processTap:(UIView *)view
{
    if (_processTap) {
        NSLog(@"点击回调方法");
        _processTap(view);
    }
}

@end
