//
//  DDRootViewController.m
//  「UI」多线程与消息通知(day13)
//
//  Created by 萧川 on 14-2-24.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "DDRootViewController.h"
#import "CustomOpreation.h"

@interface DDRootViewController ()

@property (assign, nonatomic) BOOL processing;

@property (retain, nonatomic) NSOperationQueue *backgroundQueue;

- (void)initUserInterface;
- (void)buttonPressed:(UIButton *)sender;

- (void)startProcessing;

@end

@implementation DDRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _processing = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUserInterface];
}

- (void)dealloc
{
    [_backgroundQueue release];
    [super dealloc];
}

- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    // label
    UILabel *display = [[UILabel alloc] init];
    display.bounds = CGRectMake(0, 0, 320, 40);
    display.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMinY(self.view.frame) + 80);
    display.textAlignment = NSTextAlignmentCenter;
    display.font = [UIFont systemFontOfSize:22.0f];
//    display.text = @"处理完成";
    [self.view addSubview:display];
    [display release];
    
    // 菊花
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] init];
    indicator.bounds = CGRectMake(0, 0, 40, 40);
    indicator.center = self.view.center;
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.view addSubview:indicator];
//    [indicator startAnimating];

    // 按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.bounds = CGRectMake(0, 0, 80, 30);
    button.center = CGPointMake(indicator.center.x , indicator.center.y + 140);
    [button setTitle:@"点击我呀" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)buttonPressed:(UIButton *)sender
{
    if (_processing) {
        return;
    }
    UILabel *label = (UILabel *)self.view.subviews[0];
    label.text = @"处理中...";
    
    UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)self.view.subviews[1];
    [indicator startAnimating];
    
    // 主线程中执行, 当前界面卡死
//    [self startProcessing];
    
    // NSObject method
//    [self performSelectorInBackground:@selector(startProcessing) withObject:nil];
    
    // NSThread
    // 初始化线程并执行
//    [NSThread detachNewThreadSelector:@selector(startProcessing) toTarget:self withObject:nil];
    // 初始化线程但不执行
/*    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(startProcessing) object:nil];
    // 启动线程
    [thread start]; 
    [thread release];
*/
    
    // NSOpreation: 操作的对象化封装功能
    // NSOpeartionQueue: 操作队列，在后台线程中管理和执行NSOpreation
//    CustomOpreation *operation = [[CustomOpreation alloc] init];
//    operation.completionBlock = ^{
//        operation.completionBlock = ^{
//            [self performSelectorOnMainThread:@selector(completeProcessing)
//                                   withObject:nil
//                                waitUntilDone:NO];
//        };
//    };
    
    // NSInvocationOpreation
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self
                                                                            selector:@selector(completeProcessing)
                                                                              object:nil];
    
    // NSBlockOpreation
//    NSBlockOperation *blockOpreation = [NSBlockOperation blockOperationWithBlock:^{
//        [self startProcessing];
//    }];

    _backgroundQueue = [[NSOperationQueue alloc] init];
    // 将NSOperation加入队列并执行
    [_backgroundQueue addOperation:operation];
    
    
//    // GCD(Grand Central Dispatch)
//    // 获取程序全局队列
//    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    // 开始异步操作，指定一个队列
//    dispatch_async(globalQueue, ^{
//        NSDate *begainDate = [NSDate date];
//        [NSThread sleepForTimeInterval:3.0f];
//        NSDate *endDate = [NSDate date];
//        // 返回主线程执行
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self startProcessing];
//        });
//        NSLog(@"Complete process with %.2f seconds.", [endDate timeIntervalSinceDate:begainDate]);
//    });
}

- (void)startProcessing
{
    _processing = YES;
    NSDate *begainDate = [NSDate date];
    // 当前线程休眠10秒钟
    [NSThread sleepForTimeInterval:3.0f];
    NSDate *endDate = [NSDate date];
    // 刷新界面，需要放在主线程执行
    [self performSelectorOnMainThread:@selector(completeProcessing) withObject:nil waitUntilDone:NO];
    NSLog(@"Complete process with %.2f seconds.", [endDate timeIntervalSinceDate:begainDate]);
}

- (void)completeProcessing
{
    UILabel *label = (UILabel *)self.view.subviews[0];
    label.text = @"处理完成";
    
    UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)self.view.subviews[1];
    [indicator stopAnimating];
    
    _processing = NO;
}

@end
