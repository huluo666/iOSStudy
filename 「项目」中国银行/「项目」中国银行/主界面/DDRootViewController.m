//
//  DDRootViewController.m
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-7.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDRootViewController.h"
#import "DDLogin.h"

@interface DDRootViewController ()

// 初始化登录界面
- (void)initializeLoginView;
// 初始化用户界面
- (void)initializeUserInterface;
// 切换视图
- (void)toggleVC:(UIButton *)sender;

@end

@implementation DDRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self initializeUserInterface];
    _logined = NO;
    if (!_logined) {
        [self initializeLoginView];
    } 
}

- (void)initializeLoginView
{
    DDLogin *login = [[DDLogin alloc] init];
    login.frame = self.view.frame;
    [self.view addSubview:login];
    [login release];
}

- (void)initializeUserInterface
{
    self.view.frame = CGRectMake(0, 0, kViewWidth, kViewHeight);
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    // 设置左侧导航条
    UIView *naviBar = [[UIView alloc] init];
    naviBar.bounds = CGRectMake(0, 0, kNaviBarViewWidth, kViewHeight);
    naviBar.center = CGPointMake(CGRectGetMidX(naviBar.bounds), self.view.center.y);
    naviBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"导航-底_03"]];
    [self.view addSubview:naviBar];
    [naviBar release];
    
    // 加载导航按钮
    NSArray *naviBarImageNormalNames = @[@"首页_03.png", @"出国服务_05.png", @"出国服务_05.png", @"选购清单_09", @"服务进度_11.png"];
    NSArray *naviBarImageSelectedNames = @[@"首页_03_h.png", @"出国服务_05_h.png", @"出国服务_05_h.png", @"选购清单_09_h.png", @"服务进度_11_h.png"];

    for (int i = 0; i < 5; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.bounds = CGRectMake(0, 0, kNaviBarViewWidth, kNaviBarButtonHeight);
        button.center = CGPointMake(CGRectGetMidX(naviBar.frame),
                                    kHeaderViewHeight + CGRectGetMidY(button.bounds) + CGRectGetHeight(button.bounds) * i);

        [button setBackgroundImage:[UIImage imageNamed:naviBarImageNormalNames[i]]
                          forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:naviBarImageSelectedNames[i]]
                          forState:UIControlStateSelected];
        button.tag = kButtonTag + i;
        [button addTarget:self
                   action:@selector(toggleVC:)
         forControlEvents:UIControlEventTouchUpInside];
        [naviBar addSubview:button];
    }

    // 设置眉头底图
    UIImage *headerImage = [UIImage imageNamed:@"眉头_01"];
    UIImageView *headerView =[[UIImageView alloc] initWithImage:headerImage];
    headerView.frame = CGRectMake(0, 0, kViewWidth, kHeaderViewHeight);
    headerView.backgroundColor = [UIColor redColor];
    [self.view addSubview:headerView];
    [headerView release];
}

#pragma mark - 导航栏按钮点击事件、切换视图

- (void)toggleVC:(UIButton *)sender
{
    NSInteger index = sender.tag - kButtonTag;
    NSLog(@"index = %ld", index);
}

@end
