//
//  UIImageView+WebCach.m
//  LoadImage
//
//  Created by wei.chen on 13-1-10.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "UIImageView+WebCach.h"

@implementation UIImageView (WebCach)

- (void)setImageWithURL:(NSURL *)url {

    
    //-----------------NSURLConnection同步请求-----------------------
    //使用同步请求
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setHTTPMethod:@"GET"];
//    [request setURL:url];
//    [request setTimeoutInterval:60];
//    
//    NSURLResponse *response;
//    //发送同步请求
//    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
//    
//    UIImage *image = [UIImage imageWithData:data];
//    
//    self.image = image;
    
    //-----------------NSURLConnection异步请求-----------------------
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:url];
    [request setTimeoutInterval:60];
    
    //发送异步请求
//    [NSURLConnection connectionWithRequest:request delegate:self];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //发送异步请求
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse* respone, NSData* data, NSError* error){
                               //该block是多线程调用的
                               UIImage *image = [UIImage imageWithData:data];
                               
//                               [self performSelectorOnMainThread:@selector(<#selector#>) withObject:<#(id)#> waitUntilDone:<#(BOOL)#>];
                               
                               //跳到主线程上去操作UI
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   self.image = image;
                               });
                               
                           }];
    
}

//- (void)connection:(NSURLConnection *)connection
//    didReceiveData:(NSData *)data {
//    
//    
//    
//}



@end
