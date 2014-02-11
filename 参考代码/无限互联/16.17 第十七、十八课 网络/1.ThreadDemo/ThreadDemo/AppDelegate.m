//
//  AppDelegate.m
//  ThreadDemo
//
//  Created by wei.chen on 13-1-10.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "AppDelegate.h"

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
    
    
    //----------1.第一种方式：创建多线程对象
//    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(mutableThread:) object:@"test"];
//    //开始运行多线程
//    [thread start];
    
    
    //-----------2.第二种方式
//    [NSThread detachNewThreadSelector:@selector(mutableThread:) toTarget:self withObject:nil];
    
    
    //-----------3.第三种方式
//    [self performSelectorInBackground:@selector(mutableThread:) withObject:nil];
//    [self mutableThread:nil];
    
    //-----------4.第四种方式
//    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
//    [operationQueue addOperationWithBlock:^{
//        for (int i=0; i<100; i++) {
//            NSLog(@"--多线程-%d",i);
//        }
//    }];
    
    //-----------5.第五种方式
    //创建一个线程队列
//    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
//    //设置线程执行的并发数
//    operationQueue.maxConcurrentOperationCount = 1;
//    
//    //创建一个线程操作对象
//    NSInvocationOperation *operation1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(mutableThread:) object:nil];
//    
//    //创建一个线程操作对象
//    NSInvocationOperation *operation2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(mutableThread2:) object:nil];
//    //设置线程的优先级
//    operation2.queuePriority = NSOperationQueuePriorityHigh;
//    
//    //将线程添加到线程队列中
//    [operationQueue addOperation:operation1];
//    [operationQueue addOperation:operation2];
    
    //-----------------6.第六种方式：GCD
    //创建一个队列
    dispatch_queue_t queue = dispatch_queue_create("test", NULL);
    dispatch_async(queue, ^{
        for (int i=0; i<100; i++) {
            NSLog(@"--多线程1-%d",i);
        }
        
        BOOL isMuliti = [NSThread isMultiThreaded];
        if (isMuliti) {
            NSLog(@"多线程");
        }
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            BOOL isMain = [NSThread isMainThread];
            if (isMain) {
                NSLog(@"主线程");
            }
        });
        
    });
    
    //通过此种方式，还是同步运行在当前线程上
    dispatch_sync(queue, ^{
        //当前线程
    });
    
    
    for (int i=0; i<100; i++) {
        NSLog(@"--主线程-%d",i);
    }    
    
    return YES;
}


- (void)mutableThread:(NSString *)t {
    for (int i=0; i<100; i++) {
        NSLog(@"--多线程1-%d",i);
    }
    
    
    //跳到主线程执行
    [self performSelectorOnMainThread:@selector(mainThread) withObject:nil waitUntilDone:YES];
    
    //...
}

- (void)mutableThread2:(NSString *)t {
    for (int i=0; i<100; i++) {
        NSLog(@"--多线程2-%d",i);
    }
}


- (void)mainThread {
    //判断当前线程是否为主线程
    BOOL isMain = [NSThread isMainThread];
    if (isMain) {
        NSLog(@"mainThread");
    }
}

@end
