//
//  WXRequest.h
//  WXDataServer
//
//  Created by wei.chen on 13-1-10.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^FinishLoadBlock)(NSData *);

@interface WXRequest : NSMutableURLRequest<NSURLConnectionDataDelegate>

@property(nonatomic,retain)NSMutableData *data;
@property(nonatomic,retain)NSURLConnection *connection;
@property(nonatomic,copy)FinishLoadBlock block;

//开始异步请求
- (void)startAsynrc;

//取消异步请求
- (void)cancel;

@end
