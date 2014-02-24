//
//  ViewController.m
//  2014.2.12
//
//  Created by 张鹏 on 14-2-12.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "AlbumViewController.h"

@interface AlbumViewController () <UIScrollViewDelegate> {
    
    UIScrollView *_scrollView;
    UIPageControl *_pageControl; // 分页控件
    NSMutableArray *_imageNameList;
    NSMutableArray *_imageViewList;
    NSInteger _currentIndex;
}

// 加载数据
- (void)initializeDataSource;
// 加载界面
- (void)initializeUserInterface;
// 获取实际图片展示索引
- (NSInteger)realIndexWithIndex:(NSInteger)index;
// 刷新界面
- (void)updateUserInterfaceWithScrollViewContentOffset:(CGPoint)contentOffset;

@end

@implementation AlbumViewController

- (id)init {
    
    self = [super init];
    if (self) {
        
        self.title = @"相册";
        
    }
    return self;
}

- (void)dealloc {
    
    [_scrollView    release];
    [_pageControl   release];
    [_imageNameList release];
    [_imageViewList release];
    
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
        NSString *imageName = [NSString stringWithFormat:@"相册-%d.png", i];
        [_imageNameList addObject:imageName];
    }
}

- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor blackColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSUInteger count = [_imageNameList count];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.bounds) * 3,
                                         CGRectGetHeight(_scrollView.bounds));
    _scrollView.contentOffset = CGPointMake(CGRectGetWidth(_scrollView.bounds), 0);
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    _currentIndex = 0;
    
    // 初始化分页控件
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.bounds = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 30);
    _pageControl.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMaxY(self.view.bounds) - 150);
    _pageControl.currentPage = _currentIndex;
    _pageControl.numberOfPages = count;
    [self.view addSubview:_pageControl];
    
    _imageViewList = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc]
                                  initWithFrame:CGRectMake(CGRectGetWidth(_scrollView.bounds) * i,
                                                           0,
                                                           CGRectGetWidth(_scrollView.bounds),
                                                           CGRectGetHeight(_scrollView.bounds))];
        NSInteger index = [self realIndexWithIndex:_currentIndex + i - 1];
        imageView.image = IMAGE_WITH_NAME(_imageNameList[index]);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_scrollView addSubview:imageView];
        [_imageViewList addObject:imageView];
        [imageView release];
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
    
    [(UIImageView *)_imageViewList[0] setImage:IMAGE_WITH_NAME(imageName1)];
    [(UIImageView *)_imageViewList[1] setImage:IMAGE_WITH_NAME(imageName2)];
    [(UIImageView *)_imageViewList[2] setImage:IMAGE_WITH_NAME(imageName3)];
    
    // 恢复可见区域
    _scrollView.contentOffset = CGPointMake(CGRectGetWidth(_scrollView.bounds), 0);
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self updateUserInterfaceWithScrollViewContentOffset:scrollView.contentOffset];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self updateUserInterfaceWithScrollViewContentOffset:scrollView.contentOffset];
}

@end