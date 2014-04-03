//
//  DDFlipPageViewController.m
//  「Demo」上下翻页
//
//  Created by 萧川 on 14-4-2.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDFlipPageViewController.h"
#import "DDPageViewController.h"
#import "UIView+FindUIViewController.h"

#define kAnimationDuration 0.3

@interface DDFlipPageViewController ()

@property (nonatomic, assign) CGRect pageViewFrame;
@property (nonatomic, assign) CGRect upPageViewFrame;
@property (nonatomic, strong) NSMutableArray *pageViews;

@property (nonatomic, assign, getter = isProcessing) BOOL processing;
@property (nonatomic, assign) NSInteger currentPageIndex;
@property (nonatomic, assign) NSInteger maxPageIndex;

@property (nonatomic, strong) CAShapeLayer *arcLayer;

@property (nonatomic, assign) NSInteger contentRows;

@property (nonatomic, weak) DDPageViewController *appearedVC;
@property (nonatomic, weak) DDPageViewController *preapedVC;
@property (nonatomic, weak) DDPageViewController *upVC;

// swip gesture action
- (void)swipGestureAction:(UISwipeGestureRecognizer *)swipGestureRecognizer;

// up view appear
- (void)upViewTransformToAppear;

// appeared page view go up
- (void)appearedPageViewTransformToUp;

// upview go to appeaerd view background
- (void)sendUpPageViewToAppearedLocationBack;

// prepared page view to up view location front
- (void)bringPreparedPageViewToUpLocationFront;

// when currentPageIndex = 0 ,slip down refresh
- (void)refresh;
- (void)refreshAnimation;

// calculate content rows
- (NSInteger)contentRows;

// get childs VC dataSource with pageIndex
- (NSMutableArray *)dataSourceWithPageIndex:(NSInteger)pageIndex;


@end

@implementation DDFlipPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        self.view.frame = [[UIScreen mainScreen] bounds];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    // add swip gesture
    UISwipeGestureRecognizer *swipUp = [[UISwipeGestureRecognizer alloc]
                                        initWithTarget:self
                                        action:@selector(swipGestureAction:)];
    swipUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipUp];
    
    UISwipeGestureRecognizer *swipDown = [[UISwipeGestureRecognizer alloc]
                                        initWithTarget:self
                                        action:@selector(swipGestureAction:)];
    swipDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipDown];

    // calculate bounds and centers
//    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect screenBounds = self.view.bounds;
    _pageViewFrame = screenBounds;
    _upPageViewFrame = CGRectMake(0, -CGRectGetHeight(screenBounds), CGRectGetWidth(screenBounds), CGRectGetHeight(screenBounds));

    // init porperty
    _pageViews = [[NSMutableArray alloc] init];
    
    // gengrate page view
    for (int i = 0; i < 2; i++) {
        DDPageViewController *pageVC = [[DDPageViewController alloc] init];
        pageVC.view.frame = self.view.bounds;
        [self addChildViewController:pageVC];
        [self.view addSubview:pageVC.view];
        
        [_pageViews addObject:pageVC.view];
        pageVC.view.tag = 11 + i;
    }

    DDPageViewController *upPageVC = [[DDPageViewController alloc] init];
    upPageVC.view.frame = self.view.bounds;
    [self addChildViewController:upPageVC];
    [self.view addSubview:upPageVC.view];
    [_pageViews addObject:upPageVC.view];
    upPageVC.view.tag = 13;
}

- (void)setDataSource:(NSMutableArray *)dataSource {
    if (dataSource != _dataSource) {
        _dataSource = dataSource;
    }

    NSInteger count = (double)[self contentRows];
    double divide = ceil((double)_dataSource.count / count);
    self.maxPageIndex =  (NSInteger)divide;

    NSArray *childVCs = self.childViewControllers;
    self.preapedVC = (DDPageViewController *)childVCs[0];
    self.appearedVC = (DDPageViewController *)childVCs[1];
    self.upVC = (DDPageViewController *)childVCs[2];
    self.currentPageIndex = 1;
    self.appearedVC.dataSource = [self dataSourceWithPageIndex:_currentPageIndex];
    self.preapedVC.dataSource = [self dataSourceWithPageIndex:_currentPageIndex + 1];
}

#pragma mark - swip gesture handler

- (void)swipGestureAction:(UISwipeGestureRecognizer *)swipGestureRecognizer {
    
    NSLog(@"%@", NSStringFromSelector(_cmd));

    if (swipGestureRecognizer.direction == UISwipeGestureRecognizerDirectionUp) {
        // swip up
        if (_currentPageIndex < _maxPageIndex) {
            [self sendUpPageViewToAppearedLocationBack];
            [self appearedPageViewTransformToUp];            
        }
    } else {
        // swip down
        if (self.currentPageIndex > 1) {
            [self bringPreparedPageViewToUpLocationFront];
            [self upViewTransformToAppear];
        } else {
            [self refresh];
        }
    }
}

#pragma mark - transform anctions

- (void)sendUpPageViewToAppearedLocationBack {
    
    if (self.isProcessing) {
        return;
    }
    self.processing = YES;
    
    UIView *upPageView = _pageViews[2];
    
    if (upPageView.frame.origin.y == _pageViewFrame.origin.y) {
        upPageView.frame = _pageViewFrame;
        [self.view sendSubviewToBack:upPageView];
        
        NSLog(@"<\n%@\n:%@>", NSStringFromSelector(_cmd), self.view.subviews);
        _currentPageIndex++;
        
        // reload data
        DDPageViewController *preparedVC = (DDPageViewController *)[upPageView viewController];
        NSMutableArray *dataSource = [self dataSourceWithPageIndex:_currentPageIndex + 1];
        if (dataSource) {
            preparedVC.dataSource = dataSource;
            [preparedVC.tableView reloadData];
        }
        NSLog(@"_maxPageIndex = %d", _maxPageIndex);
        NSLog(@"_currentPageIndex = %d", _currentPageIndex);
    }
    
    self.processing = NO;
}

- (void)appearedPageViewTransformToUp {
    
    if (self.isProcessing) {
        return;
    }
    self.processing = YES;
    
    UIView *appearedPageView = _pageViews[1];
    [UIView animateWithDuration:kAnimationDuration animations:^{
        appearedPageView.frame = _upPageViewFrame;
    } completion:^(BOOL finished) {
        // adjust order
        UIView *needAdjustView = [_pageViews lastObject];
        [_pageViews removeObject:needAdjustView];
        [_pageViews insertObject:needAdjustView atIndex:0];
        
        self.processing = NO;
    }];
}

- (void)bringPreparedPageViewToUpLocationFront {
    
    if (self.isProcessing) {
        return;
    }
    self.processing = YES;
    
    UIView *prepatedPageView =  _pageViews[0];
    
    if (prepatedPageView.frame.origin.y != _upPageViewFrame.origin.y) {
        prepatedPageView.frame = _upPageViewFrame;
        [self.view bringSubviewToFront:prepatedPageView];
        
        _currentPageIndex--;
        
        // reload data
        DDPageViewController *upPageVC = (DDPageViewController *)[prepatedPageView viewController];
        NSInteger index = _currentPageIndex - 1 > 0 ? _currentPageIndex - 1 : 1;
        upPageVC.dataSource = [self dataSourceWithPageIndex:index];
        [upPageVC.tableView reloadData];
    }
    self.processing = NO;
}

- (void)upViewTransformToAppear {
    
    if (self.isProcessing) {
        return;
    }
    self.processing = YES;
    
    UIView *upPageView = _pageViews[2];
    [UIView animateWithDuration:kAnimationDuration animations:^{
        upPageView.frame = _pageViewFrame;
    } completion:^(BOOL finished) {
        // adjust order
        UIView *needAdjustView = [_pageViews firstObject];
        [_pageViews removeObject:needAdjustView];
        [_pageViews addObject:needAdjustView];
        
        self.processing = NO;
    }];
}

#pragma mark - refresh, animation

- (void)refresh {

    self.processing = YES;
    UIView *appearedView = _pageViews[1];
    [UIView animateWithDuration:kAnimationDuration animations:^{
        appearedView.transform = CGAffineTransformScale(appearedView.transform, 0.5, 0.5);
    } completion:^(BOOL finished) {
        appearedView.transform = CGAffineTransformIdentity;
        
        // reload data, play animation
        [self refreshAnimation];
        
        [self performSelector:@selector(stopAni) withObject:nil afterDelay:2];
    }];
}

- (void)stopAni {
    
    [self.arcLayer removeAllAnimations];
    [[self.view.subviews lastObject] removeFromSuperview];
    self.processing = NO;
}

- (void)refreshAnimation {

    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    UIView *loadingBackgroundView = [[UIView alloc] initWithFrame:screenBounds];
    loadingBackgroundView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:loadingBackgroundView];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGRect rect = [UIScreen mainScreen].applicationFrame;
    [path addArcWithCenter:CGPointMake(rect.size.width / 2,
                                       rect.size.height / 2)
                    radius:100
                startAngle:0
                  endAngle:2 * M_PI
                 clockwise:NO];
    self.arcLayer = [CAShapeLayer layer];
    self.arcLayer.path = path.CGPath;
    self.arcLayer.fillColor = [UIColor lightGrayColor].CGColor;
    self.arcLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.arcLayer.lineWidth = 5;
    self.arcLayer.frame = loadingBackgroundView.frame;
    [loadingBackgroundView.layer addSublayer:self.arcLayer];
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 1.5;
    animation.repeatCount = ARG_MAX;
    animation.fromValue = [NSNumber numberWithInteger:0];
    animation.toValue = [NSNumber numberWithInteger:1];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = YES;
    [self.arcLayer addAnimation:animation forKey:@"animation"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"Loading...";
    label.font = [UIFont italicSystemFontOfSize:24];
    label.textColor = [UIColor whiteColor];
    [loadingBackgroundView addSubview:label];
}

- (NSInteger)contentRows {
    
    NSInteger count = 0;
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat height = CGRectGetHeight(screenBounds);
    if (480 == height) {
        count = 5;
    } else if (568 == height) {
        count = 6;
    } else if (1024 == height) {
        count = 12;
    }
    
    return count;
}

- (NSMutableArray *)dataSourceWithPageIndex:(NSInteger)pageIndex {

    NSMutableArray *dataSource = [[NSMutableArray alloc] init];
    NSMutableArray *selfDataSource = self.dataSource;
    
    NSInteger dataSourceCount = selfDataSource.count;
    NSInteger contentRowsCount = self.contentRows * pageIndex;
    NSInteger end = dataSourceCount < contentRowsCount ? dataSourceCount : contentRowsCount;
    NSInteger start = self.contentRows * (pageIndex - 1);
    
    if (start > end) {
        return nil;
    }
    
    for (NSInteger i = start; i < end; i++) {
        [dataSource addObject:selfDataSource[i]];
    }
    
    return dataSource;
}

@end
