//
//  DDHandleShowDetail.h
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-19.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDHandleShowDetail : UIView

+ (void)handleHotShowDetailWithDataSource:(NSArray *)dataSource indexPath:(NSIndexPath *)indexPath;
+ (void)handleCustomShowDetailWithDataSource:(NSArray *)dataSource indexPath:(NSIndexPath *)indexPath;
+ (void)handleOptionalShowDetailWithDataSource:(NSArray *)dataSource indexPath:(NSIndexPath *)indexPath typeId:(NSString *)currentTypeId;
+ (void)handleFundShowDetailWithDataSource:(NSArray *)dataSource indexPath:(NSIndexPath *)indexPath;
+ (void)handleMetalShowDetailWithDataSource:(NSDictionary *)dataSource indexPath:(NSIndexPath *)indexPath;
+ (void)handleInsureShowDetailWithDataSource:(NSArray *)dataSource indexPath:(NSIndexPath *)indexPath;
@end
