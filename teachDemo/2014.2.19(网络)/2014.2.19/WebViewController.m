//
//  WebViewController.m
//  2014.2.19
//
//  Created by 张鹏 on 14-2-19.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate, UITextFieldDelegate> {
    
    UIWebView *_webView;
    UITextField *_textField;
    UIActivityIndicatorView *_activityIndicator;
}

- (void)initializeUserInterface;
- (void)barButtonPressed:(UIBarButtonItem *)sender;

// 根据指定网址加载网页
- (void)loadRequestWithURLString:(NSString *)URLString;

@end

@implementation WebViewController

- (id)init
{
    self = [super init];
    if (self) {
        
        self.title = @"网页视图";
        
    }
    return self;
}

- (void)dealloc {
    
    [_webView   release];
    [_textField release];
    [_activityIndicator release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initializeUserInterface];
}

- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.delegate = self;
    // 缩放内容以适应webView
    _webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];
    
    // 后退
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]
                                 initWithTitle:@"<"
                                 style:UIBarButtonItemStylePlain
                                 target:self
                                 action:@selector(barButtonPressed:)];
    backItem.tag = 10;
    
    // 向前
    UIBarButtonItem *nextItem = [[UIBarButtonItem alloc]
                                 initWithTitle:@">"
                                 style:UIBarButtonItemStylePlain
                                 target:self
                                 action:@selector(barButtonPressed:)];
    nextItem.tag = 11;
    
    // 刷新
    UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc]
                                    initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                    target:self
                                    action:@selector(barButtonPressed:)];
    refreshItem.tag = 12;
    
    self.navigationItem.leftBarButtonItems = @[backItem, nextItem];
    self.navigationItem.rightBarButtonItem = refreshItem;
    [backItem release];
    [nextItem release];
    [refreshItem release];
    
    _textField = [[UITextField alloc] init];
    _textField.bounds = CGRectMake(0, 0, 200, 25);
    _textField.delegate = self;
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.placeholder = @"输入网址";
    _textField.font = [UIFont systemFontOfSize:15];
    _textField.autocorrectionType = UITextAutocorrectionTypeNo;
    _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.navigationItem.titleView = _textField;
    
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicator.bounds = CGRectMake(0, 0, 30, 30);
    _activityIndicator.center = CGPointMake(CGRectGetMidX(self.view.bounds),
                                            CGRectGetMidY(self.view.bounds));
    [self.view addSubview:_activityIndicator];
    
    // 加载网页
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
//    // 开始加载
//    [_webView loadRequest:request];
    [self loadRequestWithURLString:@"www.baidu.com"];
}

- (void)barButtonPressed:(UIBarButtonItem *)sender {
    
    NSInteger index = sender.tag - 10;
    switch (index) {
            // 后退
        case 0: [_webView goBack]; break;
            // 前进
        case 1: [_webView goForward]; break;
            // 刷新
        case 2: [_webView reload]; break;
            
        default: break;
    }
}

- (void)loadRequestWithURLString:(NSString *)URLString {
    
    // 避免为空的输入
    if (URLString.length == 0) {
        return;
    }
    
    [_activityIndicator startAnimating];
    
    NSURL *url = [NSURL URLWithString:[@"http://" stringByAppendingString:URLString]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

#pragma mark - <UIWebViewDelegate>

// 开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    
}

// 加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [_activityIndicator stopAnimating];
    // 获取URL的字符串形式
    NSString *urlString = [webView.request.URL absoluteString];
    // 截取需要的网址部分
    _textField.text = [urlString stringByReplacingOccurrencesOfString:@"http://" withString:@""];
}

// 加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    NSLog(@"Web view load request failed with error message '%@'.", [error localizedDescription]);
}

#pragma mark - <UITextFieldDelegate>

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [self loadRequestWithURLString:textField.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    // 关闭键盘
    [textField resignFirstResponder];
    [self loadRequestWithURLString:textField.text];
    
    return YES;
}


@end





















