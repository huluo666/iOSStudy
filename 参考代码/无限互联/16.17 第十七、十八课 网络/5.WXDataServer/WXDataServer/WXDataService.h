//
//  WXDataService.h
//  WXDataServer
//
//  Created by wei.chen on 13-1-10.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Completion)(id);

@interface WXDataService : NSObject

//访问天气预报接口数据
+ (void)getWetheaData:(NSDictionary *)params block:(Completion)block;

//+ (void)loadMovie:

@end
