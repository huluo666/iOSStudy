//
//  AboutViewController.m
//  「UI」UITest
//
//  Created by 萧川 on 14-2-20.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController () <UIWebViewDelegate>

@property (nonatomic, retain) UIWebView *webView;

- (void)initUserInterface;

@end

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        UITabBarItem *tabBarItem = [[UITabBarItem alloc]
                                    initWithTitle:@"关于睿峰"
                                    image:[UIImage imageNamed:@"item5"]
                                    tag:15];
        self.tabBarItem = tabBarItem;
        [tabBarItem release];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self initUserInterface];
}

- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect frame = CGRectMake(0, 20, 320, CGRectGetHeight(self.view.frame));
    _webView = [[UIWebView alloc] initWithFrame:frame];
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];
    
    // 加载网页
    [self loadRequestWithURLString:@"www.rimiedu.com/"];
}

- (void)loadRequestWithURLString:(NSString *)URLString
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    if (!URLString || URLString.length == 0) {
        return;
    }
    NSURL *url = [NSURL URLWithString:[@"http://" stringByAppendingString:URLString]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

#pragma mark - UIWebViewDelegate

// 加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Request failed: %@", [error localizedDescription]);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

// 加载开始
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

// 加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
