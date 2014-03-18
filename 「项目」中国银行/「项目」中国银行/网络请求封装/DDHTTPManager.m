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
#import "ASIDownloadCache.h"

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


@end

@implementation DDHTTPManager

// 异步请求
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

    // cache
    NSString *cachePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    ASIDownloadCache *cache = [[ASIDownloadCache alloc] init];
    [cache setStoragePath:cachePath];
    cache.defaultCachePolicy = ASIOnlyLoadIfNotCachedCachePolicy;
    request.cacheStoragePolicy = ASICachePermanentlyCacheStoragePolicy;
    request.downloadCache = cache;
    [cache release];
    
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

#pragma mark - 登录

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


#pragma mark - 首页

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
                             keys:@[kPageNumKey, kPageSizeKey]
                  URLModuleString:kRecentNewsList
                completionHandler:completion];
}

// 首页热点新闻
+ (void)sendRequstWithUserId:(NSString *)userId
                 totalNumber:(NSString *)totalNumber
           completionHandler:(void (^)(id content, NSString * resultCode))completion
{
    [self sendRequstWithArguments:@[userId, totalNumber]
                             keys:@[kUserIDKey, kTotalNumberKey]
                  URLModuleString:kHotProductList
                completionHandler:completion];
}

// 首页产品定制
+ (void)sendRequestForCustomProjectWithUserId:(NSString *)userId
                                  totalNumber:(NSString *)totalNumber
                            completionHandler:(void (^)(id content, NSString * resultCode))completion
{
    [self sendRequstWithArguments:@[userId, totalNumber]
                             keys:@[kUserIDKey, kTotalNumberKey]
                  URLModuleString:kCustomizationList
                completionHandler:completion];
}

#pragma mark - 出国服务

// 政策咨询
+ (void)sendRequstWithPageSize:(NSString *)pageSize
                    pageNumber:(NSString *)pageNumber
                       byTitle:(NSString *)byTitle
                    byKeywords:(NSString *)byKeywords
             completionHandler:(void (^)(id content, NSString * resultCode))completion
{
    [self sendRequstWithArguments:@[pageSize, pageNumber, byTitle, byKeywords]
                             keys:@[kPageSizeKey, kPageNumKey, kByTitleKey, kByKeywordsKey]
                  URLModuleString:kPolicyAdviceList
                completionHandler:completion];
}

// 自选模式
+ (void)sendRequstForOptionalWithUserId:(NSString *)userId
                                 typeId:(NSString *)typeId
                             pageNumber:(NSString *)pageNumber
                               pageSize:(NSString *)pageSize
                      completionHandler:(void (^)(id content, NSString * resultCode))completion
{
    [self sendRequstWithArguments:@[userId, typeId, pageNumber, pageSize]
                             keys:@[kUserIDKey, kTypeIdKey, kPageNumKey, kPageSizeKey]
                  URLModuleString:kOptionalList
                completionHandler:completion];
}

#pragma mark - 理财产品

// 基金
+ (void)sendRequestForFundsWithUserId:(NSString *)userId
                           pageNumber:(NSString *)pageNumber
                             pageSize:(NSString *)pageSize
                    completionHandler:(void (^)(id content, NSString * resultCode))completion
{
    [self sendRequstWithArguments:@[userId, pageNumber, pageSize]
                             keys:@[kUserIDKey, kPageNumKey, kPageSizeKey]
                  URLModuleString:kFundList
                completionHandler:completion];
}

// 贵金属
+(void)sendRequestForMetalWithUserId:(NSString *)userId
                          supplierId:(NSString *)supplierId
                           purposeId:(NSString *)purposeId
                               ageId:(NSString *)ageId
                              typeId:(NSString *)typeId
                            pageSize:(NSString *)pageSize
                             pageNum:(NSString *)pageNum
                   completionHandler:(void (^)(id content, NSString * resultCode))completion
{
    [self sendRequstWithArguments:@[userId, supplierId, purposeId, ageId, typeId, pageSize, pageNum]
                             keys:@[kUserIDKey, kSupplierIdKey, kPurposeIdKey, kAgeIdKey ,kTypeIdKey, kPageSizeKey, kPageNumKey]
                  URLModuleString:kMetalsList
                completionHandler:completion];
}

// 保险
+ (void)sendRequestFortInsureWithUserId:(NSString *)userId
                             pageNumber:(NSString *)pageNumber
                               pageSize:(NSString *)pageSize
                      completionHandler:(void (^)(id content, NSString * resultCode))completion
{
    [self sendRequstWithArguments:@[userId, pageNumber, pageSize]
                             keys:@[kUserIDKey, kPageNumKey, kPageSizeKey]
                  URLModuleString:kInsureList
                completionHandler:completion];
}
@end














