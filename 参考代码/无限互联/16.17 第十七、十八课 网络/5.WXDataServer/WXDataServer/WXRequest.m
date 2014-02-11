//
//  WXRequest.m
//  WXDataServer
//
//  Created by wei.chen on 13-1-10.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "WXRequest.h"

@implementation WXRequest

- (void)startAsynrc {
    
    self.data = [NSMutableData data];
    
    //发送异步请求
    self.connection = [NSURLConnection connectionWithRequest:self delegate:self];
}

- (void)cancel {
    [self.connection cancel];
}


#pragma mark - NSURLConnection delegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    self.block(_data);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"请求网络出错：%@",error);
}


@end
