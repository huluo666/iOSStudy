//
//  DDViewController.m
//  「Demo」下拉刷新
//
//  Created by 萧川 on 14-4-9.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDViewController.h"
#import "DDPullDown.h"
#import "DDDetailViewController.h"

@interface DDViewController ()

@property (strong, nonatomic) DDPullDown *pullDown;

@end

@implementation DDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cyanColor];
    
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

    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 200, 200, 40);
    button.backgroundColor = [UIColor yellowColor];
    [button setTitle:@"push" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [scrollow addSubview:button];
}

- (void)stopWithRefreshBaseView:(DDRefreshBaseView *)refreshBaseView {
    // 刷新ing...
    NSLog(@"%u", _pullDown.state);
    // 刷新完成，关闭刷新视图
    [refreshBaseView endRefreshingWithSuccess:YES];
}

- (void)push {
    
    DDDetailViewController *detail = [[DDDetailViewController alloc] init];
    
//    CATransition* transition = [CATransition animation];
//    //执行时间长短
//    transition.duration = 0.5;
//    //动画的开始与结束的快慢
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    //各种动画效果
//    transition.type = kCATransitionReveal; //kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal, kCATransitionFade
//    //动画方向
//    transition.subtype = kCATransitionFromTop; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
//    //将动画添加在视图层上
//    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    [self.navigationController pushViewController:detail animated:YES];
}

@end
