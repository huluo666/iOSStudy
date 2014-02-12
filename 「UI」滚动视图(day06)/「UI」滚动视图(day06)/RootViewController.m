//
//  RootViewController.m
//  「UI」滚动视图(day06)
//
//  Created by cuan on 14-2-12.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "RootViewController.h"
#import "SolutionTwoViewController.h"

@interface RootViewController () <UIScrollViewDelegate>

@property (retain, nonatomic) UIScrollView *scrollView;
@property (retain, nonatomic) NSMutableArray *imageNameList;
@property (retain, nonatomic) NSTimer *timer;
@property (retain, nonatomic) UIPageControl *pageControl;

- (void)InitializeUserInterface;
- (void)loadDataSource;
- (void)loadPhotosView;
- (void)autoPlay;
- (void)processTimer:(NSTimer *)timer;
- (void)stopTimer;

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"UIScrollView";
    }
    return self;
}

- (void)dealloc
{
    [_scrollView release];
    [_imageNameList release];
    [_pageControl release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self InitializeUserInterface];
    [self loadDataSource];
    [self loadPhotosView];
}

- (void)InitializeUserInterface
{
    self.view.backgroundColor = [UIColor blackColor];
    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.bounds = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 30);
    _pageControl.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMaxY(self.view.frame) - 100);
    _pageControl.numberOfPages = 8;
    _pageControl.currentPage = 0;
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    [self.view addSubview:_pageControl];
    
    UIBarButtonItem *next = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(nextPage)];
    self.navigationItem.rightBarButtonItem   = next;
    [next release];
}

- (void)nextPage
{
    SolutionTwoViewController *s = [[SolutionTwoViewController alloc] init];
    [self.navigationController pushViewController:s animated:YES];
    [s release];
}

- (void)loadPhotosView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.bounds) * 8,
                                         CGRectGetHeight(_scrollView.bounds));
    // 代理
    _scrollView.delegate = self;
    // 内容偏移位置
    _scrollView.contentOffset = CGPointZero;
    // 位置指示器
    _scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    // 分页
    _scrollView.pagingEnabled = YES;
    // 是否自动添加scrollView内容偏移(inset)
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 是否进行控制器视图的延展(导航栏、工具栏)
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:_scrollView];
    
    for (int i = 0; i < _imageNameList.count; i++) {
        UIImageView *imageView =  [[UIImageView alloc]
                                   initWithFrame:CGRectMake(CGRectGetWidth(_scrollView.bounds) * i,
                                                            0,
                                                            CGRectGetWidth(_scrollView.bounds),
                                                            CGRectGetHeight(_scrollView.bounds))];
        NSString *path = [[NSBundle mainBundle] pathForAuxiliaryExecutable:_imageNameList[i]];
        imageView.image = [UIImage imageWithContentsOfFile:path];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_scrollView addSubview:imageView];
        [imageView release];
    }
    
    // 自动播放
    // 基于延迟操作实现
//    [self performSelector:@selector(autoPlay) withObject:nil afterDelay:1.0f];
    
    // 基于NSTimer实现
//    _timer = [[NSTimer scheduledTimerWithTimeInterval:1.0f
//                                               target:self
//                                             selector:@selector(processTimer:)
//                                             userInfo:@"timer"
//                                              repeats:YES] retain];
}

- (void)loadDataSource
{
    _imageNameList = [[NSMutableArray alloc] init];
    for (int i = 0; i < 8; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%d.png", i + 1];
        [_imageNameList addObject:imageName];
    }
}

- (void)autoPlay
{
    double index = _scrollView.contentOffset.x  + 320;
    
    if (index == 320 * 8) {
        index = 0;
    }
    [_scrollView setContentOffset:CGPointMake(index, 0) animated:YES];
    [self performSelector:_cmd withObject:nil afterDelay:1.0f];
}

- (void)processTimer:(NSTimer *)timer
{
    double index = _scrollView.contentOffset.x  + 320;
    
    if (index == 320 * 8) {
        index = 0;
    }
    [_scrollView setContentOffset:CGPointMake(index, 0) animated:YES];
}

- (void)stopTimer
{
    if (_timer.isValid) {
        [_timer invalidate];
        [_timer release];
    }
}


#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    double index = _scrollView.contentOffset.x / CGRectGetWidth(_scrollView.frame);
    _pageControl.currentPage = index;
}


@end
