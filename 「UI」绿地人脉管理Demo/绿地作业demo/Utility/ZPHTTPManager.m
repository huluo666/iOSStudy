//
//  ZPHTTPManager.m
//  绿地作业demo
//
//  Created by 张鹏 on 14-2-18.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "ZPHTTPManager.h"

static ZPHTTPManager * ZPHTTPManagerReusableInstance = nil;

@interface ZPHTTPManager () {
    
    NSMutableData *_responseData;
    void (^_completionHandler)(BOOL success, id content);
}

@property (copy, nonatomic) void (^completionHandler)(BOOL success, id content);

@end

@implementation ZPHTTPManager

- (id)init
{
    self = [super init];
    if (self) {
        
        _responseData = [[NSMutableData alloc] init];
        
    }
    return self;
}

+ (void)startSynchronousRequestWithURLString:(NSString *)URLString
                                      params:(NSDictionary *)params
                           completionHandler:(void (^)(BOOL, id))completion {
    
    if (URLString.length == 0) {
        return;
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 10.0;
    
    NSMutableString *postString = [NSMutableString stringWithString:@"g=ApiGGC"];
    for (NSString *key in params) {
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", key, [params objectForKey:key]]];
    }
    request.HTTPBody = [postString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (!error) {
        NSDictionary *dict = [self JSONObjectWithData:responseData];
        BOOL sucess = [dict[@"code"] integerValue] == 1 ? YES : NO;
        completion(sucess, dict[@"content"]);
    }
    else {
        completion(NO, [error localizedDescription]);
    }
}

+ (void)startAsynchronousRequestWithURLString:(NSString *)URLString
                                       params:(NSDictionary *)params
                            completionHandler:(void (^)(BOOL, id))completion {
    
    if (URLString.length == 0) {
        return;
    }
    
    if (!ZPHTTPManagerReusableInstance) {
        ZPHTTPManagerReusableInstance = [[ZPHTTPManager alloc] init];
    }
    ZPHTTPManagerReusableInstance.completionHandler = completion;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 10.0;
    
    NSMutableString *postString = [NSMutableString stringWithString:@"g=ApiGGC"];
    for (NSString *key in params) {
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", key, [params objectForKey:key]]];
    }
    request.HTTPBody = [postString dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection connectionWithRequest:request delegate:ZPHTTPManagerReusableInstance];
}

+ (id)JSONObjectWithData:(NSData *)data {
    
    if (!data) {
        return nil;
    }
    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:data
                                                options:NSJSONReadingMutableLeaves
                                                  error:&error];
    if (error) {
        NSLog(@"Deserialized JSON string failed with error message '%@'.", [error localizedDescription]);
    }

    return object;
}

+ (NSData *)dataWithJSONObject:(id)object {
    
    if (!object) {
        return nil;
    }
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:object
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&error];
    if (error) {
        NSLog(@"Serialized JSON string failed with error message '%@'.", [error localizedDescription]);
    }
    return data;
}

#pragma mark - <NSURLConnectionDataDelegate, NSURLConnectionDelegate>

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [_responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSDictionary *dict = [ZPHTTPManager JSONObjectWithData:_responseData];
    BOOL sucess = [dict[@"code"] integerValue] == 1 ? YES : NO;
    _completionHandler(sucess, dict[@"content"]);
    _responseData.length = 0;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    _completionHandler(NO, [error localizedDescription]);
}

@end
