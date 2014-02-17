//
//  PhotosViewController.m
//  UITask
//
//  Created by cuan on 14-2-12.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "PhotosViewController.h"

@interface PhotosViewController () <UIScrollViewDelegate>

@property (retain, nonatomic) UIScrollView *scrollView;
@property (retain, nonatomic) NSMutableArray *imageNameList;
@property (assign, nonatomic) NSInteger currentPageIndex;
@property (retain, nonatomic) NSMutableArray *imageViewList;
@property (retain, nonatomic) UIPageControl *pageControl;
@property (retain, nonatomic) NSTimer *timer;

- (void)loadDataSource;
- (void)loadPhotosView;

// 获取实际的图片索引
- (NSInteger)realIndexWithIndex:(NSInteger)index;

@end

@implementation PhotosViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"相册";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadDataSource];
    [self loadPhotosView];
}

- (void)dealloc
{
    [_scrollView release];
    [_imageNameList release];
    [_imageViewList release];
    [super dealloc];
}

- (void)loadDataSource
{
    _imageNameList = [[NSMutableArray alloc] init];
    for (int i = 0; i < 8; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%d.png", i + 1];
        [_imageNameList addObject:imageName];
    }
}

- (void)loadPhotosView
{
    self.rightView.backgroundColor = [UIColor blackColor];

    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    _scrollView.delegate =self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.frame) * 3, CGRectGetHeight(_scrollView.frame));
    _scrollView.contentOffset = CGPointMake(CGRectGetWidth(_scrollView.frame), 0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    _currentPageIndex = 0;
    
    _imageViewList = [[NSMutableArray alloc] init];
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(_scrollView.frame) * i, 0, CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame))];
        NSInteger index  = [self realIndexWithIndex:_currentPageIndex + i - 1];
        NSString *path = [[NSBundle mainBundle] pathForAuxiliaryExecutable:_imageNameList[index]];
        imageView.image = [UIImage imageWithContentsOfFile:path];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_scrollView addSubview:imageView];
        [_imageViewList addObject:imageView];
        [imageView release];
        
    }
    
    [self.rightView addSubview:_scrollView];
}

- (NSInteger)realIndexWithIndex:(NSInteger)index
{
    NSInteger maximumIndex = [_imageNameList count] - 1;
    // 判断真实索引位置
    if (index > maximumIndex) {
        index = 0;
    } else if (index < 0) {
        index = maximumIndex;
    }
    return index;
}

- (void)updateUserInterfaceWithScrollViewContentOffset:(CGPoint)contentOffset {
    
    BOOL shouldUpdate = NO;
    
    if (contentOffset.x >= CGRectGetWidth(_scrollView.bounds) * 2) {
        shouldUpdate = YES;
        _currentPageIndex = [self realIndexWithIndex:++_currentPageIndex];
    } else if (contentOffset.x <= 0) {
        shouldUpdate = YES;
        _currentPageIndex = [self realIndexWithIndex:--_currentPageIndex];
    }
    
    if (!shouldUpdate) {
        return;
    }
    
    for (int i = 0; i < 3; i++) {
        NSInteger index  = [self realIndexWithIndex:_currentPageIndex + i - 1];
        NSString *path = [[NSBundle mainBundle] pathForAuxiliaryExecutable:_imageNameList[index]];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        ((UIImageView *)_imageViewList[i]).image = image;
    }
    
    _scrollView.contentOffset = CGPointMake(CGRectGetWidth(_scrollView.bounds), 0);
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self updateUserInterfaceWithScrollViewContentOffset:scrollView.contentOffset];
}


@end

