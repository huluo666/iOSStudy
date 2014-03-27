//
//  DDHTTPManager.h
//  「Demo」MysqlConncet
//
//  Created by 萧川 on 14-3-25.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDHTTPManager : NSObject

/**
 *  发起同步网络请求
 *
 *  @param URLString  请求地址
 *  @param params     发送的参数字典
 *  @param completion 完成回掉
 */
+ (void)startSynchronousRequestWithURLString:(NSString *)URLString
                                      params:(NSDictionary *)params
                           completionHandler:(void (^)(BOOL sucess, id content))completion;

/**
 *  发起异步网络请求
 *
 *  @param URLString  请求地址
 *  @param params     发送的参数字典
 *  @param completion 完成回调
 */
+ (void)startAsynchronousRequestWithURLString:(NSString *)URLString
                                       params:(NSDictionary *)params
                            completionHandler:(void (^)(BOOL sucess, id content))completion;

@end
