//
//  DDFinancing.m
//  「项目」中国银行
//
//  Created by 萧川 on 3/7/14.
//  Copyright (c) 2014 CUAN. All rights reserved.
//

#import "DDFinancing.h"
#import "DDFinanceProductsView.h"
#import "DDFundsView.h"
#import "DDPreciousMetalView.h"
#import "DDInsuranceView.h"

@interface DDFinancing ()
{
    UISegmentedControl *_segmentedControl;      // 分段控件
    NSArray *_images;                           // 未选中状态标题图片
    NSArray *_imgaesSelected;                   // 选中状态标题图片
    
    UIView *_currentSelectedView;               // 当前选中的分段控件视图
    
    NSInteger _currentSelectedSegmentIndex;     // 当前选中分段索引
}

// 选中事件
- (void)segmentAction:(UISegmentedControl *)sender;
// 选中segment
- (void)selectedIndex:(NSInteger)index;

// 加载理财产品视图
- (void)loadFinanceProductsView;

// 加载基金产品视图
- (void)loadFundsView;
// 加载贵金属产品视图
- (void)loadPreciousMetalView;
// 加载保险产品视图
- (void)loadInsuranceView;

@end

@implementation DDFinancing

- (void)dealloc
{
    NSLog(@"%@ is dealloced", [self class]);
    [_segmentedControl release];
    [_images release];
    [_imgaesSelected release];
    [_currentSelectedView release];
    _currentSelectedView = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, kMainViewWidth, kMainViewHeight);
        // 初始化背景
        UIImageView *bottomView = [[UIImageView alloc] init];
        bottomView.frame = kMainViewBounds;
        bottomView.image = [UIImage imageNamed:@"背景"]; // chace
        bottomView.userInteractionEnabled = YES;
        [self addSubview:bottomView];
        [bottomView release];
        
        // 分段控件标题
        UIImage *financeProducts = kImageWithName(@"1_08");
        UIImage *funds = kImageWithName(@"2_09");
        UIImage *preciousMetal = kImageWithName(@"3_10");
        UIImage *insurance = kImageWithName(@"4_11");
        if ([UIImage instancesRespondToSelector:@selector(imageWithRenderingMode:)]) {
            financeProducts = [financeProducts imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            funds = [funds imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            preciousMetal = [preciousMetal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            insurance = [insurance imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        _images = [@[financeProducts, funds, preciousMetal, insurance] retain];
        
        // 分段标题选中状态
        UIImage *financeProductsSelected = kImageWithName(@"理财产品_08");
        UIImage *fundsSelected = kImageWithName(@"基金_09");
        UIImage *preciousMetalSelected = kImageWithName(@"贵金属_10");
        UIImage *insuranceSelected = kImageWithName(@"保险_11");
        if ([UIImage instancesRespondToSelector:@selector(imageWithRenderingMode:)]) {
            financeProductsSelected = [financeProductsSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            fundsSelected = [fundsSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            preciousMetalSelected = [preciousMetalSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            insuranceSelected = [insuranceSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        _imgaesSelected = [@[financeProductsSelected, fundsSelected, preciousMetalSelected, insuranceSelected] retain];
        
        // 分段控件
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:_images];
        _segmentedControl.tintColor = [UIColor clearColor];
        _segmentedControl.bounds = CGRectMake(0, 0, 472, 40);
        _segmentedControl.center = CGPointMake(CGRectGetMidX(self.bounds), 40);
        [_segmentedControl addTarget:self action:@selector(segmentAction:)
                   forControlEvents:UIControlEventValueChanged];
        [self addSubview:_segmentedControl];
        
        // 分段控件下面的阴影
        UIImageView *shadowView = [[UIImageView alloc] init];
        shadowView.bounds = CGRectMake(0, 0, CGRectGetWidth(_segmentedControl.bounds), 10);
        shadowView.center = CGPointMake(CGRectGetMidX(_segmentedControl.frame),
                                        CGRectGetMaxY(_segmentedControl.frame) + CGRectGetMidY(shadowView.bounds));
        shadowView.image = kImageWithName(@"pshadow_08");
        [self addSubview:shadowView];
        [shadowView release];
    
        // 默认选中第一个
        _currentSelectedSegmentIndex = 1;
        [self loadFinanceProductsView];
    }
    return self;
}

- (void)segmentAction:(UISegmentedControl *)sender
{
    NSUInteger index = sender.selectedSegmentIndex;
    switch (index) {
        case 0:
            [self loadFinanceProductsView];
            break;
        case 1:
            [self loadFundsView];
            break;
        case 2:
            [self loadPreciousMetalView];
            break;
        case 3:
            [self loadInsuranceView];
            break;
        default:
            break;
    }
}

- (void)loadFinanceProductsView
{
    // 切换选中状态
    [self selectedIndex:0];

    // 加载自己所属分段控件的视图
    CGRect frame = CGRectMake(10,
                              CGRectGetMaxY(_segmentedControl.frame) + 20,
                              kMainViewWidth * 0.98,
                              kMainViewHeight * 0.85);
    DDFinanceProductsView *financeProductsView = [[DDFinanceProductsView alloc] initWithFrame:frame];
    [self addSubview:financeProductsView];
    [financeProductsView release];
    _currentSelectedView = financeProductsView;
}


- (void)loadFundsView
{
    [self selectedIndex:1];
    
    CGRect frame = CGRectMake(10,
                              CGRectGetMaxY(_segmentedControl.frame) + 20,
                              kMainViewWidth * 0.98,
                              kMainViewHeight * 0.85);
    DDFundsView *fundsView = [[DDFundsView alloc] initWithFrame:frame];
    [self addSubview:fundsView];
    [fundsView release];
    _currentSelectedView = fundsView;
}

- (void)loadPreciousMetalView
{
    [self selectedIndex:2];
    
    CGRect frame = CGRectMake(10,
                              CGRectGetMaxY(_segmentedControl.frame) + 20,
                              kMainViewWidth * 0.98,
                              kMainViewHeight * 0.85);
    DDPreciousMetalView *preciousMetal = [[DDPreciousMetalView alloc] initWithFrame:frame];
    [self addSubview:preciousMetal];
    [preciousMetal release];
    _currentSelectedView = preciousMetal;
}

- (void)loadInsuranceView
{
    [self selectedIndex:3];
    
    CGRect frame = CGRectMake(10,
                              CGRectGetMaxY(_segmentedControl.frame) + 20,
                              kMainViewWidth * 0.98,
                              kMainViewHeight * 0.85);
    DDInsuranceView *insurance = [[DDInsuranceView alloc] initWithFrame:frame];
    [self addSubview:insurance];
    [insurance release];
    _currentSelectedView = insurance;
}

- (void)selectedIndex:(NSInteger)index
{
    // 重复点击无效
    if (_currentSelectedSegmentIndex == index) {
        return;
    }
    
    // 设置当前选中分段图片为取消状态
    [_segmentedControl setImage:_images[_currentSelectedSegmentIndex]
              forSegmentAtIndex:_currentSelectedSegmentIndex];
    // 设置将要选中分段图片为选中状态
    [_segmentedControl setImage:_imgaesSelected[index] forSegmentAtIndex:index];
    // 记录当前选中状态
    _currentSelectedSegmentIndex = index;
  
    // 移除上次选中视图
    if (_currentSelectedView) {
        [_currentSelectedView  removeFromSuperview];
        _currentSelectedView = nil;
    }
}

@end
