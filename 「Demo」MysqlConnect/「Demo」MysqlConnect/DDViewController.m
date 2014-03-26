//
//  DDViewController.m
//  「Demo」MysqlConnect
//
//  Created by 萧川 on 14-3-25.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDViewController.h"
#import "ASIFormDataRequest.h"

@interface DDViewController ()

- (void)requestTest;

@end

@implementation DDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    [self requestTest];
}
 
- (void)requestTest
{
    NSURL *url = [NSURL URLWithString:@"http://192.243.119.92/cuan/request.php"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    NSDictionary *userLoginInfos = @{@"user_name":@"amdin", @"pass_word":@"admin"};
    
    [request setPostValue:userLoginInfos forKey:@"login"];
    [request startSynchronous];
    
    NSData *responseData = request.responseData;
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    
    NSLog(@"-------ok get %@", responseString);
    [responseString release];
}

@end
