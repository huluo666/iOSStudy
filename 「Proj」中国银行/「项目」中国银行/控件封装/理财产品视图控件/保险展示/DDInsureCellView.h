//
//  DDInsureCellView.h
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-18.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDCustomCellView.h"

@interface DDInsureCellView : DDCustomCellView

@property (nonatomic, retain, readonly) UILabel *categoryNameLabel;
@property (nonatomic, retain, readonly) UILabel *characteristicLabel;
@property (nonatomic, retain, readonly) UILabel *companyLabel;
@property (nonatomic, retain, readonly) UILabel *crowdAgeLabel;
@property (nonatomic, retain, readonly) UILabel *timesLabel;

@end
