//
//  DDDetailViewController.m
//  「Demo」下拉刷新
//
//  Created by 萧川 on 14-4-10.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDDetailViewController.h"
#import "DDPullUp.h"

@interface DDDetailViewController ()

@property (strong, nonatomic) DDPullUp *pullUp;

@end

@implementation DDDetailViewController

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

    self.view.backgroundColor = [UIColor greenColor];

    UIScrollView *scrollow = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrollow.contentSize = CGSizeMake(320, 880);
    [self.view addSubview:scrollow];
    
    _pullUp = [DDPullUp pullUp];
    _pullUp.scrollView = scrollow;
    
    __weak DDDetailViewController *weakSelf = self;
    _pullUp.beginRefreshBaseView = ^(DDRefreshBaseView *refreshBaseView) {
        
        [weakSelf.navigationController popViewControllerAnimated:YES];

    };
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 200, 200, 40);
    button.backgroundColor = [UIColor yellowColor];
    [button setTitle:@"Pop" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [scrollow addSubview:button];
}

- (void)pop {
    
//    CATransition* transition = [CATransition animation];
//    //执行时间长短
//    transition.duration = 0.5;
//    //动画的开始与结束的快慢
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    //各种动画效果
//    transition.type = kCATransitionReveal; //kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal, kCATransitionFade
//    //动画方向
//    transition.subtype = kCATransitionFromBottom; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
//    //将动画添加在视图层上
//    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
