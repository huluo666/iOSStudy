//
//  WebViewController.m
//  「UI」网络
//
//  Created by 萧川 on 14-2-19.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate, UITextFieldDelegate>

@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) UITextField *URLField;

- (void)initUserInterface;
- (void)barButtonPressed:(UIBarButtonItem *)sender;
// 根据指定网址加载网页
- (void)loadRequestWithURLString:(NSString *)URLString;

@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Web";
    }
    return self;
}

- (void)dealloc
{
    [_webView release];
    [_URLField release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self initUserInterface];
}

- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor whiteColor];
    _URLField = [[UITextField alloc] init];
    _URLField.bounds = CGRectMake(0, 0, 280, 30);
    _URLField.center = CGPointMake(CGRectGetMidX(self.view.frame) - 20, 64 + 16);
    _URLField.delegate = self;
    _URLField.placeholder = @"Please input url";
    _URLField.borderStyle = UITextBorderStyleRoundedRect;
    _URLField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _URLField.autocorrectionType = UITextAutocorrectionTypeNo;
    _URLField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.navigationItem.titleView = _URLField;
    [_URLField release];
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]
                                 initWithTitle:@"<"
                                 style:UIBarButtonItemStylePlain
                                 target:self
                                 action:@selector(barButtonPressed:)];
    backItem.tag = 10;
    
    UIBarButtonItem *nextItem = [[UIBarButtonItem alloc]
                                 initWithTitle:@">"
                                 style:UIBarButtonItemStylePlain
                                 target:self
                                 action:@selector(barButtonPressed:)];
    nextItem.tag = 11;
    
    UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc]
                                    initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                    target:self
                                    action:@selector(barButtonPressed:)];
    refreshItem.tag = 12;
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]
                                    initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                    target:self
                                    action:@selector(barButtonPressed:)];
    cancelItem.tag = 13;
    
    self.navigationItem.leftBarButtonItems = @[backItem, nextItem];
    self.navigationItem.rightBarButtonItems = @[refreshItem, cancelItem];
    
    // 加载网页
    [self loadRequestWithURLString:@"www.google.com/"];
}

- (void)barButtonPressed:(UIBarButtonItem *)sender
{
    NSInteger index = sender.tag - 10;
    NSLog(@"%ld", index);
    switch (index) {
        case 0:
            [_webView goBack];
            break;
        case 1:
            [_webView goForward];
            break;
        case 2:
            [_webView reload];
            break;
        case 3:
//            [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
            [_webView stopLoading];
            break;
        default:
            break;
    }
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
    // 获取URL字符串
    NSString *urlString = [webView.request.URL absoluteString];
    // 截取需要的网址部分
    _URLField.text = [urlString stringByReplacingOccurrencesOfString:@"@http://" withString:@""];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self loadRequestWithURLString:textField.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self loadRequestWithURLString:textField.text];
    return YES;
}

@end
