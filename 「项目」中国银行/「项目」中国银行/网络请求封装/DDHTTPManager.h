//
//  DDHTTPManager.h
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-17.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDHTTPManager : NSObject

/*!
 *    请求登录用户
 *
 *    @param name       用户名
 *    @param password   密码
 *    @param completion 请求完成回调
 */
+ (void)sendRequstWithUsername:(NSString *)name
                      password:(NSString *)password
             completionHandler:(void(^)(id content, NSString *resultCode))completion;

/*!
 *    获取首页左上角图片
 *
 *    @param number     一个多少张
 *    @param completion 完成调用
 */
+ (void)sendRequstWithImagesTotalNumber:(NSString *)number
                   completionHandler:(void (^)(id content, NSString * resultCode))completion;

/*!
 *    获取首页右上角新闻
 *
 *    @param number     页码
 *    @param pageSize   页数
 *    @param completion 完成调用
 */
+ (void)sendRequstWithPageNumber:(NSString *)pageNumber
                        pageSize:(NSString *)pageSize
               completionHandler:(void (^)(id content, NSString * resultCode))completion;

// 获取首页右上角新闻详细内容
+ (void)sendRequestForLastNewsWithId:(NSString *)ID
                   completionHandler:(void (^)(id content, NSString * resultCode))completion;

/*!
 *    获取首页左下角热点新闻
 *    @param suerId     用户ID
 *    @param newsId     新闻ID
 *    @param completion 完成调用
 */
+ (void)sendRequstWithUserId:(NSString *)userId
                 totalNumber:(NSString *)totalNumber
           completionHandler:(void (^)(id content, NSString * resultCode))completion;

// 热门详细
+ (void)sendRequestForHotDetailWithId:(NSString *)ID
                    completionHandler:(void (^)(id content, NSString * resultCode))completion;

/*!
 *    获取首页右下角产品定制
 *
 *    @param userId      用户ID
 *    @param totalNumber 一共多少
 *    @param completion  完成调用
 */
+ (void)sendRequestForCustomProjectWithUserId:(NSString *)userId
                                  totalNumber:(NSString *)totalNumber
                            completionHandler:(void (^)(id content, NSString * resultCode))completion;

// 首页产品定制详细
+ (void)sendRequestForCustomProjecDetailtWithId:(NSString *)ID
                              completionHandler:(void (^)(id content, NSString * resultCode))completion;
// 政策咨询
+ (void)sendRequstWithPageSize:(NSString *)pageSize
                    pageNumber:(NSString *)pageNumber
                       byTitle:(NSString *)byTitle
                    byKeywords:(NSString *)byKeywords
             completionHandler:(void (^)(id content, NSString * resultCode))completion;

// 用于获取自选模式列表
+ (void)sendRequstForOptionalWithUserId:(NSString *)userId
                                 typeId:(NSString *)typeId
                             pageNumber:(NSString *)pageNumber
                               pageSize:(NSString *)pageSize
                      completionHandler:(void (^)(id content, NSString * resultCode))completion;

// 自选模式详细
+ (void)sendRequestForOptionalDetailtWithId:(NSString *)ID
                                     typeId:(NSString *)typeId
                          completionHandler:(void (^)(id content, NSString * resultCode))completion;

// 基金
+ (void)sendRequestForFundsWithUserId:(NSString *)userId
                           pageNumber:(NSString *)pageNumber
                             pageSize:(NSString *)pageSize
                    completionHandler:(void (^)(id content, NSString * resultCode))completion;

// 基金详细
+ (void)sendRequestForFundDetailtWithId:(NSString *)ID
                      completionHandler:(void (^)(id content, NSString * resultCode))completion;

// 贵金属
+(void)sendRequestForMetalWithUserId:(NSString *)userId
                          supplierId:(NSString *)supplierId
                           purposeId:(NSString *)purposeId
                               ageId:(NSString *)ageId
                              typeId:(NSString *)typeId
                            pageSize:(NSString *)pageSize
                             pageNum:(NSString *)pageNum
                   completionHandler:(void (^)(id content, NSString * resultCode))completion;

// 贵金属详情
+ (void)sendRequestForMetalDetailtWithId:(NSString *)ID
                      completionHandler:(void (^)(id content, NSString * resultCode))completion;


// 保险
+ (void)sendRequestFortInsureWithUserId:(NSString *)userId
                             pageNumber:(NSString *)pageNumber
                               pageSize:(NSString *)pageSize
                      completionHandler:(void (^)(id content, NSString * resultCode))completion;

// 保险详细
+ (void)sendRequestForInsureDetailtWithId:(NSString *)ID
                        completionHandler:(void (^)(id content, NSString * resultCode))completion;

@end
