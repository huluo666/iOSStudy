//
//  WXHLDataService.m
//  WXMtime
//
//  Created by xiongbiao on 12-12-14.
//  Copyright (c) 2012年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "WXHLDataService.h"
#import "JSONKit.h"
#import "ASIFormDataRequest.h"

//base url
#define BASE_URL @"http://mi.baihe.com/"

@implementation WXHLDataService

+ (void)setCookies {
    NSString *cookiesPath = [NSHomeDirectory() stringByAppendingFormat:@"/Library/Cookies/Cookies.text"];
    NSMutableArray *cookies = [NSMutableArray arrayWithContentsOfFile:cookiesPath];
    [ASIHTTPRequest setSessionCookies:cookies];
}

+ (void)cleanCookies {
    [ASIHTTPRequest clearSession];
    NSString *cookiesPath = [NSHomeDirectory() stringByAppendingFormat:@"/Library/Cookies/Cookies.text"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:cookiesPath error:nil];
}


+ (void)login:(NSDictionary *)parmas competeBlock:(LoadFinishBlock)block {
    NSString *urlstring = [BASE_URL stringByAppendingFormat:@"index.php?act=logon"];
    [self startRequest:parmas url:urlstring isGet:NO competeBlock:block];
}

/**
 * 接口描述：获取照片列表
 * 接口请求方式：POST
 * 接口url: photo.php?act=getPhotoList
 * 接口参数: Channel   渠道
            Version   版本
 */
+ (void)getPhotoList:(NSDictionary *)parmas competeBlock:(LoadFinishBlock)block {
    NSString *urlstring = [BASE_URL stringByAppendingFormat:@"photo.php?act=getPhotoList"];
    [self startRequest:parmas url:urlstring isGet:NO competeBlock:block];    
}


+ (void)startRequest:(NSDictionary *)params
                 url:(NSString *)urlstring
               isGet:(BOOL)isGet
        competeBlock:(LoadFinishBlock)block
{
    NSLog(@"url:%@",urlstring);
    
    NSURL *url = [NSURL URLWithString:urlstring];
    __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setTimeOutSeconds:60];
    
    if (isGet) {
        [request setRequestMethod:@"GET"];
    } else {
        [request setRequestMethod:@"POST"];
        for (int i=0; i<params.count; i++) {
            NSArray *allkeys = [params allKeys];
            NSString *key = [allkeys objectAtIndex:i];
            NSString *value = [params objectForKey:key];
            [request addPostValue:value forKey:key];
        }
    }
    
    request.completionBlock = ^{
        NSLog(@"json: %@",request.responseString);
        
        NSData *data = request.responseData;
        UIDevice *device = [UIDevice currentDevice];
        float version = [device.systemVersion doubleValue];
        id ret = nil;
        if (version >= 5.0) {
            ret = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
        } else {
            ret = [data objectFromJSONData];
        }
    
        //回到block
        //这里使用了block，会将此block copy
        block(ret);
        
        NSString *lastPath = [urlstring lastPathComponent];
        if ([lastPath isEqualToString:@"index.php?act=logon"]) {
            NSMutableArray *cookies = ASIHTTPRequest.sessionCookies;
            NSString *cookiesPath = [NSHomeDirectory() stringByAppendingFormat:@"/Library/Cookies/Cookies.text"];
            BOOL ret = [cookies writeToFile:cookiesPath atomically:YES];
            if (ret) {
                NSLog(@"保存cookies成功");
            }
        }
        
    };

    request.failedBlock = ^{
        NSLog(@"网络请求错误：%@",request.error);
    };

    [request startAsynchronous];
}

//Content-Type   application/x-www-form-urlencoded; charset=utf-8


@end
