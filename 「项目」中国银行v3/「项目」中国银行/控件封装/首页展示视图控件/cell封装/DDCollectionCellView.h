//
//  DDCollectionCellView.h
//  「项目」中国银行
//
//  Created by 萧川 on 3/9/14.
//  Copyright (c) 2014 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    DDCollectionCellViewDefault  = 0 << 1,
    DDCollectionCellViewSubTitle = 1 << 1
} DDCollectionCellViewType;


@interface DDCollectionCellView : UIView

@property (retain, nonatomic, readonly) UIImageView *imageView;       // 热门产怕图片视图
@property (retain, nonatomic, readonly) UILabel     *textLabel;       // 热门产品介绍信息
@property (retain, nonatomic, readonly) UILabel     *detailTextLabel; // 热门产品详细信息介绍
@property (retain, nonatomic, readonly) UIButton    *button;          // 点击按钮
@property (copy, nonatomic) void(^processTap)(UIView *view);

- (instancetype)initWithFrame:(CGRect)frame projectShowViewType:(DDCollectionCellViewType)type;

@end
