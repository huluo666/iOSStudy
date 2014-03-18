//
//  DDFundCellView.h
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-18.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDCustomCellView.h"

@interface DDFundCellView : DDCustomCellView

@property (nonatomic, retain, readonly) UILabel *nameLabel;
@property (nonatomic, retain, readonly) UILabel *accumulativeValueLabel;
@property (nonatomic, retain, readonly) UILabel *assetValueLabel;
@property (nonatomic, retain, readonly) UILabel *stopTimeLabel;

@end
