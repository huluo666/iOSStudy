//
//  DDHTTPManager.m
//  「Demo」MysqlConncet
//
//  Created by 萧川 on 14-3-25.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDHTTPManager.h"

@interface DDHTTPManager () <NSURLConnectionDataDelegate, NSURLConnectionDelegate>

@property (strong, nonatomic) NSMutableData *responseData;
@property (strong, nonatomic) void (^completionHandler)(BOOL success, id content);

// Create a Foundation object from JSON data
+ (id)JSONObjectWithData:(NSData *)data;
// Generate JSON data from a Foundation object
+ (NSData *)dataWithJSONObject:(id)object;

@end

static DDHTTPManager *DDHTTPManagerInstance = nil;

@implementation DDHTTPManager

- (id)init
{
    self = [super init];
    if (self) {
        
        _responseData = [[NSMutableData alloc] init];
        
    }
    return self;
}

// Create a Foundation object from JSON data
+ (id)JSONObjectWithData:(NSData *)data
{
    if (!data) {
        return nil;
    }
    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:data
                                                options:NSJSONReadingMutableLeaves
                                                  error:&error];
    if (error) {
        NSLog(@"Deserialized JSON string failed with error message '%@'.",
              [error localizedDescription]);
    }
    
    return object;
}

// Generate JSON data from a Foundation object
+ (NSData *)dataWithJSONObject:(id)object
{
    if (!object) {
        return nil;
    }
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:object
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&error];
    if (error) {
        NSLog(@"Serialized JSON string failed with error message '%@'.",
              [error localizedDescription]);
    }
    return data;
}

// Synchronous network request
+ (void)startSynchronousRequestWithURLString:(NSString *)URLString
                                      params:(NSDictionary *)params
                           completionHandler:(void (^)(BOOL, id))completion
{
    if (0 == URLString.length) {
        return;
    }
    
    // init request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:
                                    [NSURL URLWithString:URLString]];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 10.0;
    
    // convert to json data
    NSData *jsonData = [self dataWithJSONObject:params];
    NSString *string = [[NSString alloc] initWithData:jsonData
                                             encoding:NSUTF8StringEncoding];
    NSString *rpostString = [NSString stringWithFormat:@"paramJson=%@", string];
    
    // setup httpbody string
    request.HTTPBody = [rpostString dataUsingEncoding:NSUTF8StringEncoding];
    
    // receive response data
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request
                                                 returningResponse:nil
                                                             error:&error];
    if (!error) {
        NSDictionary *dict = [self JSONObjectWithData:responseData];
        BOOL sucess = [dict[@"code"] integerValue] == 1 ? YES : NO;
        completion(sucess, dict[@"content"]);
    } else {
        completion(NO, [error localizedDescription]);
    }
}

// Asynchronous network request
+ (void)startAsynchronousRequestWithURLString:(NSString *)URLString
                                       params:(NSDictionary *)params
                            completionHandler:(void (^)(BOOL, id))completion
{
    if (URLString.length == 0) {
        return;
    }
    
    // setup completion handler
    if (!DDHTTPManagerInstance) {
        DDHTTPManagerInstance = [[DDHTTPManager alloc] init];
    }
    DDHTTPManagerInstance.completionHandler = completion;

    // convert to json data
    NSData *jsonData = [self dataWithJSONObject:params];
    NSString *string = [[NSString alloc] initWithData:jsonData
                                             encoding:NSUTF8StringEncoding];
    
    NSString *rpostString = [NSString stringWithFormat:@"paramJson=%@", string];
    
    // receive response data
    NSData *requestData = [rpostString dataUsingEncoding:NSUTF8StringEncoding];
    
    // init request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10];
    request.HTTPMethod = @"POST";
    [request setHTTPBody: requestData];
    
    [NSURLConnection connectionWithRequest:request delegate:DDHTTPManagerInstance];
}


#pragma mark - <NSURLConnectionDataDelegate, NSURLConnectionDelegate>

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary *dict = [DDHTTPManager JSONObjectWithData:_responseData];
    BOOL success = [dict[@"code"] integerValue] == 1 ? YES : NO;
    _completionHandler(success, dict[@"content"]);
    _responseData.length = 0;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    _completionHandler(NO, [error localizedDescription]);
}

@end
