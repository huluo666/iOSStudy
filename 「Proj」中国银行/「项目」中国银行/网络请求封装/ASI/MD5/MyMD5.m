//
//  MyMD5.m
//  GoodLectures
//
//  Created by yangshangqing on 11-10-11.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MyMD5.h"
#import "CommonCrypto/CommonDigest.h"
/*
 在登录和注册的时候，把用户输入的密码 用MD5加密 保存在数据库或者文件里 可以防止密码泄露
 MD5值是唯一的 所以直接用MD5值来比较输入就可以验证登录密码了
*/
@implementation MyMD5
//将字符串进行MD5加密，返回加密后的字符串
+(NSString *) md5: (NSString *) inPutText 
{
    const char *cStr = [inPutText UTF8String];////转换成utf-8
    unsigned char result[CC_MD5_DIGEST_LENGTH];//开辟一个16字节（128位：md5加密出来就是128位/bit）的空间（一个字节=8字位=8个二进制数）
    CC_MD5(cStr, strlen(cStr), result);
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}
@end
