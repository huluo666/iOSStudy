//
//  DDAbroad.m
//  「项目」中国银行
//
//  Created by 萧川 on 3/7/14.
//  Copyright (c) 2014 CUAN. All rights reserved.
//

#import "DDAbroad.h"
#import "DDCombo.h"
#import "DDOptional.h"
#import "DDShowDetail.h"

@interface DDAbroad () <UITableViewDelegate, UITableViewDataSource>
{
    UIView *_currentSelectedView;               // 当前选中视图
    NSMutableArray *_comboLocationList;         // 用于存储5个坐标点
    UISegmentedControl *_segmentedControl;      // 分段控件
    
    NSArray *_images;                           // 未选中状态标题图片
    NSArray *_imgaesSelected;                   // 选中状态标题图片
    
    NSMutableArray *_combos;                    // 套餐模式控件数组
    BOOL _isAnimating;                          // 是否正在动画中
}

// 选中事件
- (void)segmentAction:(UISegmentedControl *)sender;
// 选中segment
- (void)selectedIndex:(NSInteger)index;

// 加载政策咨询视图
- (void)loadConsultView;
// 加载套餐模式视图
- (void)loadComboView;
// 加载自选模式视图
- (void)loadOptionalView;

// 响应滑动手势
- (void)processSwipeGesture:(UISwipeGestureRecognizer *)swipe;

// 为view添加缩放动画
- (void)startBasicScaleAnimationFromValue:(NSValue *)fromeValue
                                  toValue:(NSValue *)toValue
                                  ForView:(UIView *)view
                    withAnimationDuration:(NSTimeInterval)duration;

@end

@implementation DDAbroad

- (void)dealloc
{
    _currentSelectedView = nil;
    [_comboLocationList release];
    _segmentedControl = nil;
    [_images  release];
    [_imgaesSelected release];
    [_combos release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 标题
        UIImage *consult = [UIImage imageNamed:@"a_07@2x"];
        UIImage *combo = [UIImage imageNamed:@"b_08@2x"];
        UIImage *optional = [UIImage imageNamed:@"c_09@2x"];
        if ([UIImage instancesRespondToSelector:@selector(imageWithRenderingMode:)]) {
            consult = [consult imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            combo = [combo imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            optional = [optional imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        _images = [@[consult, combo, optional] retain];

        // 标题选中状态
        UIImage *consultSelected = [UIImage imageNamed:@"aa_07@2x"];
        UIImage *comboSelected = [UIImage imageNamed:@"bb_08@2x"];
        UIImage *optionalSelected = [UIImage imageNamed:@"cc_09@2x"];
        if ([UIImage instancesRespondToSelector:@selector(imageWithRenderingMode:)]) {
            consultSelected = [consultSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            comboSelected = [comboSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            optionalSelected = [optionalSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        _imgaesSelected = [@[consultSelected, comboSelected, optionalSelected] retain];
        
        // 分段控件
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:_images];
        segmentedControl.tintColor = [UIColor clearColor];
        segmentedControl.bounds = CGRectMake(0, 0, 400, 50);
        segmentedControl.center = CGPointMake(CGRectGetMidX(self.bounds), 50);
        [segmentedControl addTarget:self action:@selector(segmentAction:)
                   forControlEvents:UIControlEventValueChanged];
        [self addSubview:segmentedControl];
        _segmentedControl = segmentedControl;
        [segmentedControl release];

        
        // 初始化展示视图
        _combos = [[NSMutableArray alloc] init];
        
        // 初始化三个视图的center坐标点
       CGRect bottomViewBounds = CGRectMake(0,
                                            0,
                                            kMainViewWidth,
                                            CGRectGetMaxY(self.bounds) - CGRectGetMaxY(_segmentedControl.frame) - kBottomImageViewHeight);
        
        CGPoint bottomViewCenter = CGPointMake(CGRectGetMidX(bottomViewBounds),
                                               CGRectGetMidY(bottomViewBounds));
        CGFloat bottomViewCenterX = CGRectGetMidX(bottomViewBounds);
        CGFloat bottomViewCenterY = CGRectGetMidY(bottomViewBounds);
        _comboLocationList = [@[[NSValue valueWithCGPoint:CGPointMake(bottomViewCenterX - 700, bottomViewCenterY)],
                                [NSValue valueWithCGPoint:CGPointMake(bottomViewCenterX - 400, bottomViewCenterY)],
                                [NSValue valueWithCGPoint:bottomViewCenter],
                                [NSValue valueWithCGPoint:CGPointMake(bottomViewCenterX + 400, bottomViewCenterY)],
                                [NSValue valueWithCGPoint:CGPointMake(bottomViewCenterX + 700, bottomViewCenterY)]] mutableCopy];
    }
    
//        [self loadConsultView];
        [self loadComboView];
    return self;
}

- (void)segmentAction:(UISegmentedControl *)sender
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

- (void)loadConsultView
{
    [_currentSelectedView removeFromSuperview];
    
    _segmentedControl.selectedSegmentIndex = 0;
    [self selectedIndex:0];
    
    // tableView
    UITableView *tableView = [[UITableView alloc] init];
    tableView.bounds = CGRectMake(0, 0, 600, 400);
    tableView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.rowHeight = 60;
    _currentSelectedView = tableView;
    [self addSubview:tableView];
    [tableView release];
}

- (void)loadComboView
{
    [_currentSelectedView removeFromSuperview];
    _segmentedControl.selectedSegmentIndex = 1;
    [self selectedIndex:1];
    
    // 初始化底图
    UIView *bottomView = [[UIView alloc] init];
    bottomView.bounds = CGRectMake(0,
                                   0,
                                   kMainViewWidth,
                                   CGRectGetMaxY(self.bounds) - CGRectGetMaxY(_segmentedControl.frame) - kBottomImageViewHeight);
    bottomView.center = CGPointMake(CGRectGetMidX(self.bounds),
                                    CGRectGetMidY(bottomView.bounds) + CGRectGetMaxY(_segmentedControl.frame));
    bottomView.backgroundColor = [UIColor clearColor];
    _currentSelectedView = bottomView;
    [self addSubview:bottomView];
    [bottomView release];
    
    // 左滑
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(processSwipeGesture:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [bottomView addGestureRecognizer:leftSwipe];
    [leftSwipe release];
    
    // 右滑
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc]
                                            initWithTarget:self
                                            action:@selector(processSwipeGesture:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [bottomView addGestureRecognizer:rightSwipe];
    [rightSwipe release];
    
    // 清空上次装的数据
    if (_combos) {
        [_combos release];
        _combos = nil;
        _combos = [@[] mutableCopy];
    }
    
    for (int i = 0; i < 5; i++) {
        DDCombo *combo = [[DDCombo alloc] initWithFrame:CGRectZero];
        combo.center =  [_comboLocationList[i] CGPointValue];
        combo.titleLabel.text = [NSString stringWithFormat:@"测试标题%d", i];
        [bottomView addSubview:combo];
        [_combos addObject:combo];
        [combo release];
        
        // 默认放大第三个
        if (2 == i) {
            [self startBasicScaleAnimationFromValue:@1.2
                                            toValue:@1.2
                                            ForView:combo
                              withAnimationDuration:0];
        }
    }
}

- (void)loadOptionalView
{
    [_currentSelectedView removeFromSuperview];
    
    [self selectedIndex:2];
    _segmentedControl.selectedSegmentIndex = 2;
    
    DDOptional *optionalView = [[DDOptional alloc] initWithFrame:CGRectZero];
    optionalView.bounds = CGRectMake(0, 0, 300, 300);
    optionalView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    optionalView.tapAction = ^(UIButton *sender) {
        if (sender.tag == kDetailButtonTag) {
            DDShowDetail *detail = [[DDShowDetail alloc] initWithFrame:CGRectZero];
            [self addSubview:detail];
            [detail release];
        } else {
#pragma mark - TODO
            NSLog(@"选购");
        }
    };
    
    _currentSelectedView = optionalView;
    [self addSubview:optionalView];
    [optionalView release];
}

- (void)selectedIndex:(NSInteger)index
{
    if (0 == index) {
        [_segmentedControl setImage:_imgaesSelected[0] forSegmentAtIndex:0];
        [_segmentedControl setImage:_images[1] forSegmentAtIndex:1];
        [_segmentedControl setImage:_images[2] forSegmentAtIndex:2];
    }
    if (1 == index) {
        [_segmentedControl setImage:_imgaesSelected[1] forSegmentAtIndex:1];
        [_segmentedControl setImage:_images[0] forSegmentAtIndex:0];
        [_segmentedControl setImage:_images[2] forSegmentAtIndex:2];
    }
    if (2 == index) {
        [_segmentedControl setImage:_imgaesSelected[2] forSegmentAtIndex:2];
        [_segmentedControl setImage:_images[0] forSegmentAtIndex:0];
        [_segmentedControl setImage:_images[1] forSegmentAtIndex:1];
    }
}

- (void)processSwipeGesture:(UISwipeGestureRecognizer *)swipe
{
    // 正在动画中不就不执行动画
    if (_isAnimating) {
        return;
    }
    
    // 标记开始动画
    _isAnimating = YES;
    
    // 判断移动方向
    if (UISwipeGestureRecognizerDirectionLeft == swipe.direction) {
        // 向左移动
        // 将控件数组中的所有控件前移动一格
        // 第3个缩小的同时第4个放大
        // 先调整坐标顺序
        UIView *firstCombo = [_combos firstObject];
        firstCombo.center = [[_comboLocationList lastObject] CGPointValue];
        [_combos removeObjectAtIndex:0];
        [_combos addObject:firstCombo];
        
        // 缩放动画
        [self startBasicScaleAnimationFromValue:@1.2
                                        toValue:@1
                                        ForView:_combos[1]
                          withAnimationDuration:kAnimateDuration / 2];
        [self startBasicScaleAnimationFromValue:@1
                                        toValue:@1.2 ForView:_combos[2]
                          withAnimationDuration:kAnimateDuration / 2];
    } else {
        // 向右移动
        // 调整坐标顺序
        UIView *lastCombo = [_combos lastObject];
        lastCombo.center = [[_comboLocationList firstObject] CGPointValue];
        [_combos removeObject:lastCombo];
        [_combos insertObject:lastCombo atIndex:0];
        
        // 缩放动画
        [self startBasicScaleAnimationFromValue:@1.2
                                        toValue:@1
                                        ForView:_combos[3]
                          withAnimationDuration:kAnimateDuration / 2];
        [self startBasicScaleAnimationFromValue:@1
                                        toValue:@1.2
                                        ForView:_combos[2]
                          withAnimationDuration:kAnimateDuration / 2];
    }
    
    // 移动一格
    [UIView animateWithDuration:kAnimateDuration / 2 animations:^{
        for (int i = 0; i < 5; i++) {
            UIView *combo = _combos[i];
            combo.center = [_comboLocationList[i] CGPointValue];
        }
    } completion:^(BOOL finished) {
        _isAnimating = NO;
    }];
}

#pragma mark - 缩放动画

- (void)startBasicScaleAnimationFromValue:(NSValue *)fromeValue
                                  toValue:(NSValue *)toValue
                                  ForView:(UIView *)view
                    withAnimationDuration:(NSTimeInterval)duration
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = duration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fromValue = fromeValue;
    animation.toValue = toValue;
    animation.removedOnCompletion = NO;
    animation.delegate = self;
    animation.fillMode = kCAFillModeForwards;
    [view.layer addAnimation:animation forKey:@"transform.scale"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    _isAnimating = NO;
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier  = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2
                                       reuseIdentifier:identifier] autorelease];
        UIImageView *backgroundView = [[UIImageView alloc]
                                       initWithImage:[UIImage imageNamed:@"excel_23"]];
        cell.backgroundView = backgroundView;
        [backgroundView release];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.numberOfLines = 1;
        cell.detailTextLabel.textAlignment = NSTextAlignmentCenter;
        cell.detailTextLabel.textColor = [UIColor redColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];

    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld------------", indexPath.row];

    return cell;
}

#pragma mark - <UITableViewDelegate>

@end
