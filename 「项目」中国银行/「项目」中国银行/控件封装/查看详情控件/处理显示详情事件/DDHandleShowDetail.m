//
//  DDHandleShowDetail.m
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-19.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDHandleShowDetail.h"
#import "DDAppDelegate.h"
#import "DDMetalShowDetail.h"
#import "DDInsureShowDetail.h"
#import "DDFundShowDetail.h"
#import "DDBuyView.h"

@implementation DDHandleShowDetail

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (void)handleHotShowDetailWithDataSource:(NSArray *)dataSource indexPath:(NSIndexPath *)indexPath
{
    NSString *categoryName = dataSource[indexPath.row][@"categoryName"];
    
    // 贵金属
    if ([categoryName isEqualToString:@"贵金属"]) {
        [DDHTTPManager sendRequestForHotDetailWithId:[NSString stringWithFormat:@"%@", dataSource[indexPath.row][@"id"]]
                                   completionHandler:^(id content, NSString *resultCode) {
            NSArray *contents = @[
                                 [NSString stringWithFormat:@"成色：%@", content[@"quality"]],
                                 [NSString stringWithFormat:@"规格：%@", content[@"scale"]],
                                 [NSString stringWithFormat:@"发行量：%@", content[@"circulation"]],
                                 [NSString stringWithFormat:@"类别：%@", content[@"typeName"]],
                                 [NSString stringWithFormat:@"供应商：%@", content[@"supplierName"]],
                                 [NSString stringWithFormat:@"适宜人群：%@", content[@"ageName"]]
                                 ];
            DDMetalShowDetail *metal = [[DDMetalShowDetail alloc] initWithFrame:CGRectZero contents:contents];
            metal.titleLabel.text = dataSource[indexPath.row][@"name"];
            metal.buyAction = ^(UIButton *sender) {
               DDBuyView *buyView = [[DDBuyView alloc] initWithFrame:CGRectZero productInfo:content];
               [kRootView addSubview:buyView];
               [buyView release];
            };
            [kRootView addSubview:metal];
            [metal release];
       }];
    }
    
    // 保险
    if ([categoryName isEqualToString:@"保险"]) {
        [DDHTTPManager sendRequestForHotDetailWithId:[NSString stringWithFormat:@"%@", dataSource[indexPath.row][@"id"]]
                                   completionHandler:^(id content, NSString *resultCode) {
           NSArray *contents = @[
                                 [NSString stringWithFormat:@"产品名称：%@", content[@"name"]],
                                 [NSString stringWithFormat:@"产品属性：%@", content[@"characteristic"]],
                                 [NSString stringWithFormat:@"发行公司：%@", content[@"company"]],
                                 [NSString stringWithFormat:@"保险责任：%@", content[@"insured_liability"]],
                                 [NSString stringWithFormat:@"适宜人群：%@岁客户", content[@"ageName"]],
                                 [NSString stringWithFormat:@"保险期限：%@年", content[@"time"]]
                                 ];
           DDInsureShowDetail *insure = [[DDInsureShowDetail alloc] initWithFrame:CGRectZero contents:contents];
           insure.titleLabel.text = dataSource[indexPath.row][@"name"];
           insure.buyAction = ^(UIButton *sender) {
               DDBuyView *buyView = [[DDBuyView alloc] initWithFrame:CGRectZero productInfo:content];
               [kRootView addSubview:buyView];
               [buyView release];
           };
           [kRootView addSubview:insure];
           [insure release];
       }];
    }
    
    // 出国留学金融服务
    if ([categoryName isEqualToString:@"出国留学金融服务"]) {
        [DDHTTPManager sendRequestForHotDetailWithId:[NSString stringWithFormat:@"%@", dataSource[indexPath.row][@"id"]]
                                   completionHandler:^(id content, NSString *resultCode) {
            echo();
            NSLog(@"categoryName = %@", categoryName);
            DDShowDetail *abroad = [[DDShowDetail alloc] initWithFrame:CGRectZero];
            // content
            CGRect labelFrame = CGRectMake(20,
                                          20,
                                          CGRectGetWidth(abroad.contentView.bounds) - 40,
                                          CGRectGetHeight(abroad.contentView.bounds) - 40);
            UILabel *contentLabel = [[UILabel alloc] initWithFrame:labelFrame];
            NSString *labelText = [NSString stringWithFormat:@"%@", content[@"name"]];
            [contentLabel setText:labelText];
            [contentLabel setNumberOfLines:0];
            [contentLabel sizeToFit];
            [abroad.contentView addSubview:contentLabel];
            [contentLabel release];

            abroad.titleLabel.text = dataSource[indexPath.row][@"name"];
            abroad.buyAction = ^(UIButton *sender) {
                DDBuyView *buyView = [[DDBuyView alloc] initWithFrame:CGRectZero productInfo:content];
               [kRootView addSubview:buyView];
               [buyView release];
            };
            [kRootView addSubview:abroad];
            [abroad release];
       }];
    }
    
    // 基金
    if ([categoryName isEqualToString:@"基金"]) {
        [DDHTTPManager sendRequestForHotDetailWithId:[NSString stringWithFormat:@"%@",
                                                      dataSource[indexPath.row][@"id"]]
                                   completionHandler:^(id content, NSString *resultCode) {
            echo();
            NSLog(@"categoryName = %@", categoryName);
            NSArray *contents = @[
                [NSString stringWithFormat:@"基金代码：%@", content[@"number"]],
                [NSString stringWithFormat:@"基金简称：%@", content[@"productId"]],
                [NSString stringWithFormat:@"单位净值：%@", content[@"accumulative_value"]],
                [NSString stringWithFormat:@"累计净值：%@", content[@"asset_value"]],
                [NSString stringWithFormat:@"截至日期：%@", content[@"stop_time"]],
                                ];
           DDFundShowDetail *fund = [[DDFundShowDetail alloc]
                                     initWithFrame:CGRectZero
                                     contents:contents];
           fund.titleLabel.text = dataSource[indexPath.row][@"name"];
           fund.buyAction = ^(UIButton *sender) {
               DDBuyView *buyView = [[DDBuyView alloc]
                                     initWithFrame:CGRectZero
                                     productInfo:content];
               [kRootView addSubview:buyView];
               [buyView release];
           };
           [kRootView addSubview:fund];
           [fund release];
       }];

    }
}

+ (void)handleCustomShowDetailWithDataSource:(NSArray *)dataSource indexPath:(NSIndexPath *)indexPath
{
    NSString *categoryName = dataSource[indexPath.row][@"categoryName"];
    if ([categoryName isEqualToString:@"出国留学金融服务"]) {
        [DDHTTPManager sendRequestForCustomProjecDetailtWithId:[NSString stringWithFormat:@"%@",
                                                                dataSource[indexPath.row][@"id"]]
                                             completionHandler:^(id content, NSString *resultCode) {
            echo();
            NSLog(@"categoryName = %@", categoryName);
            DDShowDetail *abroad = [[DDShowDetail alloc] initWithFrame:CGRectZero];
            // content
            CGRect labelFrame = CGRectMake(20,
                                        20,
                                        CGRectGetWidth(abroad.contentView.bounds) - 40,
                                        CGRectGetHeight(abroad.contentView.bounds) - 40);
            UILabel *contentLabel = [[UILabel alloc] initWithFrame:labelFrame];
            NSString *labelText = [NSString stringWithFormat:@"%@", content[@"product"][@"name"]];
            [contentLabel setText:labelText];
            [contentLabel setNumberOfLines:0];
            [contentLabel sizeToFit];
            [abroad.contentView addSubview:contentLabel];
            [contentLabel release];

            abroad.titleLabel.text = dataSource[indexPath.row][@"name"];
            abroad.buyAction = ^(UIButton *sender) {
             DDBuyView *buyView = [[DDBuyView alloc] initWithFrame:CGRectZero productInfo:content];
             [kRootView addSubview:buyView];
             [buyView release];
            };
            [kRootView addSubview:abroad];
            [abroad release];
     }];
    }
    
    if ([categoryName isEqualToString:@"理财产品"]) {
        [DDHTTPManager sendRequestForCustomProjecDetailtWithId:[NSString stringWithFormat:@"%@", dataSource[indexPath.row][@"id"]]
                                             completionHandler:^(id content, NSString *resultCode) {
            echo();
            NSLog(@"categoryName = %@", categoryName);
            DDShowDetail *abroad = [[DDShowDetail alloc] initWithFrame:CGRectZero];
            // content
            CGRect labelFrame = CGRectMake(20,
                                        20,
                                        CGRectGetWidth(abroad.contentView.bounds) - 40,
                                        CGRectGetHeight(abroad.contentView.bounds) - 40);
            UILabel *contentLabel = [[UILabel alloc] initWithFrame:labelFrame];
            NSString *labelText = [NSString stringWithFormat:@"%@", content[@"product"][@"name"]];
            [contentLabel setText:labelText];
            [contentLabel setNumberOfLines:0];
            [contentLabel sizeToFit];
            [abroad.contentView addSubview:contentLabel];
            [contentLabel release];

            abroad.titleLabel.text = dataSource[indexPath.row][@"name"];
            abroad.buyAction = ^(UIButton *sender) {
             DDBuyView *buyView = [[DDBuyView alloc] initWithFrame:CGRectZero productInfo:content];
             [kRootView addSubview:buyView];
             [buyView release];
            };
            [kRootView addSubview:abroad];
            [abroad release];
            }];
    }
}

+ (void)handleOptionalShowDetailWithDataSource:(NSArray *)dataSource indexPath:(NSIndexPath *)indexPath typeId:(NSString *)currentTypeId
{
    NSLog(@"id = %@", [NSString stringWithFormat:@"%@", dataSource[indexPath.row][@"id"]]);
    [DDHTTPManager sendRequestForOptionalDetailtWithId:[NSString stringWithFormat:@"%@", dataSource[indexPath.row][@"id"]]
                                                typeId:currentTypeId
                                     completionHandler:^(id content, NSString *resultCode) {
        echo();
        NSLog(@"product = %@", content[@"product"]);
        DDShowDetail *abroad = [[DDShowDetail alloc] initWithFrame:CGRectZero];
        // content
        CGRect labelFrame = CGRectMake(20,
                                    20,
                                    CGRectGetWidth(abroad.contentView.bounds) - 40,
                                    CGRectGetHeight(abroad.contentView.bounds) - 40);
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:labelFrame];
        NSString *labelText = [NSString stringWithFormat:@"%@", content[@"info"]];
        [contentLabel setText:labelText];
        [contentLabel setNumberOfLines:0];
        [contentLabel sizeToFit];
        [abroad.contentView addSubview:contentLabel];
        [contentLabel release];

        abroad.titleLabel.text = dataSource[indexPath.row][@"name"];
        abroad.buyAction = ^(UIButton *sender) {
         DDBuyView *buyView = [[DDBuyView alloc] initWithFrame:CGRectZero productInfo:content];
         [kRootView addSubview:buyView];
         [buyView release];
        };
        [kRootView addSubview:abroad];
        [abroad release];
    }];
}

+ (void)handleFundShowDetailWithDataSource:(NSArray *)dataSource indexPath:(NSIndexPath *)indexPath
{
    [DDHTTPManager sendRequestForFundDetailtWithId:[NSString stringWithFormat:@"%@", dataSource[indexPath.row][@"id"]]
                                 completionHandler:^(id content, NSString *resultCode) {
         echo();
         NSArray *contents = @[
                               [NSString stringWithFormat:@"基金代码：%@", content[0][@"number"]],
                               [NSString stringWithFormat:@"基金简称：%@", content[0][@"productId"]],
                               [NSString stringWithFormat:@"单位净值：%@", content[0][@"accumulative_value"]],
                               [NSString stringWithFormat:@"累计净值：%@", content[0][@"asset_value"]],
                               [NSString stringWithFormat:@"截至日期：%@", content[0][@"stop_time"]],
                               ];
        DDFundShowDetail *fund = [[DDFundShowDetail alloc] initWithFrame:CGRectZero contents:contents];
        fund.titleLabel.text = dataSource[indexPath.row][@"name"];
        fund.buyAction = ^(UIButton *sender) {
            DDBuyView *buyView = [[DDBuyView alloc] initWithFrame:CGRectZero productInfo:content];
            [kRootView addSubview:buyView];
            [buyView release];
        };
        [kRootView addSubview:fund];
        [fund release];
     }];
}

+ (void)handleMetalShowDetailWithDataSource:(NSDictionary *)dataSource indexPath:(NSIndexPath *)indexPath
{

    [DDHTTPManager sendRequestForMetalDetailtWithId:[NSString stringWithFormat:@"%@", dataSource[@"id"]]
                                  completionHandler:^(id content, NSString *resultCode) {
      NSArray *contents = @[
                            [NSString stringWithFormat:@"成色：%@", dataSource[@"quality"]],
                            [NSString stringWithFormat:@"规格：%@", dataSource[@"scale"]],
                            [NSString stringWithFormat:@"发行量：%@", dataSource[@"circulation"]],
                            [NSString stringWithFormat:@"类别：%@", dataSource[@"typeName"]],
                            [NSString stringWithFormat:@"供应商：%@", dataSource[@"supplierName"]],
                            [NSString stringWithFormat:@"适宜人群：%@", dataSource[@"ageName"]]
                            ];
      DDMetalShowDetail *metal = [[DDMetalShowDetail alloc] initWithFrame:CGRectZero contents:contents];
      metal.titleLabel.text = dataSource[@"name"];
      metal.buyAction = ^(UIButton *sender) {
          DDBuyView *buyView = [[DDBuyView alloc] initWithFrame:CGRectZero productInfo:content];
          [kRootView addSubview:buyView];
          [buyView release];
      };
      [kRootView addSubview:metal];
      [metal release];
  }];
}

+ (void)handleInsureShowDetailWithDataSource:(NSArray *)dataSource indexPath:(NSIndexPath *)indexPath
{
    [DDHTTPManager sendRequestForInsureDetailtWithId:[NSString stringWithFormat:@"%@", dataSource[indexPath.row][@"id"]]
                                   completionHandler:^(id content, NSString *resultCode) {
       echo();
       NSArray *contents = @[
                             [NSString stringWithFormat:@"产品名称：%@", content[0][@"name"]],
                             [NSString stringWithFormat:@"产品属性：%@", content[0][@"characteristic"]],
                             [NSString stringWithFormat:@"发行公司：%@", content[0][@"company"]],
                             [NSString stringWithFormat:@"保险责任：%@", content[0][@"insured_liability"]],
                             [NSString stringWithFormat:@"适宜人群：%@岁客户", content[0][@"crowd_age"]],
                             [NSString stringWithFormat:@"保险期限：%@年", content[0][@"times"]]
                             ];
       DDInsureShowDetail *insure = [[DDInsureShowDetail alloc] initWithFrame:CGRectZero contents:contents];
       insure.titleLabel.text = dataSource[indexPath.row][@"name"];
       insure.buyAction = ^(UIButton *sender) {
           DDBuyView *buyView = [[DDBuyView alloc] initWithFrame:CGRectZero productInfo:content];
           [kRootView addSubview:buyView];
           [buyView release];
       };
       [kRootView addSubview:insure];
       [insure release];
   }];
}

@end
