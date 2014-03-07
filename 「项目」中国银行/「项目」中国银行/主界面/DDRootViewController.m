//
//  DDRootViewController.m
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-7.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDRootViewController.h"
#import "DDLogin.h"
#import "DDIndex.h"
#import "DDAbroad.h"
#import "DDFinancing.h"
#import "DDChoose.h"
#import "DDSchedule.h"
#import "DDShopcart.h"

@interface DDRootViewController ()
{
    UIView *_naviBar;                 // 左侧导航栏视图
    NSInteger _currentSelectedButton; // 当前选中的是第几个导航button
    NSArray *_views;                  // 导航视图数组
}

// 初始化导航视图数组
- (void)initializeViews;
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
    [self initializeViews];
    [self initializeUserInterface];
    _logined = YES;
//    _logined = NO;
    if (!_logined) {
        [self initializeLoginView];
    }
}

- (void)dealloc
{
    [_naviBar release];
    [_views release];
    [super dealloc];
}

- (void)initializeLoginView
{
    DDLogin *login = [[DDLogin alloc] init];
    login.frame = self.view.frame;
    [self.view addSubview:login];
    [login release];
}

- (void)initializeViews
{
    // 分别创建各导航器的视图
    DDIndex *index = [[DDIndex alloc] initWithFrame:kMainViewFrame];
    DDAbroad *abroad = [[DDAbroad alloc] initWithFrame:kMainViewFrame];
    DDFinancing *financing = [[DDFinancing alloc] initWithFrame:kMainViewFrame];
    DDChoose *choose = [[DDChoose alloc] initWithFrame:kMainViewFrame];
    DDSchedule *schedule = [[DDSchedule alloc] initWithFrame:kMainViewFrame];
    
    _views = [@[index, abroad, financing, choose, schedule] retain];

    [index release];
    [abroad release];
    [financing release];
    [choose release];
    [schedule release];
}

- (void)initializeUserInterface
{
    self.view.frame = CGRectMake(0, 0, kRootViewWidth, kRootViewHeight);
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    // 设置左侧导航条
    _naviBar = [[UIView alloc] init];
    _naviBar.bounds = CGRectMake(0, 0, kNaviBarViewWidth, kRootViewHeight);
    _naviBar.center = CGPointMake(CGRectGetMidX(_naviBar.bounds), self.view.center.y);
    _naviBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"导航-底_03"]];
    [self.view addSubview:_naviBar];
    [_naviBar release];
    
    // 加载导航按钮
    NSArray *naviBarImageNormalNames = @[@"首页_03.png", @"出国服务_05.png", @"出国服务_05.png", @"选购清单_09", @"服务进度_11.png"];
    NSArray *naviBarImageSelectedNames = @[@"首页_03_h.png", @"出国服务_05_h.png", @"出国服务_05_h.png", @"选购清单_09_h.png", @"服务进度_11_h.png"];

    for (int i = 0; i < 5; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.bounds = CGRectMake(0, 0, kNaviBarViewWidth, kNaviBarButtonHeight);
        button.center = CGPointMake(CGRectGetMidX(_naviBar.frame),
                                    kHeaderViewHeight + CGRectGetMidY(button.bounds) + CGRectGetHeight(button.bounds) * i);

        [button setBackgroundImage:[UIImage imageNamed:naviBarImageNormalNames[i]]
                          forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:naviBarImageSelectedNames[i]]
                          forState:UIControlStateSelected];
        button.tag = kButtonTag + i;
        [button addTarget:self
                   action:@selector(toggleVC:)
         forControlEvents:UIControlEventTouchUpInside];
        [_naviBar addSubview:button];
        
        // 默认选中第一个
        if (!i) {
            button.selected = YES;
            [self.view addSubview:_views[0]];;
        }
    }

    // 设置眉头底图
    UIImage *headerImage = [UIImage imageNamed:@"眉头_01"];
    UIImageView *headerView =[[UIImageView alloc] initWithImage:headerImage];
    headerView.frame = CGRectMake(0, 0, kRootViewWidth, kHeaderViewHeight);
    headerView.backgroundColor = [UIColor redColor];
    [self.view addSubview:headerView];
    [headerView release];
}

#pragma mark - 导航栏按钮点击事件、切换视图

- (void)toggleVC:(UIButton *)sender
{
    NSInteger index = sender.tag - kButtonTag;
    
    // 避免重复选择第
    if (index ==  _currentSelectedButton) {
        return;
    }
    
    // 当前出现的视图
    UIView *appearedView = _views[_currentSelectedButton];
    // 将要出现的视图
    UIView *willAppearView = _views[index];
    [self.view addSubview:willAppearView];
    [self.view sendSubviewToBack:willAppearView];
    // 当前选中的导航按钮
    UIButton *selectedButton = (UIButton *)[_naviBar viewWithTag:_currentSelectedButton + kButtonTag];
    // 将要选中的导航按钮
    UIButton *willSelectedButton = (UIButton *)[_naviBar viewWithTag:sender.tag];
    
    if (_currentSelectedButton < index) {
        // 当前在上，将要选中的在下面，像下推动动画
        willAppearView.center = kMainViewCenterDown;
        [UIView animateWithDuration:kAnimateDuration / 2
                         animations:^{
                             appearedView.center = kMainViewCenterUp;
                             willAppearView.center = kMainViewCenter;
                             selectedButton.selected = NO;
                             willSelectedButton.selected = YES;
                         }
                         completion:^(BOOL finished) {
                             [appearedView removeFromSuperview];
                             _currentSelectedButton = index;
                         }];
    } else {
        // 当前在下，将要选中的视图在上面，向下推动动画
        willAppearView.center = kMainViewCenterUp;
        [UIView animateWithDuration:kAnimateDuration / 2
                         animations:^{
                             appearedView.center = kMainViewCenterDown;
                             willAppearView.center = kMainViewCenter;
                             selectedButton.selected = NO;
                             willSelectedButton.selected = YES;
                         }
                         completion:^(BOOL finished) {
                             [appearedView removeFromSuperview];
                             _currentSelectedButton = index;
                         }];
    }
}

@end
