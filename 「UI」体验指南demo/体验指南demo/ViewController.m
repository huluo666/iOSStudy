//
//  ViewController.m
//  体验指南demo
//
//  Created by 张鹏 on 14-2-21.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "ViewController.h"

#define ZP_IMAGE_WITH_NAME(__NAME) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:__NAME]]
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface ViewController () {
    
    NSMutableArray *_imageViewList; // 视图重用集合
    NSArray *_imageViewLocationList; // 用于存储5个坐标点
    
    UIView *_currentView; // 当前居中放大显示的图片视图
    
    UIImageView *_titleImageView; // 介绍文字视图，此处将重用该标题视图
    NSArray *_titleImageNameList; // 介绍文字图片数组
    NSInteger _currentTitleIndex; // 记录当前显示的标题索引
    
    BOOL _reversed; // 跟踪是否需要反向移动（向左移动）
    BOOL _animating; // 跟踪动画是否在执行中，动画以缩小为开始，放大后文字出现为结束，在这个过程中应避免动画的重复执行，否则会出现显示异常
}

- (void)initializeDataSource;
- (void)initializeUserInterface;
- (void)processSwipeGesture:(UISwipeGestureRecognizer *)swipe;

/*
 * 此处主要考核了动画的连续执行处理，需要注意以下要点：
 * 1.一个顺序执行的动画流程包括：缩小（标题消失）-> 移动 -> 放大 -> 标题显示
 * 2.在一个动画流程执行完成之前，禁止用户交互，在完成后可以通过滑动立即执行下一个流程
 */

- (void)startAnimation; // 动画开始执行
- (void)startScaleSmallerAnimation;// 缩小动画
- (void)startScaleBiggerAnimation;// 放大动画
- (void)startTitleShowAnimation; // 标题显示动画
- (void)startTitleDismissAnimation; // 标题隐藏动画
- (void)startMoveAnimation; // 移动动画

// 由于需要循环展示标题问题，则需要计算真实索引
- (NSInteger)acurateIndexWithIndex:(NSInteger)index;

@end

@implementation ViewController

- (id)init
{
    self = [super init];
    if (self) {
        
        _currentTitleIndex = 0;
        _reversed = NO;
        _animating = NO;
        
    }
    return self;
}

- (void)dealloc {
    
    [_imageViewLocationList release];
    [_imageViewList         release];
    [_titleImageView        release];
    [_titleImageNameList    release];
    _currentView = nil;
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)initializeDataSource {
    
    _imageViewLocationList = [@[[NSValue valueWithCGPoint:CGPointMake(-100, 550)],
                                [NSValue valueWithCGPoint:CGPointMake(175, 550)],
                                [NSValue valueWithCGPoint:CGPointMake(425, 550)],
                                [NSValue valueWithCGPoint:CGPointMake(800, 550)],
                                [NSValue valueWithCGPoint:CGPointMake(1200, 550)]] retain];
    
    _titleImageNameList = [@[@"标题ipad.png", @"标题iphone.png", @"标题棕.png", @"标题紫.png"] retain];
}

- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 背景图
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_WIDTH)];
    backgroundImageView.image = ZP_IMAGE_WITH_NAME(@"1图底副本.jpg");
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:backgroundImageView];
    [backgroundImageView release];
    
    // 初始化图片
    _imageViewList = [[NSMutableArray alloc] init];
    NSArray *imageNameList = @[@"menuitem0.png", @"menuitem1.png", @"menuitem2.png", @"menuitem3.png"];
    for (int i = 0; i < 4; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.bounds = CGRectMake(0, 0, 150, 200);
        imageView.center = [_imageViewLocationList[i] CGPointValue];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = ZP_IMAGE_WITH_NAME(imageNameList[i]);
        imageView.layer.anchorPoint = CGPointMake(0.5, 0.8);
        [self.view addSubview:imageView];
        [_imageViewList addObject:imageView];
        [imageView release];
        // 初始情况下放大最后一个iPad图片
        if (i == 3) {
            imageView.transform = CGAffineTransformScale(imageView.transform, 3, 3);
            _currentView = imageView;
        }
    }
    
    _titleImageView = [[UIImageView alloc] init];
    _titleImageView.bounds = CGRectMake(0, 0, 500, 300);
    _titleImageView.contentMode = UIViewContentModeScaleAspectFit;
    _titleImageView.layer.anchorPoint = CGPointMake(-1, 0);
    
    // 左滑
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(processSwipeGesture:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipe];
    [leftSwipe release];
    
    // 右滑
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc]
                                            initWithTarget:self
                                            action:@selector(processSwipeGesture:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipe];
    [rightSwipe release];
    
    // 动画开始执行
    [self startAnimation];
}

- (void)processSwipeGesture:(UISwipeGestureRecognizer *)swipe {
    
    // 取消之前注册的所有延迟执行的动画
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    // 判断移动方向
    _reversed = swipe.direction == UISwipeGestureRecognizerDirectionLeft ? YES : NO;
    // 检测到用户交互后首先执行缩小动画，缩小动画作为所有动画流程的开始
    [self startScaleSmallerAnimation];
}

- (NSInteger)acurateIndexWithIndex:(NSInteger)index {
    
    NSInteger maximumIndex = [_titleImageNameList count] - 1;
    if (index > maximumIndex) {
        index = 0;
    }
    else if (index < 0) {
        index = maximumIndex;
    }
    return index;
}

#pragma mark - Animation processing methods

- (void)startAnimation {
    
    [self performSelector:@selector(startTitleShowAnimation) withObject:nil afterDelay:1.0];
}

- (void)startScaleSmallerAnimation {
    
    // 若动画已经在执行，则避免重复执行，这里非常重要
    if (_animating) {
        return;
    }
    _animating = YES;
    
    [UIView animateWithDuration:0.5 animations:^{
        _currentView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self startMoveAnimation];
    }];
    
    // 在图片缩小的同时隐藏标题介绍文字
    [self startTitleDismissAnimation];
}

- (void)startScaleBiggerAnimation {
    
    // 缩小图片动画
    [UIView animateWithDuration:0.5 animations:^{
        _currentView.transform = CGAffineTransformMakeScale(3, 3);
    } completion:^(BOOL finished) {
        [self startTitleShowAnimation];
    }];
}

- (void)startTitleShowAnimation {
    
    _titleImageView.image = ZP_IMAGE_WITH_NAME(_titleImageNameList[_currentTitleIndex]);
    _titleImageView.alpha = 1.0;
    _titleImageView.center = CGPointMake(-500, 50);
    _titleImageView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    [self.view addSubview:_titleImageView];
    [UIView animateWithDuration:0.5 animations:^{
        _titleImageView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        _animating = NO;
        [self performSelector:@selector(startScaleSmallerAnimation) withObject:nil afterDelay:3];
    }];
}

- (void)startTitleDismissAnimation {
    
    // 缩小并移动至右下角位置
    [UIView animateWithDuration:0.5 animations:^{
        _titleImageView.alpha = 0.5;
        _titleImageView.center = CGPointMake(CGRectGetMaxX(self.view.bounds) - 250,
                                             CGRectGetMaxY(self.view.bounds));
        _titleImageView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    } completion:^(BOOL finished) {
        [_titleImageView removeFromSuperview];
    }];
}

- (void)startMoveAnimation {
    
    // 判断是否需要反向移动，默认向右为正向移动，反向为向左
    if (!_reversed) {
        [UIView animateWithDuration:0.5 animations:^{
            for (int i = 0; i < 4; i++) {
                UIView *view = _imageViewList[i];
                view.center = [_imageViewLocationList[i + 1] CGPointValue];
            }
        } completion:^(BOOL finished) {
            // 视图集合顺序调整
            UIView *lastView = [_imageViewList lastObject];
            lastView.center = [_imageViewLocationList[0] CGPointValue];
            [_imageViewList removeLastObject];
            [_imageViewList insertObject:lastView atIndex:0];
            // 记录当前需要缩放的视图
            _currentView = [_imageViewList lastObject];
            // 计算当前真实索引
            _currentTitleIndex = [self acurateIndexWithIndex:++_currentTitleIndex];
            [self startScaleBiggerAnimation];
        }];
    }
    else {
        // 视图集合顺序调整，注意向左需要先调整顺序
        UIView *firstView = [_imageViewList firstObject];
        firstView.center = [[_imageViewLocationList lastObject] CGPointValue];
        [_imageViewList removeObjectAtIndex:0];
        [_imageViewList addObject:firstView];
        [UIView animateWithDuration:0.5 animations:^{
            for (int i = 0; i < 4; i++) {
                UIView *view = _imageViewList[i];
                view.center = [_imageViewLocationList[i] CGPointValue];
            }
        } completion:^(BOOL finished) {
            // 记录当前需要缩放的视图
            _currentView = [_imageViewList lastObject];
            // 计算当前真实索引
            _currentTitleIndex = [self acurateIndexWithIndex:--_currentTitleIndex];
            [self startScaleBiggerAnimation];
        }];
    }
}

@end



