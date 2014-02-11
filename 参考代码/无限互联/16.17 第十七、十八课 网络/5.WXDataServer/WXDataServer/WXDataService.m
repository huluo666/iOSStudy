//
//  WXDataService.m
//  WXDataServer
//
//  Created by wei.chen on 13-1-10.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "WXDataService.h"
#import "WXRequest.h"
#import "NSString+URLEncoding.h"

#define BASE_URL @"http://www.weather.com.cn/data/sk/"

@implementation WXDataService

//访问天气预报接口数据
//http://www.weather.com.cn/data/sk/101010300.html
+ (void)getWetheaData:(NSDictionary *)params block:(Completion)block {
    
    NSString *cityCode = [params objectForKey:@"code"];
    NSString *urlstring = [BASE_URL stringByAppendingFormat:@"%@.html",cityCode];
    
    [self startRequest:params url:urlstring isGet:NO block:block];
}

+ (void)startRequest:(NSDictionary *)params
                 url:(NSString *)urlstring
               isGet:(BOOL)get
               block:(Completion)block {
    
    //url编码
    urlstring = [urlstring URLDecodedString];
    
    WXRequest *request = [WXRequest requestWithURL:[NSURL URLWithString:urlstring]];
    if (get) {
        [request setHTTPMethod:@"GET"];
    } else {
        [request setHTTPMethod:@"POST"];
        
        //拼接参数
        //username=wxhl&password=123456
        //将参数设置到请求体中
//        [request setHTTPBody:<#(NSData *)#>];
    }
    
    
    [request setTimeoutInterval:60];
    
    request.block = ^(NSData *data) {
        NSString *datastring = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"json:%@",datastring);
        
        //解析json
        id ret = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        block(ret);
    };
    
    [request startAsynrc];
}




@end
