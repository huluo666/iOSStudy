//
//  MainViewController.m
//  BlockDemo
//
//  Created by wei.chen on 13-1-4.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //---------------block声明与创建-------------------
    /*
    //声明一个block变量
    int(^myBlock)(int);
    
    //创建block
    myBlock = ^(int a){
        NSLog(@"参数：%d",a);
        return 10;
    };
    
    //调用block
    int ret = myBlock(20);
    */
    
    /*
    MyBlock myblock = ^(int a){
        NSLog(@"参数：%d",a);
        return 20;
    };
    myblock(10);
     */
    
    //---------------block作为参数-------------------
    /*
    NSLog(@"before");
    MyBlock myblock = ^(int a) {
        NSLog(@"这是block代码块,a=%d",a);
        return 10;
    };
    [self testBlock:myblock];
     */
    
    //---------------block引用局部变量-------------------
//    __block int number = 20;
    /*
    int number = 20;
    MyBlock myblock2 = ^(int a) {
//        number = 30;
        NSLog(@"%d",number);
        return 10;
    };
    myblock2(10);
    */
    
    //---------------block内存管理-------------------
    /*
    NSObject *obj = [[NSObject alloc] init];
    
    MyBlock myblock2 = ^(int a){
        NSLog(@"%d",obj.retainCount);
        return 10;
    };
    [obj release];
    
    [self testBlock:myblock2];
    */
    
    
    NSLog(@"%d",self.retainCount);
    MyBlock myblock2 = ^(int a){
//        number = 10;
        self.view.backgroundColor = [UIColor grayColor];
        NSLog(@"%d",self.retainCount);
        return 10;
    };
    
    [self testBlock:myblock2];
    
}


- (void)testBlock:(MyBlock)myBlock {
    //....逻辑判断
    
    //block回调
    myBlock(10);
}


@end
