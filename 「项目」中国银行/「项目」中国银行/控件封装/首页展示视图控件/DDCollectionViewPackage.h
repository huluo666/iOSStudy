//
//  DDCollectionViewPackage.h
//  「项目」中国银行
//
//  Created by 萧川 on 3/9/14.
//  Copyright (c) 2014 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDCollectionCellView.h"

@interface DDCollectionViewPackage : UIView

@property (nonatomic, retain, readonly) UIImageView *backgroundImageView;           // 背景图片
@property (nonatomic, retain, readonly) UICollectionView *collectionView;           // 集合视图
@property (nonatomic, copy) NSString *identifier;                                   // 重用标志
@property (nonatomic, assign) DDCollectionCellViewType collectionCellViewType;      // 显示样式
@property (nonatomic, retain, readonly) UIPageControl *pageControl;                 // 分页控件
@property (nonatomic, assign) CGRect collectionCellViewBounds;                      // cell bounds
@property (nonatomic, assign) NSMutableArray *dataSource;                           // 数据

- (id)initWithFrame:(CGRect)frame
    collectionViewLayout:(UICollectionViewLayout *)layout
    reuseIdentifier:(NSString *)identifier
    collectionCellViewType:(DDCollectionCellViewType) collectionCellViewType
    collectionCellViewBounds:(CGRect)collectionCellViewBounds
    dataSource:(NSMutableArray *)dataSource;
@end

