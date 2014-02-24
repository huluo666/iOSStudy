//
//  ZPHTTPManager.h
//  绿地作业demo
//
//  Created by 张鹏 on 14-2-18.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZPHTTPManager : NSObject <NSURLConnectionDataDelegate, NSURLConnectionDelegate>

+ (void)startSynchronousRequestWithURLString:(NSString *)URLString
                                      params:(NSDictionary *)params
                           completionHandler:(void (^)(BOOL sucess, id content))completion;

+ (void)startAsynchronousRequestWithURLString:(NSString *)URLString
                                       params:(NSDictionary *)params
                            completionHandler:(void (^)(BOOL sucess, id content))completion;

@end
