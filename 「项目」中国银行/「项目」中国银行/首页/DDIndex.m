//
//  DDIndex.m
//  「项目」中国银行
//
//  Created by 萧川 on 3/7/14.
//  Copyright (c) 2014 CUAN. All rights reserved.
//



#import "DDIndex.h"
#import "DDCollectionViewPackage.h"

@interface DDIndex () <
    UITableViewDataSource,
    UITableViewDelegate>
{
    NSMutableDictionary *_dataSource;  // 数据源，存储网络获取的数据
    UIImageView *_downImageView;       // 下面的图片展示视图
    UIImageView *_upImageView;         // 上面的图片展示视图
    NSInteger _currentShowImageIndex;  // 记录上面当前显示的是第几张图片
}

// 发起http请求
- (void)sendHttpRequest;
// 网络请求图片
- (void)requestForImages;
// 初始化循环播放图片视图
- (void)initializePlayImagesRunLoopView;
// 开始图片循环播放
- (void)startRunLoop;
// 获取真实的应该显示的图片的索引
- (NSInteger)realImageIndexWithIndex:(NSInteger)index;

// 初始化右侧最新动态展示视图
- (void)initializeLatestNewsView;
// 网络请求最新动态数据
- (void)requestForLatestNews;

// 热门信息展示
- (void)initializeHotNewsView;
// 网络请求热门信息数据
- (void)requestForHotNews;

// 产品定制展示
- (void)initializeProjectCustomView;
// 网络请求产品定制数据
- (void)requestForProjectCustom;

@end

@implementation DDIndex

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {        
        _dataSource = [[NSMutableDictionary alloc] init];
        
        // 发起请求
        [self sendHttpRequest];
        
        // 左上角展示图册
        [self initializePlayImagesRunLoopView];
        
        // 右上角最新动态
        [self initializeLatestNewsView];
        
        // 左下角热门信息展示
        [self initializeHotNewsView];
        
        // 右下角产品定制信息展示
        [self initializeProjectCustomView];
    }
    return self;
}

- (void)dealloc
{
    [_dataSource release];
    [_downImageView release];
    [_upImageView release];
    [super dealloc];
}

- (void)sendHttpRequest
{
    [self requestForImages];
    [self requestForLatestNews];
    [self requestForHotNews];
    [self requestForProjectCustom];
}

#pragma mark - 相册实现相关方法

- (void)requestForImages
{
    // 请求网络获取图片
#pragma mark - TODO net request

    // 将获取到的图片存入数据源字典中
    UIImage *image1 = [UIImage imageNamed:@"view_05"];
    UIImage *image2 = [UIImage imageNamed:@"中银保险"];
    NSArray *loopImages = @[image1, image2];
    [_dataSource setObject:loopImages forKey:kLoopImagesKey];
    
    // 每隔10分钟更新数据
    [self performSelector:@selector(requestForImages)
               withObject:nil
               afterDelay:kDataUpdateTimeInterval];
}

- (void)initializePlayImagesRunLoopView
{
    CGRect frame = CGRectMake(10, 15, 600, 320);
    
    // 下面的图片展示视图
    _downImageView = [[UIImageView alloc] initWithFrame:frame];
    _downImageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:_downImageView];
    
    // 上面的图片展示视图
    _upImageView = [[UIImageView alloc] initWithFrame:frame];
    _upImageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:_upImageView];

    [self startRunLoop];
}

- (void)startRunLoop
{
    // 获取所有图片
    NSMutableArray *images = [[_dataSource[kLoopImagesKey] mutableCopy] autorelease];
    // 设置显示图片
    _upImageView.image = images[_currentShowImageIndex];
    __block NSInteger downImageIndex = [self realImageIndexWithIndex:_currentShowImageIndex + 1];
    _downImageView.image = images[downImageIndex];
    
    // 上面的视图向左移除并渐变
    CGPoint center = _upImageView.center;
    [UIView animateWithDuration:kAnimateDuration
                     animations:^{
                         _upImageView.alpha = 0.85f;
                         _upImageView.center = CGPointMake(center.x - CGRectGetWidth(_downImageView.bounds),
                                                           center.y);
                     }
                     completion:^(BOOL finished) {
                         _upImageView.alpha = 1.0f;
                         _upImageView.center = center;
                         
                         // 更新显示图片
                         _upImageView.image = images[downImageIndex];
                         _currentShowImageIndex = downImageIndex;
                         UIImage *willRemoveImage = [images firstObject];
                         [images removeObject:willRemoveImage];
                         [images addObject:willRemoveImage];
                         downImageIndex = [self realImageIndexWithIndex:_currentShowImageIndex + 1];
                         _downImageView.image = images[downImageIndex];
                         
                         // 循环调用
                         [self performSelector:@selector(startRunLoop)
                                    withObject:nil
                                    afterDelay:kAnimateDuration * 2];
                     }];
}

- (NSInteger)realImageIndexWithIndex:(NSInteger)index
{
    NSArray *images = [_dataSource objectForKey:kLoopImagesKey];
    if (index == images.count) {
        index = 0;
    }
    return index;
}

#pragma mark - 最新动态实现相关方法

- (void)requestForLatestNews
{
#pragma mark - TODO 请求最新动态
    NSArray *latestNews = @[@"业内人士：航班失联超8小时 失事可能性很大", @"437名女市长和副市长盘点:处级到厅级平均4.8年",
                            @"东莞市长：东莞从来没有靠黄赌毒发展经济", @"代表委员建议降低个税税率 提高起征点到六七千元",
                            @"马来西亚航班失联 广东海事直升机待命", @"官方启动一级应急响应 成立马航失联应急小组"];
    [_dataSource setObject:latestNews forKey:kLatestNewsKey];
}

- (void)initializeLatestNewsView
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"最新动态-底_09"]];
    imageView.bounds = CGRectMake(0, 0, 280, 320);
    imageView.center = CGPointMake(CGRectGetMaxX(self.bounds) - CGRectGetMidX(imageView.bounds) - 20,
                         CGRectGetMidY(_downImageView.frame));
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.userInteractionEnabled = YES;
    [self addSubview:imageView];
    [imageView release];
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(10, 10, 260, 300);
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    [imageView addSubview:tableView];
    [tableView release];
}

#pragma mark - 热门信息实现相关方法

- (void)requestForHotNews
{
#pragma mark - TODO 请求数据并在数据源代理方法中加载上界面
}

- (void)initializeHotNewsView
{
    // 集合视图
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [layout setItemSize:CGSizeMake(kHotNewsShowComponentBounds.size.width,
                                   kHotNewsShowComponentBounds.size.height)];
    [layout setSectionInset:UIEdgeInsetsMake(20, 30, 60, 30)];
    [layout setMinimumInteritemSpacing:20];
    [layout setMinimumLineSpacing:60];
    CGRect frame = CGRectMake(CGRectGetMinX(_downImageView.frame),
                              CGRectGetMaxY(_downImageView.frame),
                              600,
                              300);
    
    DDCollectionViewPackage *viewPackage =
        [[DDCollectionViewPackage alloc] initWithFrame:frame
                                  collectionViewLayout:layout
                                       reuseIdentifier:@"HotNewsViewCellIdenitfier"
                                collectionCellViewType:DDCollectionCellViewSubTitle
                              collectionCellViewBounds:kHotNewsShowComponentBounds
                                                  dataSource:nil];
    [layout release];
    viewPackage.backgroundImageView.image = [UIImage imageNamed:@"最热-底_12"];
    viewPackage.collectionView.tag = kHotCollectionViewTag;
    [self addSubview:viewPackage];
    [viewPackage release];
}

#pragma mark - 产品定制实现相关方法

- (void)requestForProjectCustom
{
#pragma mark - TODO 请求产品定制数据并添加到数据源中
}

- (void)initializeProjectCustomView
{
    // 集合视图
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [layout setItemSize:CGSizeMake(kCustomProjectComponentBounds.size.width,
                                   kCustomProjectComponentBounds.size.height)];
    [layout setSectionInset:UIEdgeInsetsMake(20, 10, 60, 10)];
    [layout setMinimumLineSpacing:20];
    CGRect frame = CGRectMake(CGRectGetMaxX(_downImageView.frame) + 25,
                              CGRectGetMaxY(_downImageView.frame),
                              280,
                              300);
    DDCollectionViewPackage *viewPackage =
        [[DDCollectionViewPackage alloc] initWithFrame:frame
                                  collectionViewLayout:layout
                                       reuseIdentifier:@"customProjectViewCellIdenitfier"
                                collectionCellViewType:DDCollectionCellViewDefault
                              collectionCellViewBounds:kCustomProjectComponentBounds
                                                  dataSource:nil];
    [layout release];
    viewPackage.backgroundImageView.image = [UIImage imageNamed:@"产品定制-底_14"];
    viewPackage.collectionView.tag = kCustomProjectCollectionViewTag;
    [self addSubview:viewPackage];
    [viewPackage release];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource[kLatestNewsKey] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:cellIdentifier] autorelease];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
        cell.textLabel.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = _dataSource[kLatestNewsKey][indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath");
#pragma mark - TODO 弹出动画
}

@end