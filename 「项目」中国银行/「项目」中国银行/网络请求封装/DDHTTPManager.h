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
 *    获取首页右上角图片
 *
 *    @param number     页码
 *    @param pageSize   页数
 *    @param completion 完成调用
 */
+ (void)sendRequstWithPageNumber:(NSString *)pageNumber
                        pageSize:(NSString *)pageSize
               completionHandler:(void (^)(id content, NSString * resultCode))completion;

/*!
 *    获取首页左下角热点新闻
 *
 *    @param newsId     新闻ID
 *    @param completion 完成调用
 */
+ (void)sendRequstWithUserId:(NSString *)userId
                 totalNumber:(NSString *)totalNumber
           completionHandler:(void (^)(id content, NSString * resultCode))completion;
@end
