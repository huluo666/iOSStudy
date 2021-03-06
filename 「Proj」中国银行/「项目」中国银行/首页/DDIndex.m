//
//  DDIndex.m
//  「项目」中国银行
//
//  Created by 萧川 on 3/7/14.
//  Copyright (c) 2014 CUAN. All rights reserved.
//

#import "DDIndex.h"
#import "DDCollectionViewPackage.h"
#import "UIImageView+WebCache.h"
#import "DDConstant.h"
#import "DDShowDetail.h"
#import "DDAppDelegate.h"
#import "DDBuyView.h"

@interface DDIndex () <
    UITableViewDataSource,
    UITableViewDelegate>
{
    NSMutableDictionary *_dataSource;  // 数据源，存储网络获取的数据
    UIImageView *_downImageView;       // 下面的图片展示视图
    UIImageView *_upImageView;         // 上面的图片展示视图
    NSInteger _currentShowImageIndex;  // 记录上面当前显示的是第几张图片
    
    UITableView *_tableView;           // 右侧新闻
    DDCollectionViewPackage *_hotNewsviewPackage; // 最热消息视图打包
    DDCollectionViewPackage *_customProductPackage; // 产品自定义
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

#pragma mark - URL不能直接存在数组中
- (NSURL *)urlWithString:(NSString *)urlString;

@end

@implementation DDIndex

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {        
        _dataSource = [[NSMutableDictionary alloc] init];
        
        UIImageView *imageView = [[UIImageView alloc]
                                  initWithImage:kImageWithNameHaveSuffix(@"index_background.png")];
        imageView.frame = kMainViewBounds;
        [self addSubview:imageView];
        [imageView release];
        
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
    NSLog(@"%@ is dealloced", [self class]);
    [_dataSource release];
    [_downImageView release];
    [_upImageView release];
    [_imageSwitchIntervalTimer release];
    [_updateImagesIntervalTimer release];
    [_tableView release];
    [_hotNewsviewPackage release];
    [_customProductPackage release];
    [super dealloc];
}

- (void)sendHttpRequest
{
    [self requestForImages];
    
    // 每隔10分钟更新图片数据
    NSMethodSignature *signature = [DDIndex instanceMethodSignatureForSelector:
                                    @selector(requestForImages)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    [invocation setSelector:@selector(requestForImages)];
    [invocation retainArguments];
    _updateImagesIntervalTimer = [[NSTimer timerWithTimeInterval:kDataUpdateTimeInterval
                                                     invocation:invocation
                                                        repeats:YES] retain];
    
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:_updateImagesIntervalTimer forMode:NSDefaultRunLoopMode];
    
//    _updateImagesIntervalTimer = [[NSTimer scheduledTimerWithTimeInterval:kDataUpdateTimeInterval
//                                                              invocation:invocation
//                                                                 repeats:YES] retain];
    
    [self requestForLatestNews];
    [self requestForHotNews];
    [self requestForProjectCustom];
}

#pragma mark - 相册实现相关方法

- (void)requestForImages
{
    // 请求网络获取图片
    [DDHTTPManager sendRequstWithImagesTotalNumber:@"5"
                                 completionHandler:^(id content, NSString *resultCode) {
         if ([content isKindOfClass:[NSArray class]]) {
             NSArray *imageUrlString = [content valueForKey:kPhotoRULKey];
             if (!imageUrlString.count) {
                 return;
             }
             
             // 保存图片路径,拼接路径
             NSMutableArray *array = [[NSMutableArray alloc] init];
             for (int i = 0; i < imageUrlString.count; i++) {
                 NSString *urlString = [NSString stringWithFormat:
                                        @"http://192.168.10.201:8080%@",
                                        imageUrlString[i]];
                 [array addObject:urlString];
             }
             
             [_dataSource setObject:array forKey:kLoopImagesURLKey];
             [array release];
         }
    }];
}

- (void)initializePlayImagesRunLoopView
{
    CGRect frame = CGRectMake(10, 15, 600, 320);
    
    // 下面的图片展示视图
    _downImageView = [[UIImageView alloc] initWithFrame:frame];

    _downImageView.contentMode = UIViewContentModeScaleToFill;
    _downImageView.layer.cornerRadius = 1280;
    [self addSubview:_downImageView];
    
    // 上面的图片展示视图
    _upImageView = [[UIImageView alloc] initWithFrame:frame];
    _upImageView.contentMode = UIViewContentModeScaleToFill;
    _upImageView.layer.cornerRadius = 1280;
    [self addSubview:_upImageView];

    // 开启计时器
    NSMethodSignature *signature = [DDIndex instanceMethodSignatureForSelector:
                                    @selector(startRunLoop)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    [invocation setSelector:@selector(startRunLoop)];
    _imageSwitchIntervalTimer = [[NSTimer timerWithTimeInterval:6.0f
                                                    invocation:invocation
                                                       repeats:YES] retain];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:_imageSwitchIntervalTimer forMode:NSDefaultRunLoopMode];
    
//    [self simulateBusy];
}

// 模拟当前线程正好繁忙的情况
- (void)simulateBusy
{
    NSLog(@"start simulate busy!");
    NSInteger caculateCount = NSIntegerMax;
    CGFloat uselessValue = 0;
    for (NSUInteger i = 0; i < caculateCount; ++i) {
        uselessValue = i / 0.3333;
    }
    NSLog(@"finish simulate busy!");
}


- (NSURL *)urlWithString:(NSString *)urlString
{
    return [NSURL URLWithString:urlString];
}

- (void)startRunLoop
{
    // 获取所有图片路径
    NSMutableArray *imagesURLString = [[[NSMutableArray alloc]
                                        initWithArray:_dataSource[kLoopImagesURLKey]]
                                       autorelease];
    
    if (!imagesURLString.count) {
        return;
    }

    // 设置显示图片
    [_upImageView setImageWithURL:[self urlWithString:imagesURLString[_currentShowImageIndex]]];
    __block NSInteger downImageIndex = [self realImageIndexWithIndex:_currentShowImageIndex + 1];
    [_downImageView setImageWithURL:[self urlWithString:imagesURLString[downImageIndex]]];
    
    // 上面的视图向左移除并渐变
    CGPoint center = _upImageView.center;
    [UIView animateWithDuration:kAnimateDuration * 2
                     animations:^{
         _upImageView.alpha = 0.85f;
         _upImageView.center = CGPointMake(center.x - CGRectGetWidth(_downImageView.bounds),
                                           center.y);
     }
                     completion:^(BOOL finished) {
         _upImageView.alpha = 1.0f;
         _upImageView.center = center;
         
         // 更新显示图片
         [_upImageView setImageWithURL:[self urlWithString:imagesURLString[downImageIndex]]];
         _currentShowImageIndex = downImageIndex;
         NSString *willRemoveImageURL = [imagesURLString firstObject];
         [imagesURLString removeObject:willRemoveImageURL];
         [imagesURLString addObject:willRemoveImageURL];
         downImageIndex = [self realImageIndexWithIndex:_currentShowImageIndex + 1];
         [_downImageView setImageWithURL:[self urlWithString:imagesURLString[downImageIndex]]];
     
                         // 循环调用
#pragma mark - NOTE
/*
 * 这里block里面调用了方法自己，照成循环引用
 * 内存无法释放，改进方式为是使用定时器
 */
//                         [self performSelector:@selector(startRunLoop)
//                                    withObject:nil
//                                    afterDelay:kAnimateDuration * 2];
    }];
}

- (NSInteger)realImageIndexWithIndex:(NSInteger)index
{
    NSArray *images = [_dataSource objectForKey:kLoopImagesURLKey];
    if (index == images.count) {
        index = 0;
    }
    return index;
}

#pragma mark - 最新动态实现相关方法

- (void)requestForLatestNews
{
    [DDHTTPManager sendRequstWithPageNumber:@"1"
                                   pageSize:@"20"
                          completionHandler:^(id content, NSString *resultCode) {
          if (0 != [resultCode intValue]) {
              return;
          }
          
          if ([content isKindOfClass:[NSArray class]]) {
              // 存标题
              NSArray *contents = [content valueForKey:kNewsTitleKey];
              if (!contents.count) {
                  return;
              }
              [_dataSource setObject:contents forKey:kLatestNewsKey];
              
              // 存内容
              NSArray *news = [content valueForKey:kNewsDetailKey];
              
              if (!news.count) {
                  return;
              }
              [_dataSource setObject:news forKey:kNewsDetailContentKey];
          }
          
          // 刷新数据
          [_tableView reloadData];
    }];
}

- (void)initializeLatestNewsView
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:
                              kImageWithName(@"最新动态-底_09")];
    imageView.bounds = CGRectMake(0, 0, 280, 320);
    imageView.center = CGPointMake(CGRectGetMaxX(self.bounds) -
                                   CGRectGetMidX(imageView.bounds) - 20,
                                   CGRectGetMidY(_downImageView.frame));
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.userInteractionEnabled = YES;
    [self addSubview:imageView];
    [imageView release];
    
    _tableView = [[UITableView alloc] init];
    _tableView.frame = CGRectMake(10, 10, 260, 300);
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [imageView addSubview:_tableView];

    // 右上角button
    UIButton *refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    refreshButton.bounds = CGRectMake(0, 0, 50, 50);
    refreshButton.center = CGPointMake(CGRectGetWidth(imageView.bounds) -
                                       CGRectGetMidX(refreshButton.bounds),
                                       CGRectGetMidY(refreshButton.bounds));
    [refreshButton setBackgroundImage:kImageWithName(@"最新动态_38")
                             forState:UIControlStateNormal];
    [imageView addSubview:refreshButton];
}

#pragma mark - 热门信息实现相关方法

- (void)requestForHotNews
{
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:kUserInfoId];
    if (![obj isKindOfClass:[NSNumber class]]) {
        return;
    }
    [DDHTTPManager sendRequstWithUserId:[[NSUserDefaults standardUserDefaults] objectForKey:kUserInfoId]
                            totalNumber:@"12"
                      completionHandler:^(id content, NSString *resultCode) {
          if (0 != [resultCode intValue]) {
              return;
          }
          if ([content isKindOfClass:[NSArray class]]) {
              if (0 == [content count]) {
                  return;
              }
              [_dataSource setObject:content forKey:kHotNewsKey];
              // 设置数据源
              _hotNewsviewPackage.dataSource = content;
              // 刷新打包视图界面数据
              [_hotNewsviewPackage.collectionView reloadData];
              _hotNewsviewPackage.pageControl.numberOfPages = ceil([content count] / 4.0);
          }
    }];
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
    
    UIImage *refreshButtonImage = kImageWithNameHaveSuffix(@"hot_36.png");
    _hotNewsviewPackage = [[DDCollectionViewPackage alloc] initWithFrame:frame
                                                    collectionViewLayout:layout
                                                         reuseIdentifier:@"HotNewsViewCellIdenitfier"
                                                  collectionCellViewType:DDCollectionCellViewSubTitle
                                                collectionCellViewBounds:kHotNewsShowComponentBounds
                                                      refreshButtonImage:refreshButtonImage];
    [layout release];
    _hotNewsviewPackage.backgroundImageView.image = kImageWithNameHaveSuffix(@"最热-底_12.png");
    _hotNewsviewPackage.collectionView.tag = kHotCollectionViewTag;
    [self addSubview:_hotNewsviewPackage];
}

#pragma mark - 产品定制实现相关方法

- (void)requestForProjectCustom
{
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:kUserInfoId];
    if (![obj isKindOfClass:[NSNumber class]]) {
        return;
    }
    [DDHTTPManager sendRequestForCustomProjectWithUserId:[[NSUserDefaults standardUserDefaults] objectForKey:kUserInfoId]
                                             totalNumber:@"12"
                                       completionHandler:^(id content, NSString *resultCode) {
        if (0 != [resultCode intValue]) {
           return;
        }
        if ([content isKindOfClass:[NSArray class]]) {
           if (0 == [content count]) {
               return;
           }
           [_dataSource setObject:content forKey:kCustomKey];
           // 设置数据源
           _customProductPackage.dataSource = content;
           _customProductPackage.pageControl.numberOfPages = ceil([content count] / 4.0);
           [_customProductPackage.collectionView reloadData];
        }
    }];
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
    CGRect frame = CGRectMake(CGRectGetMaxX(_downImageView.frame) + 35,
                              CGRectGetMaxY(_downImageView.frame),
                              280,
                              300);
    UIImage *refreshButtonImage = kImageWithNameHaveSuffix(@"产品定制_39.png");
    _customProductPackage =
        [[DDCollectionViewPackage alloc] initWithFrame:frame
                                  collectionViewLayout:layout
                                       reuseIdentifier:@"customProjectViewCellIdenitfier"
                                collectionCellViewType:DDCollectionCellViewDefault
                              collectionCellViewBounds:kCustomProjectComponentBounds
                                    refreshButtonImage:refreshButtonImage];
    [layout release];
    _customProductPackage.backgroundImageView.image = kImageWithNameHaveSuffix(@"产品定制-底_14.png");
    _customProductPackage.collectionView.tag = kCustomProjectCollectionViewTag;
    [self addSubview:_customProductPackage];
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
    // 后台坑爹，数据不需要请求了
    NSLog(@"%@", _dataSource[kNewsDetailContentKey][indexPath.row]);
    
    // title
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *title = cell.textLabel.text;
    
    DDShowDetail *detail = [[DDShowDetail alloc] initWithFrame:CGRectZero];
    detail.buyButtonHidden = YES;
    detail.titleLabel.text = title;

    // content
    CGRect labelFrame = CGRectMake(20,
                                   20,
                                   CGRectGetWidth(detail.contentView.bounds) - 40,
                                   CGRectGetHeight(detail.contentView.bounds) - 40);
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:labelFrame];
    NSString *labelText = _dataSource[kNewsDetailContentKey][indexPath.row];
    [contentLabel setText:labelText];
    [contentLabel setNumberOfLines:0];
    [contentLabel sizeToFit];
    [detail.contentView addSubview:contentLabel];
    [contentLabel release];
    
    [kRootView addSubview:detail];
    [detail release];
}

@end