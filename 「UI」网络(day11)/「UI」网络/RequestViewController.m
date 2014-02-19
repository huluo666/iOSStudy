//
//  RootViewController.m
//  「UI」网络
//
//  Created by 萧川 on 14-2-19.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "RequestViewController.h"

@interface RequestViewController () <
    UITableViewDataSource,
    UITableViewDelegate,
    NSURLConnectionDataDelegate,
    NSURLConnectionDelegate>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *dataSource;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) UIActivityIndicatorView *indicator;
@property (nonatomic, retain) NSString *requestMethod;

- (void)initDataSource;
- (void)initUserInterface;

// 发起同步请求
- (void)startSynchronousRequestWithMethoName:(NSString *)method;
// 发起异步请求
- (void)startAsynchronousRequestWithMethoName:(NSString *)method;
// 请求完成,刷新界面
- (void)refreshUserInterface;

@end

@implementation RequestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Request";
    }
    return self;
}

- (void)dealloc
{
    [_tableView release];
    [_dataSource release];
    [_responseData release];
    [_indicator release];
    [_requestMethod release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initDataSource];
    [self initUserInterface];
//    [self startSynchronousRequestWithMethoName:POST_REQUEST_URL];
    [self startAsynchronousRequestWithMethoName:POST_REQUEST_URL];
}

- (void)initDataSource
{
    _dataSource = [[NSMutableArray alloc] init];
    _responseData = [[NSMutableData alloc] init];
}

- (void)initUserInterface
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame
                                              style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    [_tableView release];
    
    _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _indicator.bounds = CGRectMake(0, 0, 30, 30);
    _indicator.center = CGPointMake(CGRectGetMidX(self.view.frame),
                                    CGRectGetMidY(self.view.frame));
    [self.view addSubview:_indicator];
}

- (void)startSynchronousRequestWithMethoName:(NSString *)method
{
    [_indicator startAnimating];
    
    _requestMethod = [method copy];
    
    NSURL *url = [NSURL URLWithString:_requestMethod];
    NSURLRequest *request = nil;
    if ([_requestMethod isEqualToString:GET_REQUEST_URL]) {
        request = [NSURLRequest requestWithURL:url];
    } else {
        NSString *bodyString = @"g=ApiGGC&m=Public&c=getConstantList";
        request = [NSMutableURLRequest requestWithURL:url];
        // 配置http请求方式，默认get
        [(NSMutableURLRequest *)request setHTTPMethod:@"POST"];
        // 配置请求超时事件
        [(NSMutableURLRequest *)request setTimeoutInterval:10.0];
        // 配置发送的数据
        [(NSMutableURLRequest *)request
         setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:nil error:&error];
    
    if (!error) {
        [_responseData appendData:data]; // 拼接数据
        [self refreshUserInterface];
    } else {
        NSLog(@"Request failed with error message %@",
              [error localizedDescription]);
    } // 打印失败信息
    
    [_indicator stopAnimating];
}

- (void)startAsynchronousRequestWithMethoName:(NSString *)method
{
    [_indicator startAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    // 记录请求接口、请求类型
    _requestMethod = [method copy];
    NSURL *url = [NSURL URLWithString:_requestMethod];
    NSURLRequest *request = nil;
    if ([_requestMethod isEqualToString:GET_REQUEST_URL]) {
        request = [NSURLRequest requestWithURL:url];
    } else {
        NSString *bodyString = @"g=ApiGGC&m=Public&c=getConstantList";
        request = [NSMutableURLRequest requestWithURL:url];
        [(NSMutableURLRequest *)request setHTTPMethod:@"POST"];
        [(NSMutableURLRequest *)request setTimeoutInterval:10.0];
        [(NSMutableURLRequest *)request
         setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // 发起异步请求
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)refreshUserInterface
{
    NSString *responseString = [[NSString alloc] initWithData:_responseData
                                                     encoding:NSUTF8StringEncoding];
    NSLog(@"responseString: %@", responseString);
    [responseString release];
    
    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:_responseData
                                                options:NSJSONReadingMutableLeaves
                                                  error:&error];
    if ([object isKindOfClass:[NSDictionary class]]) {
        if ([_requestMethod isEqualToString:GET_REQUEST_URL]) { // GET
            [_dataSource addObjectsFromArray:object[@"items"]];
        } else { // POST
            [_dataSource addObjectsFromArray:object[@"content"][@"relation_type_list"]];
        }
        
        // 刷新表视图
        [_tableView reloadData];
    } else if ([object isKindOfClass:[NSArray class]]) {
        // ...
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = nil;
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier];
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    }
    
    NSString *title = nil;
    NSString *subTitle = nil;
    if ([_requestMethod isEqualToString:GET_REQUEST_URL]) {
        title = _dataSource[indexPath.row][@"name"];
        subTitle = _dataSource[indexPath.row][@"addr"];
    } else {
        title = _dataSource[indexPath.row][@"name"];
        subTitle = _dataSource[indexPath.row][@"key"];
    }
    
    cell.textLabel.text = title;
    cell.detailTextLabel.text = subTitle;
    return cell;
}

#pragma mark - UITableViewDelegate

#pragma mark - NSURLConnectionDataDelegate、NSURLConnectionDelegate

// 请求完成
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self refreshUserInterface];
    [_indicator stopAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

// 获取到数据或者部分数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_responseData appendData:data];
}

// 请求失败
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [_indicator stopAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSLog(@"Request failed with eror message %@", [error localizedDescription]);
}

@end