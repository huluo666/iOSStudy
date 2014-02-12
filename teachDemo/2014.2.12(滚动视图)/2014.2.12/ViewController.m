//
//  ViewController.m
//  2014.2.12
//
//  Created by 张鹏 on 14-2-12.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "ViewController.h"

#define IMAGE_WITH_NAME(__NAME) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:__NAME]]

@interface ViewController () <UIScrollViewDelegate> {
    
    UIScrollView *_scrollView;
    UIPageControl *_pageControl; // 分页控件
    NSMutableArray *_imageNameList;
    NSMutableArray *_imageViewList;
    NSInteger _currentIndex;
    
    // 计时器：延迟调用方法或者以一定时间间隔调用指定方法
    NSTimer *_timer;
}

// 加载数据
- (void)initializeDataSource;
// 加载界面
- (void)initializeUserInterface;

// 自动滚动
- (void)autoPlay;
- (void)processTimer:(NSTimer *)timer;

- (void)stopTimer;

// 获取实际图片展示索引
- (NSInteger)realIndexWithIndex:(NSInteger)index;
// 刷新界面
- (void)updateUserInterfaceWithScrollViewContentOffset:(CGPoint)contentOffset;

@end

@implementation ViewController

- (id)init {
    
    self = [super init];
    if (self) {
        
        self.title = @"UIScrollView";
        
    }
    return self;
}

- (void)dealloc {
    
    [_scrollView    release];
    [_pageControl   release];
    [_imageNameList release];
    [_imageNameList release];
    [_timer         release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // 通常情况下，首先加载数据，其次加载界面信息
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)initializeDataSource {
    
    // 加载图片名称
    _imageNameList = [[NSMutableArray alloc] init];
    for (int i = 1; i <= 8; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%d.png", i];
        [_imageNameList addObject:imageName];
    }
}

- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor blackColor];
    
    // iOS7中存在UINavigationController的情况
    // 配置是否自动添加scrollView内容偏移（inset）
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 配置是否进行控制器视图的延展（导航栏、工具栏）
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    NSUInteger count = [_imageNameList count];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    // 配置委托对象
    _scrollView.delegate = self;
    // 配置内容空间大小范围
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.bounds) * 3,
                                         CGRectGetHeight(_scrollView.bounds));
    // 配置内容偏移位置
    _scrollView.contentOffset = CGPointMake(CGRectGetWidth(_scrollView.bounds), 0);
    // 配置是否分页
    _scrollView.pagingEnabled = YES;
    // 配置位置指示器颜色
    _scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    // 隐藏指示器
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    _currentIndex = 0;
    
    // 初始化分页控件
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.bounds = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 30);
    _pageControl.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMaxY(self.view.bounds) - 150);
    // 配置当前页
    _pageControl.currentPage = _currentIndex;
    // 配置总页数
    _pageControl.numberOfPages = count;
    // 配置总页数指示色
//    _pageControl.pageIndicatorTintColor = [UIColor yellowColor];
    // 配置当前页数指示色
//    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    [self.view addSubview:_pageControl];
    
    _imageViewList = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(_scrollView.bounds) * i, 0, CGRectGetWidth(_scrollView.bounds), CGRectGetHeight(_scrollView.bounds))];
        NSInteger index = [self realIndexWithIndex:_currentIndex + i - 1];
        imageView.image = IMAGE_WITH_NAME(_imageNameList[index]);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_scrollView addSubview:imageView];
        [_imageViewList addObject:imageView];
        [imageView release];
    }
    
    // 开始自动播放
    // 基于延迟操作实现
//    [self performSelector:@selector(autoPlay) withObject:nil afterDelay:1.5];
    
    // 基于NSTimer计时器的实现
//    _timer = [[NSTimer scheduledTimerWithTimeInterval:1.5
//                                               target:self
//                                             selector:@selector(processTimer:)
//                                             userInfo:nil
//                                              repeats:YES] retain];
}

- (void)autoPlay {
    
    // 判断是否超过最大索引位置，若超过则回到第一个索引位置
    if (++_currentIndex > [_imageNameList count] - 1) {
        _currentIndex = 0;
    }
    
    [_scrollView setContentOffset:CGPointMake(CGRectGetWidth(_scrollView.bounds) * _currentIndex, 0)
                         animated:YES];
    
    [self performSelector:_cmd withObject:nil afterDelay:1.5];
}

- (void)processTimer:(NSTimer *)timer {
    
    // 判断是否超过最大索引位置，若超过则回到第一个索引位置
    if (++_currentIndex > [_imageNameList count] - 1) {
        _currentIndex = 0;
    }
    
    [_scrollView setContentOffset:CGPointMake(CGRectGetWidth(_scrollView.bounds) * _currentIndex, 0)
                         animated:YES];
}

- (void)stopTimer {
    
    // NSTimer在不需要使用的时候需要手动停止，否则注册的对象无法释放
    // 判断timer是否激活
    if ([_timer isValid]) {
        // 若激活，则停止，并释放
        [_timer invalidate];
        [_timer release];
    }
}

- (NSInteger)realIndexWithIndex:(NSInteger)index {
    
    // 获取最大索引
    NSInteger maximumIndex = [_imageNameList count] - 1;
    // 判断真实索引位置
    if (index > maximumIndex) {
        index = 0;
    }
    else if (index < 0) {
        index = maximumIndex;
    }
    return index;
}

- (void)updateUserInterfaceWithScrollViewContentOffset:(CGPoint)contentOffset {
    
    BOOL shouldUpdate = NO;
    // 向右
    if (contentOffset.x >= CGRectGetWidth(_scrollView.bounds) * 2) {
        shouldUpdate = YES;
        _currentIndex = [self realIndexWithIndex:++_currentIndex];
    }
    // 向左
    else if (contentOffset.x <= 0) {
        shouldUpdate = YES;
        _currentIndex = [self realIndexWithIndex:--_currentIndex];
    }
    
    // 判断是否需要更新
    if (!shouldUpdate) {
        return;
    }
    
    _pageControl.currentPage = _currentIndex;
    
    // 更新所有imageView显示的图片
    NSString *imageName1 = [_imageNameList objectAtIndex:[self realIndexWithIndex:_currentIndex - 1]];
    NSString *imageName2 = [_imageNameList objectAtIndex:[self realIndexWithIndex:_currentIndex]];
    NSString *imageName3 = [_imageNameList objectAtIndex:[self realIndexWithIndex:_currentIndex + 1]];
    
    // 左
    [(UIImageView *)_imageViewList[0] setImage:IMAGE_WITH_NAME(imageName1)];
    // 中
    [(UIImageView *)_imageViewList[1] setImage:IMAGE_WITH_NAME(imageName2)];
    // 右
    [(UIImageView *)_imageViewList[2] setImage:IMAGE_WITH_NAME(imageName3)];
    
    // 恢复可见区域
    _scrollView.contentOffset = CGPointMake(CGRectGetWidth(_scrollView.bounds), 0);
}

#pragma mark - <UIScrollViewDelegate>

// scrollview滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
//    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    [self updateUserInterfaceWithScrollViewContentOffset:scrollView.contentOffset];
}

// 用户将要拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
//    NSLog(@"%@", NSStringFromSelector(_cmd));
}

// 用户停止拖动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
//    NSLog(@"%@", NSStringFromSelector(_cmd));
}

// scrollView将要开始减速
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
//    NSLog(@"%@", NSStringFromSelector(_cmd));
}

// scrollView停止减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
//    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    [self updateUserInterfaceWithScrollViewContentOffset:scrollView.contentOffset];
}



@end
















