//
//  DDAbroad.m
//  「项目」中国银行
//
//  Created by 萧川 on 3/7/14.
//  Copyright (c) 2014 CUAN. All rights reserved.
//

#import "DDAbroad.h"
#import "DDOptionalView.h"
#import "DDPopView.h"
#import "DDConsultView.h"
#import "DDComboView.h"

@interface DDAbroad () <UITextFieldDelegate>
{
    UIView *_currentSelectedView;               // 当前选中视图
    UISegmentedControl *_segmentedControl;      // 分段控件
    NSArray *_images;                           // 未选中状态标题图片
    NSArray *_imgaesSelected;                   // 选中状态标题图片
    NSInteger _currentSelectedSegmentIndex;     // 当前选中分段索引

    BOOL _isSearchBarVisiable;                  // 搜索框是否可见
}

// 加载内容背景视图
- (UIView *)loadBottomViewWithSelectedIndex:(NSInteger)index;

// 选中事件
- (void)abroadSegmentAction:(UISegmentedControl *)sender;
// 选中segment
- (void)selectedIndex:(NSInteger)index;

// 加载政策咨询视图
- (void)loadConsultView;
// 搜索
- (void)searchAction:(UIButton *)sender;
// 播放视频
- (void)playVideo:(UIButton *)sender;

// 加载套餐模式视图
- (void)loadComboView;
// 加载自选模式视图
- (void)loadOptionalView;

@end

@implementation DDAbroad

- (void)dealloc
{
    NSLog(@"%@ is dealloced", [self class]);
    [_currentSelectedView release];
    _currentSelectedView = nil;
    [_images  release];
    [_imgaesSelected release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.frame = CGRectMake(0, 0, kMainViewWidth, kMainViewHeight);
    if (self) {
        // 分段控件标题
        UIImage *consult = [UIImage imageNamed:@"a_07"];
        UIImage *combo = [UIImage imageNamed:@"b_08"];
        UIImage *optional = [UIImage imageNamed:@"c_09"];
        if ([UIImage instancesRespondToSelector:@selector(imageWithRenderingMode:)]) {
            consult = [consult imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            combo = [combo imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            optional = [optional imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        _images = [@[consult, combo, optional] retain];

        // 标题选中状态
        UIImage *consultSelected = [UIImage imageNamed:@"aa_07"];
        UIImage *comboSelected = [UIImage imageNamed:@"bb_08"];
        UIImage *optionalSelected = [UIImage imageNamed:@"cc_09"];
        if ([UIImage instancesRespondToSelector:@selector(imageWithRenderingMode:)]) {
            consultSelected = [consultSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            comboSelected = [comboSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            optionalSelected = [optionalSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        _imgaesSelected = [@[consultSelected, comboSelected, optionalSelected] retain];
        
        // 分段控件
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:_images];
        _segmentedControl.tintColor = [UIColor clearColor];
        _segmentedControl.bounds = CGRectMake(0, 0, 355, 40);
        _segmentedControl.center = CGPointMake(CGRectGetMidX(self.bounds), 40);
        [_segmentedControl addTarget:self action:@selector(abroadSegmentAction:)
                   forControlEvents:UIControlEventValueChanged];
        [self addSubview:_segmentedControl];
        
        // 分段控件下面的阴影
        UIImageView *shadowView = [[UIImageView alloc] init];
        shadowView.bounds = CGRectMake(0, 0, CGRectGetWidth(_segmentedControl.bounds), 10);
        shadowView.center = CGPointMake(CGRectGetMidX(_segmentedControl.frame),
                                        CGRectGetMaxY(_segmentedControl.frame) + CGRectGetMidY(shadowView.bounds));
        shadowView.image = [UIImage imageNamed:@"pshadow_08"];
        [self addSubview:shadowView];
        [shadowView release];
    }
    
    // 默认选中第一个
    _currentSelectedSegmentIndex = 2;
        [self loadConsultView];
//        [self loadComboView];
//    [self loadOptionalView];
    return self;
}

- (void)abroadSegmentAction:(UISegmentedControl *)sender
{
    NSUInteger index = sender.selectedSegmentIndex;
    switch (index) {
        case 0:
            [self loadConsultView];
            break;
        case 1:
            [self loadComboView];
            break;
        case 2:
            [self loadOptionalView];
            break;
        default:
            break;
    }
}

- (UIView *)loadBottomViewWithSelectedIndex:(NSInteger)index
{
    // 初始化底图
    UIImageView *bottomView = [[[UIImageView alloc] init] autorelease];
    bottomView.frame = kMainViewBounds;
    bottomView.image = [UIImage imageNamed:@"背景"];
    bottomView.userInteractionEnabled = YES;
    
    if (index) {
        // video
        UIButton *videoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        videoButton.bounds = CGRectMake(0, 0, 40, 40);
        videoButton.center = CGPointMake(CGRectGetMaxX(bottomView.bounds) * 0.87,
                                         CGRectGetMinY(bottomView.bounds) + 40);
        [videoButton setBackgroundImage:[UIImage imageNamed:@"视频图标_05"]
                               forState:UIControlStateNormal];
        [videoButton addTarget:self
                        action:@selector(playVideo:)
              forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:videoButton];
        
    } else {
        // search bar background
        UIImage *searchImageBackground = [UIImage imageNamed:@"搜索框_11"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:searchImageBackground];
        imageView.bounds = CGRectMake(0, 0, 230, 40);
        imageView.center = CGPointMake(CGRectGetMaxX(bottomView.bounds) * 0.85,
                                       CGRectGetMinY(bottomView.bounds) + 42);
        imageView.userInteractionEnabled = YES;
        [bottomView addSubview:imageView];
        [imageView release];
        
        // left button view
        UIButton *leftViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftViewButton setBackgroundImage:[UIImage imageNamed:@"choose_01"]
                                  forState:UIControlStateNormal];
        [leftViewButton addTarget:self
                           action:@selector(searchAction:)
                 forControlEvents:UIControlEventTouchUpInside];
        leftViewButton.bounds = CGRectMake(0, 0, 50, 40);
        
        // search bar textfield
        CGRect searchBarFrame = imageView.bounds;
        UITextField *searchTextField = [[UITextField alloc] initWithFrame:searchBarFrame];
        searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        searchTextField.textAlignment = NSTextAlignmentLeft;
        searchTextField.leftView = leftViewButton;
        searchTextField.leftViewMode = UITextFieldViewModeAlways;
        searchTextField.backgroundColor = [UIColor clearColor];
        [imageView addSubview:searchTextField];
        [searchTextField release];
    }
    return bottomView;
}

- (void)playVideo:(UIButton *)sender
{
    //TODO: 播放视频
#pragma mark - 播放视频
}

- (void)searchAction:(UIButton *)sender
{
    // pop view
    if (!_isSearchBarVisiable) {
        CGRect frame = CGRectMake(690, 70, 200, 150);
        DDPopVIew *popView = [[DDPopVIew alloc] initWithFrame:frame];
        [_currentSelectedView addSubview:popView];
        [popView release];
        _isSearchBarVisiable = YES;
    } else {
        [[_currentSelectedView.subviews lastObject] removeFromSuperview];
        _isSearchBarVisiable = NO;
    }
}

- (void)loadConsultView
{
    _segmentedControl.selectedSegmentIndex = 0;
    [self selectedIndex:0];
    
    _currentSelectedView = [self loadBottomViewWithSelectedIndex:0];
    [self addSubview:_currentSelectedView];
    [self sendSubviewToBack:_currentSelectedView];
    
    CGFloat verticalValue = CGRectGetMaxY(_segmentedControl.frame) + 10;
    CGRect frame = CGRectMake(0, verticalValue, kMainViewWidth, kMainViewHeight - verticalValue);
    DDConsultView *consultView = [[DDConsultView alloc] initWithFrame:frame];
    [_currentSelectedView addSubview:consultView];
    [consultView release];
}

- (void)loadComboView
{
    _segmentedControl.selectedSegmentIndex = 1;
    [self selectedIndex:1];
    
    _currentSelectedView = [self loadBottomViewWithSelectedIndex:1];
    [self addSubview:_currentSelectedView];
    [self sendSubviewToBack:_currentSelectedView];
    
    CGFloat verticalValue = CGRectGetMaxY(_segmentedControl.frame) + 10;
    CGRect frame = CGRectMake(0, verticalValue, kMainViewWidth, kMainViewHeight - verticalValue);
    DDComboView *comboView = [[DDComboView alloc] initWithFrame:frame];
    [_currentSelectedView addSubview:comboView];
    [comboView release];
}

- (void)loadOptionalView
{
    _segmentedControl.selectedSegmentIndex = 2;
    [self selectedIndex:2];
    
    _currentSelectedView = [self loadBottomViewWithSelectedIndex:2];
    [self addSubview:_currentSelectedView];
    [self sendSubviewToBack:_currentSelectedView];

    CGFloat verticalValue = CGRectGetMaxY(_segmentedControl.frame) + 10;
    CGRect frame = CGRectMake(0, verticalValue, kMainViewWidth, kMainViewHeight - verticalValue);
    DDOptionalView *optionView = [[DDOptionalView alloc] initWithFrame:frame];
    [_currentSelectedView addSubview:optionView];
    [optionView release];
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
    if (_isSearchBarVisiable) {
        [[_currentSelectedView.subviews lastObject] removeFromSuperview];
        _isSearchBarVisiable = NO;
    }
}

@end
