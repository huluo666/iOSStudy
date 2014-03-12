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
#import "DDPopView.h"

@interface DDAbroad () <
    UITableViewDelegate,
    UITableViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDataSource>
{
    UIView *_currentSelectedView;               // 当前选中视图
    NSMutableArray *_comboLocationList;         // 用于存储5个坐标点
    UISegmentedControl *_segmentedControl;      // 分段控件
    
    NSArray *_images;                           // 未选中状态标题图片
    NSArray *_imgaesSelected;                   // 选中状态标题图片
    
    NSMutableArray *_combos;                    // 套餐模式控件数组
    BOOL _isAnimating;                          // 是否正在动画中
    
    BOOL isSearchBarVisiable;                   // 搜索框是否可见
}

// 加载内容背景视图
- (UIView *)loadBottomViewWithSelectedIndex:(NSInteger)index;

// 选中事件
- (void)segmentAction:(UISegmentedControl *)sender;
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
    self.frame = CGRectMake(0, 0, kMainViewWidth, kMainViewHeight);
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
        
        // 分段控件下面的阴影
        UIImageView *shadowView = [[UIImageView alloc] init];
        shadowView.bounds = CGRectMake(0, 0, CGRectGetWidth(segmentedControl.bounds), 10);
        shadowView.center = CGPointMake(CGRectGetMidX(segmentedControl.frame),
                                        CGRectGetMaxY(segmentedControl.frame) + CGRectGetMidY(shadowView.bounds));
        shadowView.image = [UIImage imageNamed:@"pshadow_08"];
        [self addSubview:shadowView];
        [shadowView release];
        
        // 初始化展示视图
        _combos = [[NSMutableArray alloc] init];
        
        // 初始化三个视图的center坐标点
       CGRect bottomViewBounds = CGRectMake(0,
                                            0,
                                            kMainViewWidth,
                                            kMainViewHeight + 50);
        
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
//        [self loadComboView];
    [self loadOptionalView];
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

- (UIView *)loadBottomViewWithSelectedIndex:(NSInteger)index
{
     // 初始化底图
    UIImageView *bottomView = [[[UIImageView alloc] init] autorelease];
    bottomView.frame = kMainViewBounds;
    bottomView.image = [UIImage imageNamed:@"背景"];
    bottomView.userInteractionEnabled = YES;
    _currentSelectedView = bottomView;
    [self addSubview:bottomView];
    [self sendSubviewToBack:bottomView];
    
    if (index) {
        // video
        UIButton *videoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        videoButton.bounds = CGRectMake(0, 0, 50, 50);
        videoButton.center = CGPointMake(CGRectGetMaxX(bottomView.bounds) * 0.85,
                                         CGRectGetMinY(bottomView.bounds) + 50);
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
        imageView.bounds = CGRectMake(0, 0, 230, 50);
        imageView.center = CGPointMake(CGRectGetMaxX(bottomView.bounds) * 0.85,
                                       CGRectGetMinY(bottomView.bounds) + 50);
        imageView.userInteractionEnabled = YES;
        [bottomView addSubview:imageView];
        [imageView release];
        
        // left button view
        UIButton *leftViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftViewButton setBackgroundImage:[UIImage imageNamed:@"choose_01"]
                                  forState:UIControlStateNormal];
        [leftViewButton addTarget:self action:@selector(searchAction:)
                 forControlEvents:UIControlEventTouchUpInside];
        leftViewButton.bounds = CGRectMake(0, 0, 50, 50);
        
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
    if (!isSearchBarVisiable) {
        CGRect frame = CGRectMake(690, 70, 200, 150);
        DDPopVIew *popView = [[DDPopVIew alloc] initWithFrame:frame];
        [_currentSelectedView addSubview:popView];
        [popView release];
        isSearchBarVisiable = YES;
    } else {
        [[_currentSelectedView.subviews lastObject] removeFromSuperview];
        isSearchBarVisiable = NO;
    }
}

- (void)loadConsultView
{
    [_currentSelectedView removeFromSuperview];
    
    _segmentedControl.selectedSegmentIndex = 0;
    [self selectedIndex:0];

    UIView *bottomView = [self loadBottomViewWithSelectedIndex:0];
    
    // tableView baackground
    UIImageView *tableViewBackgorundView = [[UIImageView alloc] init];
    tableViewBackgorundView.frame = kMainViewBounds;
    tableViewBackgorundView.image = [UIImage imageNamed:@"背景"];
    
    // tableView
    UITableView *tableView = [[UITableView alloc] init];
    tableView.bounds = CGRectMake(0, 0, 800, 450);
    tableView.center = CGPointMake(CGRectGetMidX(bottomView.bounds),
                                   CGRectGetMidY(bottomView.bounds) * 1.1);
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.rowHeight = 60;
    tableView.backgroundView = tableViewBackgorundView;
    [tableViewBackgorundView release];
    [bottomView addSubview:tableView];
    [tableView release];
    
    // 上下两条阴影
    UIImageView *upShadowView = [[UIImageView alloc] init];
    upShadowView.bounds = CGRectMake(0, 0, CGRectGetWidth(tableView.bounds) * 1.1, 5);
    upShadowView.center = CGPointMake(CGRectGetMidX(tableView.frame),
                                      CGRectGetMinY(tableView.frame) + CGRectGetMidY(upShadowView.bounds));
    upShadowView.image = [UIImage imageNamed:@"up_19"];
    [bottomView addSubview:upShadowView];
    [upShadowView release];
    
    UIImageView *downShadowView = [[UIImageView alloc] init];
    downShadowView.bounds = CGRectMake(0, 0, CGRectGetWidth(tableView.bounds) * 1.1, 5);
    downShadowView.center = CGPointMake(CGRectGetMidX(tableView.frame),
                                      CGRectGetMaxY(tableView.frame) + CGRectGetMidY(downShadowView.bounds));
    downShadowView.image = [UIImage imageNamed:@"down_27"];
    [bottomView addSubview:downShadowView];
    [downShadowView release];
    
    // 两个Label
    UILabel *serialNumberLabel = [[UILabel alloc] init];
    serialNumberLabel.bounds = CGRectMake(0, 0, 125, 40);
    serialNumberLabel.center = CGPointMake(CGRectGetMinX(tableView.frame) + CGRectGetMidX(serialNumberLabel.bounds),
                                           upShadowView.center.y - CGRectGetMidY(serialNumberLabel.bounds));
    serialNumberLabel.font = [UIFont systemFontOfSize:20];
    serialNumberLabel.textColor = [UIColor whiteColor];
    serialNumberLabel.textAlignment = NSTextAlignmentCenter;
    serialNumberLabel.text = @"编号";
    [bottomView addSubview:serialNumberLabel];
    [serialNumberLabel release];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.bounds = CGRectMake(0, 0, 675, 40);
    titleLabel.center = CGPointMake(CGRectGetMaxX(serialNumberLabel.frame) + CGRectGetMidX(titleLabel.bounds),
                                           upShadowView.center.y - CGRectGetMidY(serialNumberLabel.bounds));
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"标题";
    [bottomView addSubview:titleLabel];
    [titleLabel release];
}

- (void)loadComboView
{
    [_currentSelectedView removeFromSuperview];
    _segmentedControl.selectedSegmentIndex = 1;
    [self selectedIndex:1];
    
    UIView *bottomView = [self loadBottomViewWithSelectedIndex:1];
    
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
    
    UIView *bottomView = [self loadBottomViewWithSelectedIndex:2];
    
    // 集合视图
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [layout setItemSize:CGSizeMake(290, 290)];
    [layout setSectionInset:UIEdgeInsetsMake(10, 10, 10, 0)];
    [layout setMinimumInteritemSpacing:10];
    [layout setMinimumLineSpacing:10];
    CGRect frame = CGRectMake(CGRectGetMidX(_segmentedControl.frame) - 900 / 2,
                              CGRectGetMaxY(_segmentedControl.frame) * 1.8,
                              900,
                              320);
    // Collection view
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame
                                                          collectionViewLayout:layout];
    
//    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[UICollectionViewCell class]
       forCellWithReuseIdentifier:@"自选模式"];
    collectionView.pagingEnabled = YES;
    collectionView.contentSize = CGSizeMake(CGRectGetWidth(collectionView.bounds),
                                            2 * CGRectGetHeight(collectionView.bounds));
    [bottomView addSubview:collectionView];
    [collectionView release];

    // 菜单
    UIScrollView *menuView = [[UIScrollView alloc] init];
    menuView.bounds = CGRectMake(0, 0, CGRectGetWidth(collectionView.bounds) * 2 / 3 , 30);
    menuView.center = CGPointMake(CGRectGetMidX(collectionView.frame),
                                  CGRectGetMinY(collectionView.frame) - CGRectGetHeight(menuView.bounds) * 0.8);
    menuView.backgroundColor = [UIColor greenColor];
    [bottomView addSubview:menuView];
    [menuView release];
    
    // 菜单两侧按钮
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"箭头左"] forState:UIControlStateNormal];
    leftButton.bounds = CGRectMake(0, 0, 30, 30);
    leftButton.center = CGPointMake(CGRectGetMinX(menuView.frame) - CGRectGetMidX(leftButton.bounds) * 1.5,
                                    CGRectGetMidY(menuView.frame));
    [bottomView addSubview:leftButton];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"箭头右"] forState:UIControlStateNormal];
    rightButton.bounds = CGRectMake(0, 0, 30, 30);
    rightButton.center = CGPointMake(CGRectGetMaxX(menuView.frame) + CGRectGetMidX(rightButton.bounds) * 1.5,
                                    CGRectGetMidY(menuView.frame));
    [bottomView addSubview:rightButton];
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

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
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
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.numberOfLines = 1;
        cell.detailTextLabel.textAlignment = NSTextAlignmentCenter;
        cell.detailTextLabel.textColor = [UIColor redColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    
    // title view
    UILabel *titleViewLabel = [[UILabel alloc] init];
    titleViewLabel.bounds = CGRectMake(0, 0, 675, tableView.rowHeight);
    titleViewLabel.center = CGPointMake(125 + CGRectGetMidX(titleViewLabel.bounds),
                                        CGRectGetMidY(titleViewLabel.bounds));
    titleViewLabel.text = [NSString stringWithFormat:@"测试标题 %ld", indexPath.row];
    titleViewLabel.textAlignment = NSTextAlignmentCenter;
    titleViewLabel.textColor = [UIColor grayColor];
    [cell.contentView addSubview:titleViewLabel];
    [titleViewLabel release];
    return cell;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"自选模式"
                                                                           forIndexPath:indexPath];
    DDOptional *optionalView = [[DDOptional alloc] initWithFrame:CGRectZero];
    optionalView.bounds = CGRectMake(0, 0, 300, 300);
    optionalView.center = CGPointMake(CGRectGetMidX(cell.bounds), CGRectGetMidY(cell.bounds));
    optionalView.tapAction = ^(UIButton *sender) {
        if (sender.tag == kDetailButtonTag) {
            DDShowDetail *detail = [[DDShowDetail alloc] initWithFrame:CGRectZero];
            [self.superview addSubview:detail];
            [detail release];
        } else {
#pragma mark - TODO
            NSLog(@"选购");
        }
    };
//    cell.backgroundColor = [UIColor grayColor];
    [cell.contentView addSubview:optionalView];
    [optionalView release];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"section:%ld row:%ld",indexPath.section, indexPath.row);
}


@end
