//
//  DDViewController.m
//  「Demo」下拉刷新
//
//  Created by 萧川 on 14-4-9.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDViewController.h"
#import "DDPullDown.h"

@interface DDViewController ()

@property (strong, nonatomic) DDPullDown *pullDown;

@end

@implementation DDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIScrollView *scrollow = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrollow.contentSize = CGSizeMake(320, 1900);
    [self.view addSubview:scrollow];
    
    _pullDown = [DDPullDown pullDown];
    _pullDown.scrollView = scrollow;
    
    __weak DDPullDown *pullDown = _pullDown;
    __weak DDViewController *weakSelf = self;
    _pullDown.beginRefreshBaseView = ^(DDRefreshBaseView *refreshBaseView) {
        // 准备刷新，但是还没有刷新
        NSLog(@"%u", pullDown.state);
        // 刷新
        [weakSelf performSelector:@selector(stopWithRefreshBaseView:) withObject:refreshBaseView afterDelay:0.01];
    };
    
    _pullDown.didRefreshBaseView = ^(DDRefreshBaseView *refreshBaseView) {
        // 刷新完成以后调用
        NSLog(@"!!!!!!!!%@当前状态：数据刷新完成", [refreshBaseView class]);
    };

}

- (void)stopWithRefreshBaseView:(DDRefreshBaseView *)refreshBaseView {
    // 刷新ing...
    NSLog(@"%u", _pullDown.state);
    // 刷新完成，关闭刷新视图
    [refreshBaseView endRefreshingWithSuccess:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
