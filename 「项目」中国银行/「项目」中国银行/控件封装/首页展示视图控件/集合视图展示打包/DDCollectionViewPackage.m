//
//  DDCollectionViewPackage.m
//  「项目」中国银行
//
//  Created by 萧川 on 3/9/14.
//  Copyright (c) 2014 CUAN. All rights reserved.
//

#import "DDCollectionViewPackage.h"
#import "DDShowDetail.h"
#import "DDAppDelegate.h"

@interface DDCollectionViewPackage () <UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSInteger _currentPageIndex;
}

- (NSInteger)currentPageIndexWithIndex:(NSInteger)index;

@end

@implementation DDCollectionViewPackage

- (void)dealloc
{
    NSLog(@"%@ is dealloced", [self class]);
    [_backgroundImageView release];
    [_collectionView release];
    [_pageControl release];
    [_dataSource release];
    [_identifier release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
    collectionViewLayout:(UICollectionViewLayout *)layout
    reuseIdentifier:(NSString *)identifier
    collectionCellViewType:(DDCollectionCellViewType) collectionCellViewType
    collectionCellViewBounds:(CGRect)collectionCellViewBounds
    dataSource:(NSMutableArray *)dataSource
    refreshButtonImage:(UIImage *)refreshButtonImage
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        CGRect bounds = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));

        // 添加背景图片视图
        _backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
        _backgroundImageView.clipsToBounds = YES;
        _backgroundImageView.userInteractionEnabled = YES;
        [self addSubview:_backgroundImageView];

        // 添加集合视图
        _collectionView = [[UICollectionView alloc] initWithFrame:bounds
                                                              collectionViewLayout:layout];
        _collectionView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds) * 3, 0);
        _collectionView.contentOffset = CGPointMake(CGRectGetWidth(self.bounds), 0);
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[UICollectionViewCell class]
                       forCellWithReuseIdentifier:identifier];
        [_backgroundImageView addSubview:_collectionView];

        // 添加分页控件
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.bounds = CGRectMake(0, 0, bounds.size.width - 20, 30);
        _pageControl.center = CGPointMake(CGRectGetMidX(bounds),
                                         CGRectGetMaxY(bounds) - CGRectGetMaxY(_pageControl.bounds));
//        pageControl.numberOfPages = ceil(_dataSource.count / 4.0);
        _pageControl.numberOfPages = ceil(13 / 4.0);
        _pageControl.currentPage = 0;
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        [_backgroundImageView addSubview:_pageControl];
        
        // 添加右上角button
        UIButton *refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
        refreshButton.bounds = CGRectMake(0, 0, 50, 50);
        refreshButton.center = CGPointMake(CGRectGetWidth(_backgroundImageView.bounds) - CGRectGetMidX(refreshButton.bounds),
                                           CGRectGetMidY(refreshButton.bounds) * 1.2);
        [refreshButton setBackgroundImage:refreshButtonImage forState:UIControlStateNormal];
        [_backgroundImageView addSubview:refreshButton];
   
        // 设置代理和数据源
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        _identifier = [identifier copy];
        _collectionCellViewType = collectionCellViewType;
        _collectionCellViewBounds = collectionCellViewBounds;
        _dataSource = [dataSource retain];

    }
    
    return self;
}

- (NSInteger)currentPageIndexWithIndex:(NSInteger)index
{
    NSInteger maximum = _pageControl.numberOfPages - 1;
    if (index > maximum) {
        index = 0;
    }
    if (index < 0) {
        index = maximum;
    }
    return index;
}


#pragma mark - <UICollectionViewDatasource>

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    // 数据个数小余12的时候补齐12
    return 12;
//    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_identifier
                                                                           forIndexPath:indexPath];
    DDCollectionCellView *cellView = [[DDCollectionCellView alloc] initWithFrame:_collectionCellViewBounds
                                                      projectShowViewType:_collectionCellViewType];
    if (_collectionCellViewType == DDCollectionCellViewSubTitle) {
        cellView.detailTextLabel.text = @"detail text";
    }
    cellView.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
//    cellView.imageView.image = kImageWithName(@"网上银行BOCNET1.png");
    cellView.processTap = ^(UIView *view) {
        if ([view isKindOfClass:[UIButton class]]) {
            // 点击详情按钮回调(热点消息)
            DDShowDetail *detail = [[DDShowDetail alloc] initWithFrame:CGRectZero];
            // 添加到根视图上
            UIView *rootView = kRootView;
            [rootView addSubview:detail];
            [detail release];
        } else {
            // 点击cell回调(产品定制)
        };
    };
    [cell.contentView addSubview:cellView];
    [cellView release];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"section:%ld row:%ld",indexPath.section, indexPath.row);
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"x = %f", _collectionView.contentOffset.x);
    
    // 判断当前contentOffSet，决定如何更新显示
    CGFloat width = CGRectGetWidth(self.bounds);
    
    // 向右移动
    if (2 * width == _collectionView.contentOffset.x) {
        // 更新数据
        for (int i = 0; i < 4; i++) {
            id removeObj = _dataSource[0];
            [_dataSource removeObject:removeObj];
            [_dataSource addObject:removeObj];
        }
        
        // 移动分页控件小圆点
        _pageControl.currentPage = [self currentPageIndexWithIndex:_currentPageIndex + 1];
        _currentPageIndex = _pageControl.currentPage;
        NSLog(@"_currentPageIndex = %ld", _currentPageIndex);
        // 位置还原
        _collectionView.contentOffset = CGPointMake(width, _collectionView.contentOffset.y);
    }
    // 向左移动
    if (0 == _collectionView.contentOffset.x) {
        // 更新数据
        for (int i = 0; i < 4; i++) {
            id removeObj = [_dataSource lastObject];
            [_dataSource removeObject:removeObj];
            [_dataSource insertObject:removeObj atIndex:0];
        }
        
        // 移动分页控件小圆点
        _pageControl.currentPage = [self currentPageIndexWithIndex:_currentPageIndex - 1];
        _currentPageIndex = _pageControl.currentPage;
        NSLog(@"_currentPageIndex = %ld", _currentPageIndex);
        // 位置还原
        _collectionView.contentOffset = CGPointMake(width, _collectionView.contentOffset.y);
    }
    
    // 重载数据
    [_collectionView reloadData];
//    _pageControl.numberOfPages = ceil(_dataSource.count / 4.0);
    _pageControl.numberOfPages = ceil(12 / 4.0);
}

@end