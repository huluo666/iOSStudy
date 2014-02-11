//
//  WebImageView.m
//  LoadImage
//
//  Created by wei.chen on 13-1-10.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "WebImageView.h"

@implementation WebImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setURL:(NSURL *)url {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //设置请求方式
    [request setHTTPMethod:@"GET"];
    
    [request setURL:url];
    //设置超时时间
    [request setTimeoutInterval:60];

    self.data = [NSMutableData data];
    //发送一个异步请求
    [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark - NSURLConnection delegate
//数据加载过程中调用
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.data appendData:data];
}

//数据加载完成后调用
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    UIImage *image = [UIImage imageWithData:self.data];
    self.image = image;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"请求网络失败:%@",error);
}


@end
