//
//  AppDelegate.m
//  ASIDowloadFile
//
//  Created by wei.chen on 13-1-11.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "AppDelegate.h"
#import "ASIHTTPRequest.h"
#import "Reachability.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self action:@selector(downloadAction) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(150, 30, 80, 30);
    [button setTitle:@"下载" forState:UIControlStateNormal];
    [self.window addSubview:button];
    
    
    //kReachabilityChangedNotification 网络状态改变时触发的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNetwork:) name:kReachabilityChangedNotification object:nil];
    
    self.reachability = [Reachability reachabilityForInternetConnection];
    //开始监听网络
    [self.reachability startNotifier];
    
    NetworkStatus status = self.reachability.currentReachabilityStatus;
    [self checkNetWork:status];
    
    return YES;
}

- (void)downloadAction {
    //---------------------ASI下载--------------------
    UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    progressView.frame = CGRectMake(50, 100, 200, 20);
    [self.window addSubview:progressView];
    
    //通过kvo监听progress值，达到监听进度的目的
    [progressView addObserver:self forKeyPath:@"progress" options:NSKeyValueObservingOptionNew context:nil];
    
    
    NSString *urlstring = @"http://free2.macx.cn:81/tools/system/CleanMyMac-v1-10-8.dmg";
    NSString *documents = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *fileName = [urlstring lastPathComponent];
    NSString *path = [documents stringByAppendingPathComponent:fileName];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlstring]];
    [request setHeadersReceivedBlock:^(NSDictionary *responseHeaders){
        //响应头
//        NSDictionary *responseHeaders = request.responseHeaders;
        NSLog(@"%@",responseHeaders);
        
        //获取下载文件大小
        NSNumber *contentSize = [responseHeaders objectForKey:@"Content-Length"];
    }];
    
    //设置文件下载存放的路径
    [request setDownloadDestinationPath:path];
    //设置进度条
    request.downloadProgressDelegate = progressView;
    
    //------------------------断点续传-----------------------
    //设置是否支持断点续传
    [request setAllowResumeForFileDownloads:YES];
    NSString *tempPath = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp/cache.download"];
    //设置下载过程中暂存的文件路径
    [request setTemporaryFileDownloadPath:tempPath];
    [request startAsynchronous];
}


- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context {
//    NSLog(@"%@",change);
    NSNumber *value = [change objectForKey:@"new"];
    float progress = [value floatValue];
    NSLog(@"%.1f%%",progress*100);
}

//网络状态改变的时候调用
- (void)changeNetwork:(NSNotification *)notification {
    NetworkStatus status = self.reachability.currentReachabilityStatus;
    [self checkNetWork:status];
}

- (void)checkNetWork:(NetworkStatus)status {
    if (status == kNotReachable) {
        NSLog(@"没有网络");
    }
    else if(status == kReachableViaWWAN) {
        NSLog(@"3G/2G");
    }
    else if(status == kReachableViaWiFi) {
        NSLog(@"WIFI");
    }
}

@end
