//
//  DDHTTPManager.m
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-17.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDHTTPManager.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "DDConstant.h"
#import "MyMD5.h"

@interface DDHTTPManager ()

/*!
 *    发起异步网络请求
 *
 *    @param URLString  URL
 *    @param params     请求信息字典
 *    @param completion 请求完成后处理
 */
+ (void)startAsynchronousRequestWithURLString:(NSString *)URLString
                                       params:(NSDictionary *)params
                            completionHandler:(void (^)(id content, NSString *resultCode))completion;

/*!
 *    data --> JSON
 *
 *    @param data 需要转换格式的数据
 *
 *    @return 转换为JSON后的数据
 */
+ (id)JSONObjectWithData:(NSData *)data;

/*!
 *    JSON --> data
 *
 *    @param object 需要装换的JSON数据
 *
 *    @return 装换为data后的数据
 */
+ (NSData *)dataWithJSONObject:(id)object;

@end

@implementation DDHTTPManager

+ (void)startAsynchronousRequestWithURLString:(NSString *)URLString
                                       params:(NSDictionary *)params
                            completionHandler:(void (^)(id content, NSString *resultCode))completion
{
    if (0 == URLString.length) {
        return;
    }
    
    // 初始化ASIHTTP
    NSURL *url = [NSURL URLWithString:URLString];
    __block ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url];
    // 设置POST方式
    request.requestMethod = @"POST";
    // 非安全方式
    request.validatesSecureCertificate = NO;
    // 超时时长
    request.timeOutSeconds = 10;
    // 默认编码
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    // 传送的数据
    /* 将用户发来的字典打包为JSON格式的字符串 */
    NSString *string = [params JSONRepresentation];
    // 传输数据
    [request setPostValue:string forKey:kJSONParamKey];
    // 开启异步请求
    [request startAsynchronous];
    // 完成调用
    [request setCompletionBlock:^{
        // 接收数据
        NSData *responseData = [request responseData];
        NSString *stringData = [[NSString alloc] initWithData:responseData
                                                     encoding:NSUTF8StringEncoding];
        /* 将接收的JSON数据转为字典 */
        id contentID = [stringData JSONValue];
        if ([contentID isKindOfClass:[NSDictionary class]]) {
            id content = contentID[kContentKey];
            NSString *resultCode = contentID[kResultCodeKey];
            completion(content, resultCode);
        }
        [stringData release];
        [request release];
    }];
    // 请求失败
    [request setFailedBlock:^{
        NSLog(@"HTTP Request failed !");
        [request clearDelegatesAndCancel];
        completion(@"",@"0");
        [request release];
    }];
}

+ (id)JSONObjectWithData:(NSData *)data
{
    if (!data) {
        return nil;
    }
    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:data
                                                options:NSJSONReadingMutableLeaves
                                                  error:&error];
    NSAssert(error, @"Deserialized JSON string failed with error message '%@'.",
             [error localizedDescription]);
    
    return object;
}

+ (NSData *)dataWithJSONObject:(id)object
{
    if (!object) {
        return nil;
    }
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:object
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&error];
    NSAssert(error, @"Serialized JSON string failed with error message '%@'.",
             [error localizedDescription]);

    return data;
}


// 请求用户名密码
+ (void)sendRequstWithUsername:(NSString *)name
                      password:(NSString *)password
             completionHandler:(void(^)(id content, NSString *resultCode))completion;
{
    NSMutableDictionary *dict = [@{} mutableCopy];
    [dict setObject:name forKey:kUsernameKey];
    NSString *md5Password = [MyMD5 md5:password];
    [dict setObject:md5Password forKey:kPasswordKey];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBaseRoot, kLogin];
    [self startAsynchronousRequestWithURLString:urlString
                                         params:dict
                              completionHandler:completion];
    
    [dict release];
}

// 非加密传输方式
+ (void)sendRequstWithArguments:(NSArray *)arguments
                           keys:(NSArray *)keys
                URLModuleString:(NSString *)URLModuleString
              completionHandler:(void (^)(id content, NSString * resultCode))completion
{
    if (arguments.count != keys.count) {
        return;
    }
    
    NSMutableDictionary *dict = [@{} mutableCopy];
    for (int i = 0; i < arguments.count; i++) {
        [dict setObject:arguments[i] forKey:keys[i]];
    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBaseRoot, URLModuleString];
    [self startAsynchronousRequestWithURLString:urlString
                                         params:dict
                              completionHandler:completion];
    [dict release];
}

// 首页展示图片
+ (void)sendRequstWithImagesTotalNumber:(NSString *)number
                   completionHandler:(void (^)(id content, NSString * resultCode))completion
{
    [self sendRequstWithArguments:@[number]
                             keys:@[kTotalNumberKey]
                  URLModuleString:kRecentProductsList
                completionHandler:completion];
}

// 首页最新动态
+ (void)sendRequstWithPageNumber:(NSString *)pageNumber
                        pageSize:(NSString *)pageSize
               completionHandler:(void (^)(id content, NSString * resultCode))completion
{
    [self sendRequstWithArguments:@[pageNumber, pageSize]
                             keys:@[kPageNumKey, kPageSize]
                  URLModuleString:kRecentNewsList
                completionHandler:completion];
}

// 首页热点新闻
+ (void)sendRequstWithUserId:(NSString *)userId
                 totalNumber:(NSString *)totalNumber
           completionHandler:(void (^)(id content, NSString * resultCode))completion
{
    [self sendRequstWithArguments:@[userId, totalNumber]
                             keys:@[kUserID, kTotalNum]
                  URLModuleString:kHotProductList
                completionHandler:completion];
}

@end














