//
//  ViewController.m
//  2014.2.26
//
//  Created by 张鹏 on 14-2-26.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "ViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "GDataXMLNode.h"
#import "UIImageView+WebCache.h"

@interface ViewController () <ASIHTTPRequestDelegate> {
    
    UIScrollView *_scrollView;
}

- (void)initializeUserInterface;
- (void)updateUserInterfaceWithResults:(NSArray *)results;

// GET请求
- (void)startRequest;
// POST请求
- (void)startPOSTRequest;

- (id)parseXMLString:(NSString *)string;
- (void)buttonPressed:(UIButton *)sender;

@end

@implementation ViewController

- (void)dealloc {
    
    [_scrollView release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self initializeUserInterface];
    [self startRequest];
//    [self startPOSTRequest];
}

- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.contentSize = CGSizeZero;
    _scrollView.contentOffset = CGPointZero;
    [self.view addSubview:_scrollView];
}

- (void)updateUserInterfaceWithResults:(NSArray *)results {
    
    for (int i = 0; i < [results count]; i++) {
        NSDictionary *infoDict = results[i];
        NSString *title = infoDict[@"docTitle"];
        NSString *imageURLString = infoDict[@"docImg"];
        
        // 行数
        NSInteger row = i / 2;
        // 列数
        NSInteger column = i % 2;
        
        // 初始化图片展示
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.bounds = CGRectMake(0, 0, 150, 150);
        imageView.center = CGPointMake(CGRectGetMidX(imageView.bounds) + (20 + CGRectGetWidth(imageView.bounds)) * column, CGRectGetMidY(imageView.bounds) + (20 + CGRectGetHeight(imageView.bounds)) * row);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [imageView setImageWithURL:[NSURL URLWithString:imageURLString]];
        [_scrollView addSubview:imageView];
        [imageView release];
        
        // 标题展示
        UILabel *label = [[UILabel alloc] init];
        label.bounds = CGRectMake(0, 0, 150, 20);
        label.center = CGPointMake(imageView.center.x,
                                   CGRectGetMaxY(imageView.frame) + CGRectGetMidY(label.bounds));
        label.text = title;
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        [_scrollView addSubview:label];
        [label release];
        
        // 更新scrolliew显示
        if (i == [results count] - 1) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.bounds = CGRectMake(0, 0, 150, 30);
            button.center = CGPointMake(CGRectGetMidX(self.view.bounds),
                                        CGRectGetMaxY(label.frame) + 50);
            [button setTitle:@"清除缓存" forState:UIControlStateNormal];
            [button addTarget:self
                       action:@selector(buttonPressed:)
             forControlEvents:UIControlEventTouchUpInside];
            [_scrollView addSubview:button];
            
            _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds),
                                                 CGRectGetMaxY(button.frame) + 30);
        }
    }
}

- (void)startRequest {
    
    NSURL *url = [NSURL URLWithString:@"http://lab.hudong.com/ipad/zutujingxuan.xml"];
    __block ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    // 配置委托对象
//    request.delegate = self;
    // 配置请求方法
    request.requestMethod = @"GET";
    // 配置超时时长
    request.timeOutSeconds = 10.0;
    // 配置是否需要认证（https）
    request.validatesSecureCertificate = NO;
    // 配置默认数据编码类型
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    // 开始异步请求
    [request startAsynchronous];
    // 开始同步请求
//    [request startSynchronous];
    
    
    // 循环引用
    [request setCompletionBlock:^{
        NSLog(@"%@", request.responseString);
        [self updateUserInterfaceWithResults:[self parseXMLString:request.responseString]];
    }];
    
    [request setFailedBlock:^{
        
    }];
    
    
    [request release];
}

- (void)startPOSTRequest {
    
    NSURL *url = [NSURL URLWithString:@"http://125.70.10.34:8119/ggc/api.php"];
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url];
    request.delegate = self;
    request.requestMethod = @"POST";
    request.timeOutSeconds = 10.0;
    request.validatesSecureCertificate = NO;
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    /*@"ApiGGC" @"g"
      @"Public" @"m"
      @"getConstantList" @"c"
     */
    // 配置POST参数
    [request setPostValue:@"ApiGGC" forKey:@"g"];
    [request setPostValue:@"Public" forKey:@"m"];
    [request setPostValue:@"getConstantList" forKey:@"c"];
    
    [request startAsynchronous];
    [request release];
}

- (id)parseXMLString:(NSString *)string {
    
    // 为空判断
    if (string.length == 0) {
        return nil;
    }
    
    // 把XML字符串对象化
    NSError *error = nil;
    GDataXMLDocument *document = [[GDataXMLDocument alloc]
                                  initWithXMLString:string
                                  options:0
                                  error:&error];
    NSAssert(!error, @"Initialize XML document failed with error message '%@'.", [error localizedDescription]);
    
    // X path 解析（路径解析）：GDataXMLElement - XML元素
//    NSArray *titleElements = [document nodesForXPath:@"////docTitle" error:&error];
//    NSAssert(!error, @"Parse XML node failed with error message '%@'.", [error localizedDescription]);
//    NSArray *imageElements = [document nodesForXPath:@"////docImg" error:&error];
//    NSAssert(!error, @"Parse XML node failed with error message '%@'.", [error localizedDescription]);
//    NSMutableArray *results = [NSMutableArray array];
//    for (int i = 0; i < [titleElements count]; i++) {
//        // 取出title节点元素
//        GDataXMLElement *titleElement = titleElements[i];
//        // 取出image节点元素
//        GDataXMLElement *imageElement = imageElements[i];
//        // 取出节点元素的值和名称，并打包字典存入数组中
//        NSMutableDictionary *infoDict = [NSMutableDictionary dictionary];
//        [infoDict setObject:[titleElement stringValue] forKey:[titleElement name]];
//        [infoDict setObject:[imageElement stringValue] forKey:[imageElement name]];
//        [results addObject:infoDict];
//    }
    
    // XML节点层次解析
    // 获取文档根节点
    GDataXMLElement *rootElement = [document rootElement];
    GDataXMLElement *docListElement = [[rootElement elementsForName:@"docList"] objectAtIndex:0];
    // 获取所有docInfo节点
    NSArray *docInfoElements = [docListElement elementsForName:@"docInfo"];
    NSMutableArray *results = [NSMutableArray array];
    for (GDataXMLElement *element in docInfoElements) {
        // 打包docInfo节点数据
        NSMutableDictionary *infoDict = [NSMutableDictionary dictionary];
        // 遍历docInfo节点的所有子结点，获取其中的数据并存入字典
        for (GDataXMLElement *subElement in element.children) {
            [infoDict setObject:[subElement stringValue] forKey:[subElement name]];
        }
        [results addObject:infoDict];
    }
    
    NSLog(@"%@", results);
    
    return results;
}

- (void)buttonPressed:(UIButton *)sender {
    
    // 清除图片缓存
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
}

#pragma mark - <ASIHTTPRequestDelegate>

// 请求成功
- (void)requestFinished:(ASIHTTPRequest *)request {
    
    // 获取到请求数据结果
    NSLog(@"%@", request.responseString);
    // JSON解析
//    id object = [NSJSONSerialization JSONObjectWithData:request.responseData
//                                                options:NSJSONReadingMutableContainers
//                                                  error:nil];
//    NSLog(@"%@", object);
    
    // XML数据解析
    NSArray *results = [self parseXMLString:request.responseString];
    // 解析完成刷新界面UI
    [self updateUserInterfaceWithResults:results];
}

// 请求失败
- (void)requestFailed:(ASIHTTPRequest *)request {
    
    NSLog(@"Request failed with error message '%@'.", [request.error localizedDescription]);
}


@end
















