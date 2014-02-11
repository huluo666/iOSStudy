//
//  WXHLDataService.h
//  WXMtime
//
//  Created by xiongbiao on 12-12-14.
//  Copyright (c) 2012年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LoadFinishBlock)(id result);

@interface WXHLDataService : NSObject

+ (void)setCookies;
+ (void)cleanCookies;

//password=123456&Version=3.3.0&inumeric=&longitude=116.221576&latitude=39.904182&Channel=ios%7C%7CiPhone%20OS%23%236.0.1%7C%7Cappstore%7C%7Cappstore_3.3.0&username=35965539%40qq.com
/**
 * 接口描述：登陆
 * 接口请求方式：POST
 * 接口url: index.php?act=logon
 * 接口参数: password   密码
            username    账户名
            Version   客户端版本         //3.3.0
            Channel    渠道             //ios||iPhone OS##6.0.1||appstore||appstore_3.3.0
            longitude  纬度 (可选)
            latitude  纬度  (可选)
 
 * 返回值：{
             "code" : 0,
             "ret" : {
                 "uid" : "63679626",
                 "userstatus" : 0,
                 "userinfo" : {
                     "nickname" : "昵称",
                     "url" : "头像url.jpg",
                     "gender" : 1,
                     "marriage" : 1,
                     "isRealname" : "0",
                     "city" : "861105",
                     "userLevel" : "\u666e\u901a\u4f1a\u5458",
                     "hongdou" : 0,
                     "longitude" : "116.221576",
                     "latitude" : "39.904182"
                 }
             }
          }
 **/
+ (void)login:(NSDictionary *)parmas competeBlock:(LoadFinishBlock)block;


/**
 * 接口描述：获取照片列表
 * 接口请求方式：POST
 * 接口url: photo.php?act=getPhotoList
 * 接口参数: Channel   渠道
            Version   版本
 */
+ (void)getPhotoList:(NSDictionary *)parmas competeBlock:(LoadFinishBlock)block;


@end
