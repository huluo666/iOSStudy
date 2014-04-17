//
//  DDNaviCell.h
//  面试职通车
//
//  Created by 萧川 on 14-4-17.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDNaviCell : UICollectionViewCell

@property (nonatomic, strong, readonly) UIButton *button;
@property (nonatomic, strong, readonly) UILabel *label;

@property (nonatomic, copy) void(^cellButtonDidTap)(void);

@end
