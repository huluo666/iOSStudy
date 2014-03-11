//
//  DDViewController.m
//  「UI」ASIHTTPRequset(day15)
//
//  Created by 萧川 on 14-2-26.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDViewController.h"
#import "ASIHTTPRequest.h"
#import "GDataXMLNode.h"
#import "UIImageView+WebCache.h"
#import "ASIFormDataRequest.h"

@interface DDViewController () <ASIHTTPRequestDelegate>
{
    UIScrollView *_scrollView;
}

- (void)initUserInterface;
// 开始GET网络请求
- (void)startRequest;
// 开始POST网络请求
- (void)startPostRequest;

// 解析XML
- (NSArray *)parseXMLStringbyXPath:(NSString *)string;
- (NSArray *)parseXMLStringByNode:(NSString *)string;

// 刷新用户界面
- (void)refreshUserInterfaceWithResult:(NSArray *)result;
// 清除图片缓存
- (void)clearImagesCaches:(UIButton *)sender;

@end

@implementation DDViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)dealloc
{
    [_scrollView release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUserInterface];
    [self startRequest];
//    [self startPostRequest];
}

- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor whiteColor];
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    _scrollView.contentSize = CGSizeZero;
    _scrollView.contentOffset = CGPointZero;
    [self.view addSubview:_scrollView];
}

- (void)startRequest
{
//    NSURL *url = [NSURL URLWithString:@"http://lab.hudong.com/ipad/zutujingxuan.xml"];
//    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
//    request.delegate = self;
//    request.requestMethod = @"GET";
//    request.timeOutSeconds = 10;
//    request.defaultResponseEncoding = NSUTF8StringEncoding;
//    request.validatesSecureCertificate = NO; // 是否需要认证(HTTPS)
//    [request startAsynchronous];
//    [request release];
    
    // block
    NSURL *url = [NSURL URLWithString:@"http://lab.hudong.com/ipad/zutujingxuan.xml"];
    __block ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    request.delegate = self;
    request.requestMethod = @"GET";
    request.timeOutSeconds = 10;
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    request.validatesSecureCertificate = NO; // 是否需要认证(HTTPS)
    [request startAsynchronous];
    
    // 注意循环引用
    [request setCompletionBlock:^{
        [self refreshUserInterfaceWithResult:[self parseXMLStringByNode:request.responseString]];
    }];
    [request setFailedBlock:^{
        ;
    }];
    [request release];

}

- (void)startPostRequest
{
    NSURL *url = [NSURL URLWithString:@"http://125.70.10.34:8119/ggc/api.php"];
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url];
    request.delegate = self;
    request.requestMethod = @"POST";
    request.timeOutSeconds = 10;
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    request.validatesSecureCertificate = NO; // 是否需要认证(HTTPS)
    // 配置POST参数
    [request setPostValue:@"ApiGGC" forKey:@"g"];
    [request setPostValue:@"Public" forKey:@"m"];
    [request setPostValue:@"getConstantList" forKey:@"c"];
    [request startAsynchronous];
    [request release];
}

- (NSArray *)parseXMLStringbyXPath:(NSString *)string
{
    if (!string || string.length == 0) {
        return nil;
    }
    
    // 把XML字符串对象化
    NSError *error = nil;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string
                                                                     options:0
                                                                       error:&error];
    NSAssert(!error, @"Initialize XML document failed with error message '%@'", [error localizedDescription]);
    // xPath解析：GDataXMLElement - XML 元素
    NSArray *titleElements = [document nodesForXPath:@"////docTitle" error:&error];
    NSArray *imageElements = [document nodesForXPath:@"////docImg" error:&error];
    NSMutableArray *result = [NSMutableArray array];
    for (int i = 0; i < titleElements.count; i ++) {
        // 取出title节点元素
        GDataXMLElement *titleElement = titleElements[i];
        // 取出image节点元素
        GDataXMLElement *imageElement = imageElements[i];
        // 打包到字典
        NSMutableDictionary *infoDict = [NSMutableDictionary dictionary];
        [infoDict setObject:[titleElement stringValue] forKey:[titleElement name]];
        [infoDict setObject:[imageElement stringValue] forKey:[imageElement name]];
        [result addObject:infoDict];
    }
//    NSLog(@"%@", result);
    [document release];
    return result;
}

- (NSArray *)parseXMLStringByNode:(NSString *)string
{
    if (!string || string.length == 0) {
        return nil;
    }
    
    // 把XML字符串对象化
    NSError *error = nil;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string
                                                                     options:0
                                                                       error:&error];
    NSAssert(!error, @"Initialize XML document failed with error message '%@'", [error localizedDescription]);
    // 获取根节点
    GDataXMLElement *rootNode = [document rootElement];
    GDataXMLElement *docListElement = [rootNode elementsForName:@"docList"][0];
    // 获取所有docInfo节点
    NSArray *docInfoElements = [docListElement elementsForName:@"docInfo"];
    NSMutableArray *result = [NSMutableArray array];
    for (GDataXMLElement *element in docInfoElements) {
        // 打包docInfo节点数据
        NSMutableDictionary *infoDict = [NSMutableDictionary dictionary];
        // 获取docInfo节点所有子节点，获取其中的数据并存入字典
        for (GDataXMLElement *subElement in element.children) {
            [infoDict setObject:[subElement stringValue] forKey:[subElement name]];
        }
        [result addObject:infoDict];
    }
    [document release];
//    NSLog(@"%@", result);
    return result;
}

- (void)refreshUserInterfaceWithResult:(NSArray *)result
{
//    [UIImage imageWithData:[NSData dataWithContentsOfURL:<#(NSURL *)#>]];
//    [[UIImageView alloc] init] setImageWithURL:<#(NSURL *)#>;

    CGFloat leftCenter = CGRectGetMidX(self.view.frame) / 2;
    CGFloat rightCenter = CGRectGetMidX(self.view.frame) / 2 * 3;
    CGFloat contentSizeHeight = 0.0f;
    for (int i = 0; i < result.count; i++) {
        NSURL *url = [NSURL URLWithString:result[i][@"docImg"]];
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView setImageWithURL:url];
        imageView.bounds = CGRectMake(0, 0, 150, 150);

        NSInteger row = i % 2; // 列数
        NSInteger col = i / 2; // 行数
        CGFloat center = leftCenter;
        if (row) {
            center = rightCenter;
        }
        imageView.center = CGPointMake(center,
                            (15 + CGRectGetMidY(imageView.bounds)) * ((2 * col) + 1));
        [_scrollView addSubview:imageView];
        [imageView release];
        
        // label
        UILabel *label = [[UILabel alloc] init];
        label.bounds = CGRectMake(0, 0, CGRectGetWidth(imageView.frame), 30);
        label.center = CGPointMake(imageView.center.x,
                        imageView.center.y + CGRectGetMidY(imageView.bounds) + CGRectGetMidY(label.bounds));
        label.text = result[i][@"docTitle"];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15];
        label.backgroundColor = [UIColor clearColor];
        [_scrollView addSubview:label];
        
        if (i == result.count - 1) {
            UIButton *clear = [UIButton buttonWithType:UIButtonTypeSystem];
            clear.bounds = CGRectMake(0, 0, 150, 30);
            clear.center = CGPointMake(CGRectGetMidX(self.view.frame),
                                       CGRectGetMaxY(label.frame) + CGRectGetHeight(clear.bounds));
            [clear setTitle:@"清除缓存" forState:UIControlStateNormal];
            [clear addTarget:self
                      action:@selector(clearImagesCaches:)
            forControlEvents:UIControlEventTouchUpInside];
            [_scrollView addSubview:clear];
            contentSizeHeight = CGRectGetMaxY(clear.frame);
        }
        [label release];
    }
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), contentSizeHeight);
    _scrollView.userInteractionEnabled = YES;
}

- (void)clearImagesCaches:(UIButton *)sender
{
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
}

#pragma mark - <ASIHTTPRequestDelegate>

// 请求成功
- (void)requestFinished:(ASIHTTPRequest *)request
{
//    id obj = [NSJSONSerialization JSONObjectWithData:request.responseData
//                                             options:NSJSONReadingMutableContainers
//                                               error:nil];
//    NSLog(@"%@", obj);
//    NSLog(@"请求数据结果%@", request.responseString);
    // 解析数据
    [self parseXMLStringbyXPath:request.responseString];
    NSArray *result = [self parseXMLStringByNode:request.responseString];
    // 刷新界面
    [self refreshUserInterfaceWithResult:result];
}

// 请求失败
- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"Request faild with error: %@", [request.error localizedDescription]);
}


@end
