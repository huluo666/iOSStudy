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
    UIView *_naviBar;                       // 左侧导航栏视图
    NSInteger _currentSelectedButtonIndex;  // 当前选中的是第几个导航button
    __block UIView *_appearedView;          // 当前出现的导航视图
    BOOL _isAnimating;                      // 是否正在动画中
    BOOL _isCartVisiable;                   // 购物车是否可见
}


// 初始化用户界面
- (void)initializeUserInterface;

// 创建导航视图
- (UIView *)createNaviViewWithIndex:(NSInteger)index;

// 切换视图
- (void)switchVC:(UIButton *)sender;

// 初始化登录界面
- (void)initializeLoginView;
// 登出
- (void)logout;

// 购物车点击事件
- (void)shopingCartAction:(UIButton *)sender;

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
//    _logined = YES;
    if (!_logined) {
        [self initializeLoginView];
    }
}

- (void)dealloc
{
    NSLog(@"%@ is dealloced", [self class]);
    [_naviBar release];
    [_appearedView release];
    _appearedView = nil;
    [super dealloc];
}

- (void)initializeLoginView
{
    DDLogin *login = [[DDLogin alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:login];
    [login release];
}

- (void)initializeUserInterface
{
    self.view.frame = CGRectMake(0, 0, kRootViewWidth, kRootViewHeight);
    
    // 设置左侧导航条
    _naviBar = [[UIView alloc] init];
    _naviBar.bounds = CGRectMake(0, 0, kNaviBarViewWidth, kRootViewHeight);
    _naviBar.center = CGPointMake(CGRectGetMidX(_naviBar.bounds), self.view.center.y);
    [self.view addSubview:_naviBar];
    [_naviBar release];
    
    // 设置左侧导航栏底图
    UIView *naviBaseView = [[UIView alloc] init];
    naviBaseView.bounds = CGRectMake(0, 0, kNaviBarBaseViewWidth, kRootViewHeight);
    naviBaseView.center = CGPointMake(CGRectGetMidX(_naviBar.bounds) - 4,
                                      self.view.center.y);
    naviBaseView.backgroundColor = [UIColor colorWithPatternImage:kImageWithNameHaveSuffix(@"导航-底_03.png")];
    [_naviBar addSubview:naviBaseView];
    [naviBaseView release];
    
    // 加载导航按钮
    NSArray *naviBarImageNormalNames = @[@"首页_03.png", @"出国服务_05.png", @"理财产品_07.png", @"选购清单_09.png", @"服务进度_11.png"];
    NSArray *naviBarImageSelectedNames = @[@"首页_03_h.png", @"出国服务_05_h.png", @"理财产品_07_h.png", @"选购清单_09_h.png", @"服务进度_11_h.png"];

    for (int i = 0; i < 5; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.bounds = CGRectMake(0, 0, kNaviBarViewWidth, kNaviBarButtonHeight);
        button.center = CGPointMake(CGRectGetMidX(_naviBar.frame),
                                    kHeaderViewHeight + CGRectGetMidY(button.bounds) + CGRectGetHeight(button.bounds) * i);
        [button setBackgroundImage:kImageWithNameHaveSuffix(naviBarImageNormalNames[i])
                          forState:UIControlStateNormal];
        [button setBackgroundImage:kImageWithNameHaveSuffix(naviBarImageSelectedNames[i])
                          forState:UIControlStateSelected];
        button.tag = kButtonTag + i;
        [button addTarget:self
                   action:@selector(switchVC:)
         forControlEvents:UIControlEventTouchUpInside];
        [_naviBar addSubview:button];
        
        // 默认选中第一个
        if (!i) {
            button.selected = YES;
            UIView *view = [self createNaviViewWithIndex:i];
            _appearedView = view;
            [self.view addSubview:view];
            [self.view sendSubviewToBack:view];
        }

//        if (4 == i) {
//            button.selected = YES;
//            UIView *view = [self createNaviViewWithIndex:i];
//            _appearedView = view;
//            _currentSelectedButtonIndex = i;
//            [self.view addSubview:view];
//            [self.view sendSubviewToBack:view];
//        }
    }
    
    // 加载购物车
    UIButton *cartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cartButton.bounds = CGRectMake(0, 0, 60, 50);
    cartButton.center = CGPointMake(CGRectGetMidX(_naviBar.bounds),
                                    CGRectGetMaxY(_naviBar.bounds) - CGRectGetMidX(cartButton.bounds) * 2);
    [cartButton setBackgroundImage:kImageWithName(@"购物车_01")
                          forState:UIControlStateNormal];
    [cartButton addTarget:self
                   action:@selector(shopingCartAction:)
         forControlEvents:UIControlEventTouchUpInside];
    [_naviBar addSubview:cartButton];
    
    // 设置眉头底图
    UIImage *headerImage = kImageWithNameHaveSuffix(@"眉头_01.png");
    UIImageView *headerView =[[UIImageView alloc] initWithImage:headerImage];
    headerView.frame = CGRectMake(0, 0, kRootViewWidth, kHeaderViewHeight);
    headerView.userInteractionEnabled = YES;
    [self.view addSubview:headerView];
    [headerView release];
    
    // 设置眉头阴影
    UIImage *shadowImage = kImageWithNameHaveSuffix(@"眉头阴影_04.png");
    UIImageView *shadowView = [[UIImageView alloc] initWithImage:shadowImage];
    shadowView.frame = CGRectMake(0, CGRectGetMaxY(headerView.frame), kRootViewWidth, 30);
    [self.view addSubview:shadowView];
    [shadowView release];
    
    // 设置眉头登录头像信息
    UIImage *avatar = kImageWithNameHaveSuffix(@"头像_11.png");
    UIImageView *userAvatar = [[UIImageView alloc] initWithImage:avatar];
    userAvatar.contentMode = UIViewContentModeScaleAspectFit;
    userAvatar.frame = CGRectMake(5, 20, 60, 60);
    userAvatar.userInteractionEnabled = YES;
    [headerView addSubview:userAvatar];
    [userAvatar release];
    
    // 设置退出登录按钮
    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutButton.bounds = CGRectMake(0, 0, 20, 20);
    [logoutButton setBackgroundImage:kImageWithNameHaveSuffix(@"关闭_05.png")
                            forState:UIControlStateNormal];
    logoutButton.center = CGPointMake(CGRectGetMaxX(userAvatar.bounds) - 5,
                                      CGRectGetMinY(userAvatar.bounds) + 5);
    [logoutButton addTarget:self
                     action:@selector(logout)
           forControlEvents:UIControlEventTouchUpInside];
    [userAvatar addSubview:logoutButton];
    
    // 设置底部视图
    UIImage *bottomImage = kImageWithNameHaveSuffix(@"写入框_08.png");
    UIImageView *bottomView = [[UIImageView alloc] initWithImage:bottomImage];
    bottomView.bounds = CGRectMake(0, 0, kRootViewWidth, kBottomImageViewHeight);
    bottomView.center = CGPointMake(kRootViewWidth / 2, kRootViewHeight - 10);
    [self.view addSubview:bottomView];
    [bottomView release];
}

#pragma mark - 购物车点击事件

- (void)shopingCartAction:(UIButton *)sender
{
    if (_isCartVisiable) {
        // 购物车可见
        id obj = [self.view.subviews lastObject];
        if ([obj isKindOfClass:[DDShopcart class]]) {
            [obj removeFromSuperview];
            _isCartVisiable = NO;
        }
    } else {
        CGRect frame = CGRectMake(kRootViewWidth - kMainViewWidth * 0.96,
                                  kRootViewHeight - kMainViewHeight * 0.97,
                                  kRootViewWidth * 0.85,
                                  kRootViewHeight * 0.82);
        DDShopcart *cart = [[DDShopcart alloc] initWithFrame:frame];
        [self.view addSubview:cart];
        [cart release];
        _isCartVisiable = YES;
    }
}

#pragma mark - 导航栏按钮点击事件、切换视图

- (void)switchVC:(UIButton *)sender
{
    NSInteger index = sender.tag - kButtonTag;
    
    // 避免重复选择第
    if (index ==  _currentSelectedButtonIndex) {
        return;
    }
    
    // 避免重复动画发生冲突
    if (_isAnimating) {
        return;
    }
    
    // 如果购物车可见，移除
    if (_isCartVisiable) {
        // 购物车可见
        id obj = [self.view.subviews lastObject];
        if ([obj isKindOfClass:[DDShopcart class]]) {
            [obj removeFromSuperview];
            _isCartVisiable = NO;
        }
    }
    
    // 将要出现的视图
    UIView *willAppearView = [self createNaviViewWithIndex:index];
    [self.view addSubview:willAppearView];
    [self.view sendSubviewToBack:willAppearView];

    // 显示的停止计时器
    if (0 == _currentSelectedButtonIndex) {
        DDIndex *view = (DDIndex *)_appearedView;
        [view.imageSwitchIntervalTimer invalidate];
        [view.updateImagesIntervalTimer invalidate];
    }
    
    // 当前选中的导航按钮
    UIButton *selectedButton = (UIButton *)[_naviBar viewWithTag:_currentSelectedButtonIndex + kButtonTag];
    // 将要选中的导航按钮
    UIButton *willSelectedButton = (UIButton *)[_naviBar viewWithTag:sender.tag];
    
    // 开始动画
    _isAnimating = YES;
    if (_currentSelectedButtonIndex < index) {
        // 当前在上，将要选中的在下面，向下推动动画
        willAppearView.center = kMainViewCenterDown;
        [UIView animateWithDuration:kAnimateDuration / 2
                         animations:^{
                             _appearedView.center = kMainViewCenterUp;
                             willAppearView.center = kMainViewCenter;
                             selectedButton.selected = NO;
                             willSelectedButton.selected = YES;
                         }
                         completion:^(BOOL finished) {
                             [_appearedView removeFromSuperview];
                             _appearedView = nil;
                             _appearedView = willAppearView;
                             _currentSelectedButtonIndex = index;
                             _isAnimating = NO;
                         }];
    } else {
        // 当前在下，将要选中的视图在上面，向下推动动画
        willAppearView.center = kMainViewCenterUp;
        [UIView animateWithDuration:kAnimateDuration / 2
                         animations:^{
                             _appearedView.center = kMainViewCenterDown;
                             willAppearView.center = kMainViewCenter;
                             selectedButton.selected = NO;
                             willSelectedButton.selected = YES;
                         }
                         completion:^(BOOL finished) {
                             [_appearedView removeFromSuperview];
                             _appearedView = nil;
                             _appearedView = willAppearView;
                             _currentSelectedButtonIndex = index;
                             _isAnimating = NO;
                         }];
    }
}

- (void)logout
{
    _logined = NO;
    [self initializeLoginView];
}

- (UIView *)createNaviViewWithIndex:(NSInteger)index
{
    NSArray *viewClassNames = @[
                                @"DDIndex",
                                @"DDAbroad",
                                @"DDFinancing",
                                @"DDChoose",
                                @"DDSchedule"];
    // 获取类字节码
    Class clazz = NSClassFromString(viewClassNames[index]);
   
    // 创建类对应的实例
    UIView *view = [[[clazz alloc] initWithFrame:kMainViewFrame] autorelease];
    
    return view;
}

@end
