//
//  RequestViewController.m
//  2014.2.19
//
//  Created by 张鹏 on 14-2-19.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "RequestViewController.h"

#define GET_REQUEST_URL [NSString stringWithFormat:@"http://api.jiepang.com/v1/locations/search?lat=%f&lon=%f&source=100000&count=50",30.575413,104.064359]
#define POST_REQUEST_URL @"http://125.70.10.34:8119/ggc/api.php"

@interface RequestViewController () <UITableViewDataSource, NSURLConnectionDataDelegate, NSURLConnectionDelegate> {
    
    UITableView *_tableView;
    NSMutableArray *_dataSource;
    NSMutableData *_responseData; // 请求完成数据
    
    UIActivityIndicatorView *_activityIndicator;
    
    NSString *_requestMethod;
}

- (void)initializeDataSource;
- (void)initializeUserInterface;

// 发起同步请求
- (void)startSynchronousRequestWithMethodName:(NSString *)method;
// 发起异步请求
- (void)startAsynchronousRequestWithMethodName:(NSString *)method;

// 请求完成，刷新界面
- (void)updateUserInterface;

@end

@implementation RequestViewController

- (id)init
{
    self = [super init];
    if (self) {
        
        self.title = @"网络请求及解析";
        
    }
    return self;
}

- (void)dealloc {
    
    [_tableView    release];
    [_dataSource   release];
    [_responseData release];
    [_activityIndicator release];
    [_requestMethod release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initializeDataSource];
    [self initializeUserInterface];
    
    // 同步请求
//    [self startSynchronousRequestWithMethodName:POST_REQUEST_URL];
    // 异步请求
    [self startAsynchronousRequestWithMethodName:POST_REQUEST_URL];
}

- (void)initializeDataSource {
    
    _dataSource = [[NSMutableArray alloc] init];
    _responseData = [[NSMutableData alloc] init];
}

- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    // 初始化进度指示器
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicator.bounds = CGRectMake(0, 0, 30, 30);
    _activityIndicator.center = CGPointMake(CGRectGetMidX(self.view.bounds),
                                            CGRectGetMidY(self.view.bounds));
    [self.view addSubview:_activityIndicator];
}

- (void)startSynchronousRequestWithMethodName:(NSString *)method {
    
    [_activityIndicator startAnimating];
    
    _requestMethod = [method copy];
    
    // 请求地址
    NSURL *url = [NSURL URLWithString:method];
    // 请求配置
    NSURLRequest *request = nil;
    // GET请求
    if ([_requestMethod isEqualToString:GET_REQUEST_URL]) {
        request = [NSURLRequest requestWithURL:url];
    }
    // POST请求
    else {
        // 发送字符串数据
        // 格式：key1=value1&key2=value2&key3=value3......
        NSString *bodyString = @"g=ApiGGC&m=Public&c=getConstantList";
        
        request = [NSMutableURLRequest requestWithURL:url];
        // 配置HTTP请求方法，默认是@"GET"
        [(NSMutableURLRequest *)request setHTTPMethod:@"POST"];
        // 配置请求超时时间
        [(NSMutableURLRequest *)request setTimeoutInterval:10.0];
        // 配置发送的数据
        [(NSMutableURLRequest *)request setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    NSError *error = nil;
    // 发起同步请求
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:nil
                                                     error:&error];
    // 请求成功
    if (!error) {
        // 拼接数据，获取数据
        [_responseData appendData:data];
        // 刷新界面
        [self updateUserInterface];
    }
    // 请求失败
    else {
        NSLog(@"Request failed with error message '%@'.", [error localizedDescription]);
    }
    
    [_activityIndicator stopAnimating];
}

- (void)startAsynchronousRequestWithMethodName:(NSString *)method {
    
    [_activityIndicator startAnimating];
    
    // 记录请求接口，请求类型
    _requestMethod = [method copy];
    
    NSURL *url = [NSURL URLWithString:method];
    NSURLRequest *request = nil;
    // GET请求
    if ([_requestMethod isEqualToString:GET_REQUEST_URL]) {
        request = [NSURLRequest requestWithURL:url];
    }
    // POST请求
    else {
        NSString *bodyString = @"g=ApiGGC&m=Public&c=getConstantList";
        
        request = [NSMutableURLRequest requestWithURL:url];
        // 配置请求方法
        [(NSMutableURLRequest *)request setHTTPMethod:@"POST"];
        // 配置请求超时时长
        [(NSMutableURLRequest *)request setTimeoutInterval:10.0];
        // 配置上传数据
        [(NSMutableURLRequest *)request setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    }
    // 发起异步请求
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)updateUserInterface {
    
    // NSUTF8StringEncoding：字符串编码格式，保证中文无乱码
//    NSString *responseString = [[NSString alloc] initWithData:_responseData
//                                                     encoding:NSUTF8StringEncoding];
//    NSLog(@"%@", responseString);
//    [responseString release];
    
    // JSON字符串解析为对象类型
    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:_responseData
                                                options:NSJSONReadingMutableLeaves
                                                  error:&error];
    // 字典格式JSON
    if ([object isKindOfClass:[NSDictionary class]]) {
        
        // GET
        if ([_requestMethod isEqualToString:GET_REQUEST_URL]) {
            [_dataSource addObjectsFromArray:object[@"items"]];
        }
        // POST
        else {
            NSLog(@"%@", object);
            [_dataSource addObjectsFromArray:[object[@"content"] objectForKey:@"relation_type_list"]];
        }
//        NSLog(@"%@", _dataSource);
        // 刷新表视图
        [_tableView reloadData];
    }
    // 数组格式JSON
    else if ([object isKindOfClass:[NSArray class]]){
        // ......
    }
}

#pragma mark - <NSURLConnectionDataDelegate, NSURLConnectionDelegate>

// 请求完成
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    [_activityIndicator stopAnimating];
    // 请求完成，刷新界面
    [self updateUserInterface];
}

// 获取到数据或者部分数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    // 请求返回数据拼接
    [_responseData appendData:data];
}

// 请求失败
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    [_activityIndicator stopAnimating];
    NSLog(@"Request failed with error message '%@'.", [error localizedDescription]);
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier] autorelease];
    }
    
    NSString *title = nil;
    NSString *subTitle = nil;
    if ([_requestMethod isEqualToString:GET_REQUEST_URL]) {
        title = [_dataSource[indexPath.row] objectForKey:@"name"];
        subTitle = [_dataSource[indexPath.row] objectForKey:@"addr"];
    }
    else {
        title = [_dataSource[indexPath.row] objectForKey:@"name"];
        subTitle = [_dataSource[indexPath.row] objectForKey:@"key"];
    }
    // 名称
    cell.textLabel.text = title;
    // 地址
    cell.detailTextLabel.text = subTitle;
    
    return cell;
}

@end
















