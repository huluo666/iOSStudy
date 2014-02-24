//
//  ViewController.m
//  2014.2.24多线程
//
//  Created by 张鹏 on 14-2-24.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "ViewController.h"
#import "CustomOperation.h"

@interface ViewController () {
    
    UILabel *_stateDisplay;
    UIActivityIndicatorView *_activityIndicatorView;
    BOOL _processing;
    NSOperationQueue *_backgroundQueue;
    
    NSInteger _count;
}

- (void)initializeUserInterface;
- (void)buttonPressed:(UIButton *)sender;

// 模拟耗时操作
- (void)startProcessing;

- (void)startAscending;
- (void)startDescending;

@end

@implementation ViewController

- (id)init
{
    self = [super init];
    if (self) {
        
        _processing = NO;
        _count = 100;
        
    }
    return self;
}

- (void)dealloc {
    
    [_stateDisplay          release];
    [_activityIndicatorView release];
    [_backgroundQueue       release];
    
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
    
    CGRect bounds = self.view.bounds;
    
    _stateDisplay = [[UILabel alloc] init];
    _stateDisplay.bounds = CGRectMake(0, 0, CGRectGetWidth(bounds), 44);
    _stateDisplay.center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMinY(bounds) + 100);
    _stateDisplay.textAlignment = NSTextAlignmentCenter;
    _stateDisplay.font = [UIFont systemFontOfSize:30];
    _stateDisplay.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_stateDisplay];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.bounds = CGRectMake(0, 0, 150, 30);
    button.center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds) + 100);
    [button setTitle:@"Start Processing" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicatorView.bounds = CGRectMake(0, 0, 30, 30);
    _activityIndicatorView.center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
    [self.view addSubview:_activityIndicatorView];
}

- (void)buttonPressed:(UIButton *)sender {
    
    // 判断当前操作是否执行，若执行中则返回
    if (_processing) {
        return;
    }
    _processing = YES;
    
    _stateDisplay.text = @"处理中...";
    [_activityIndicatorView startAnimating];
    
    // 主线程中执行
//    [self startProcessing];
    
    // 1.NSObject方法
//    [self performSelectorInBackground:@selector(startProcessing) withObject:nil];
    
    // 2.NSThread：线程的对象化抽象
    // 初始化线程，且立即启动
    [NSThread detachNewThreadSelector:@selector(startProcessing) toTarget:self withObject:nil];
    // 初始化线程，但不立即执行
//    NSThread *thread = [[NSThread alloc] initWithTarget:self
//                                               selector:@selector(startProcessing)
//                                                 object:nil];
//    // 启动线程
//    [thread start];
//    [thread release];
    
    // NSOperation：操作的对象化封装
    // NSOperationQueue：操作队列，在后台线程中管理和执行NSOperation
//    CustomOperation *operation = [[CustomOperation alloc] init];
//    operation.completionBlock = ^void (void){
//        [self performSelectorOnMainThread:@selector(completeProcessing)
//                               withObject:nil
//                            waitUntilDone:NO];
//    };
    
    // NSInvocationOperation
//    NSInvocationOperation *operation = [[NSInvocationOperation alloc]
//                                        initWithTarget:self
//                                        selector:@selector(startProcessing)
//                                        object:nil];
    
    // NSBlockOperation
//    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
//        [self startProcessing];
//    }];
//    
//    _backgroundQueue = [[NSOperationQueue alloc] init];
//    // 将NSOperation加入队列并执行
//    [_backgroundQueue addOperation:operation];
    
    // GCD：Grand Central Dispatch
    // 获取程序全局队列（默认优先级）
//    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    // 开始异步操作，指定一个队列
//    dispatch_async(globalQueue, ^{
//        NSDate *beginDate = [NSDate date];
//        // 当前线程休眠10秒
//        [NSThread sleepForTimeInterval:10];
//        NSDate *endDate = [NSDate date];
//        // 将操作放回主线程执行
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self completeProcessing];
//        });
//        NSLog(@"Complete processing with '%.2f' seconds.", [endDate timeIntervalSinceDate:beginDate]);
//    });
}

- (void)startProcessing {
    
    NSDate *beginDate = [NSDate date];
    
    // 模拟两个线程同时访问一个变量
    [NSThread detachNewThreadSelector:@selector(startAscending) toTarget:self withObject:nil];
    [NSThread detachNewThreadSelector:@selector(startDescending) toTarget:self withObject:nil];
    
    // 当前线程休眠10秒
    [NSThread sleepForTimeInterval:10];
    
    NSDate *endDate = [NSDate date];
    // 刷新界面元素，UIKit对象非线程安全，需要将界面刷新方法放到主线程执行
    [self performSelectorOnMainThread:@selector(completeProcessing) withObject:nil waitUntilDone:NO];
    NSLog(@"Complete processing with '%.2f' seconds.", [endDate timeIntervalSinceDate:beginDate]);
}

- (void)completeProcessing {
    
    _processing = NO;
    _stateDisplay.text = @"处理完成";
    [_activityIndicatorView stopAnimating];
}

- (void)startAscending {
    
    while (_processing) {
        // 保证@synchronized作用域内代码同步执行
        @synchronized(self) {
            NSLog(@"Ascending count = %d", ++_count);
        }
    }
}

- (void)startDescending {
    
    while (_processing) {
        @synchronized(self) {
            NSLog(@"Descending count = %d", --_count);
        }
    }
}

@end




















