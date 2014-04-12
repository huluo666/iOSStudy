//
//  DDIndex.m
//  「项目」中国银行
//
//  Created by 萧川 on 3/7/14.
//  Copyright (c) 2014 CUAN. All rights reserved.
//

#pragma mark - 显示视图封装

typedef enum {
    DDProjectShowViewTypeDefault  = 0 << 1,
    DDProjectShowViewTypeSubTitle = 1 << 1
} DDProjectShowViewType;


@interface DDProjectShowView : UIView

@property (retain, nonatomic, readonly) UIImageView *imageView;       // 热门产怕图片视图
@property (retain, nonatomic, readonly) UILabel     *textLabel;       // 热门产品介绍信息
@property (retain, nonatomic, readonly) UILabel     *detailTextLabel; // 热门产品详细信息介绍
@property (retain, nonatomic, readonly) UIButton    *button;          // 点击按钮
@property (copy, nonatomic) void(^processTap)(UIView *view);

- (instancetype)initWithFrame:(CGRect)frame projectShowViewType:(DDProjectShowViewType)type;

@end

@implementation DDProjectShowView

- (instancetype)initWithFrame:(CGRect)frame projectShowViewType:(DDProjectShowViewType)type
{
    if (self = [super initWithFrame:frame]) {
        CGRect bounds = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
        
        // 背景图片效果
        UIImage *backgroundImage = [UIImage imageNamed:@"底_14"];
        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
        backgroundView.userInteractionEnabled = YES;
        backgroundView.frame = frame;
        [self addSubview:backgroundView];
        [backgroundView release];
        
        if (DDProjectShowViewTypeDefault == type) {
            // 默认布局
            // 图片
            CGRect imageViewFrame = CGRectMake(0,
                                               0,
                                               bounds.size.width,
                                               bounds.size.height * 0.8);
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            _imageView = [imageView retain];
            [imageView release];
            [self addSubview:_imageView];
            
            // 显示文本
            CGRect textLabelFrame = CGRectMake(0,
                                               bounds.size.height * 0.8,
                                               bounds.size.width,
                                               bounds.size.height * 0.2);
            UILabel *textLabel = [[UILabel alloc] initWithFrame:textLabelFrame];
            textLabel.textAlignment = NSTextAlignmentCenter;
            _textLabel = [textLabel retain];
            [textLabel release];
            [self addSubview:_textLabel];
            
            // 添加单击手势
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
                                                  initWithTarget:self
                                                  action:@selector(processTap:)];
            [self addGestureRecognizer:tapGesture];
            [tapGesture release];
            
        } else {
            // 详细信息布局
            // 图片
            CGRect imageViewBounds = CGRectMake(0,
                                                0,
                                                bounds.size.width / 3,
                                                bounds.size.height * 0.9);
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.bounds = imageViewBounds;
            imageView.center = CGPointMake(CGRectGetMidX(imageViewBounds) + 5,
                                           bounds.size.height / 2);
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.userInteractionEnabled = YES;
            _imageView = [imageView retain];
            [imageView release];
            [self addSubview:_imageView];
            
            // 显示信息文本
            CGRect textLabelBounds = CGRectMake(0,
                                                0,
                                                bounds.size.width / 3 * 2 - 15,
                                                bounds.size.height / 3);
            UILabel *textLabel = [[UILabel alloc] init];
            textLabel.bounds = textLabelBounds;
            textLabel.center = CGPointMake(CGRectGetMidX(textLabel.bounds) + CGRectGetWidth(imageViewBounds) + 10,
                                           CGRectGetMidY(textLabel.bounds));
            _textLabel = [textLabel retain];
            [textLabel release];
            [self addSubview:_textLabel];
            
            // 显示详细信息文本
            UILabel *detailTextLabel = [[UILabel alloc] init];
            detailTextLabel.bounds = textLabelBounds;
            detailTextLabel.center = CGPointMake(textLabel.center.x,
                                                 textLabel.center.y + CGRectGetHeight(textLabel.bounds));
            _detailTextLabel = [detailTextLabel retain];
            [detailTextLabel release];
            [self addSubview:_detailTextLabel];
            
            // 详情button
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            button.bounds = CGRectMake(0, 0, 60, 30);
            button.center = CGPointMake(CGRectGetWidth(bounds) / 6 * 5,
                                        CGRectGetMaxY(bounds) - CGRectGetMidY(button.bounds) - 5);
            [button setBackgroundImage:[UIImage imageNamed:@"详情_01"] forState:UIControlStateNormal];
            [button addTarget:self
                       action:@selector(processTap:)
             forControlEvents:UIControlEventTouchUpInside];
            _button = [button retain];
            [self addSubview:_button];
        }
    }
    return self;
}

- (void)dealloc
{
    [_imageView release];
    [_textLabel release];
    [_detailTextLabel release];
    [_button release];
    [_processTap release];
    [super dealloc];
}

- (void)processTap:(UIView *)view
{
    NSLog(@"点击回调方法");
    if (_processTap) {
        _processTap(view);
    }
}

@end

#pragma mark - 集合视图视图封装

@interface DDCollectionViewPackage : UIView

@property (nonatomic, retain) UIView<UICollectionViewDelegate, UICollectionViewDataSource> *view; // 父控件
@property (nonatomic, retain, readonly) UIImageView *backgroundImageView;   // 背景图片
@property (nonatomic, retain, readonly) UICollectionView *collectionView;   // 集合视图
@property (nonatomic, retain, readonly) UICollectionViewFlowLayout *layout; // cell布局
@property (nonatomic, retain, readonly) UIPageControl *pageControl;         // 分页控件

+ (instancetype)collectionViewPackageWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout;

@end

@implementation DDCollectionViewPackage

- (void)dealloc
{

    [_view release];
    [_backgroundImageView release];
    [_collectionView release];
    [_layout release];
    [_pageControl release];
    [super dealloc];
}

+ (instancetype)collectionViewPackageWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    return [[[self alloc] initWithFrame:frame collectionViewLayout:layout] autorelease];
}

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        CGRect bounds = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
        
        // 添加背景图片视图
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
        backgroundImageView.clipsToBounds = YES;
        backgroundImageView.userInteractionEnabled = YES;
        _backgroundImageView = [backgroundImageView retain];
        [backgroundImageView release];
        [self addSubview:_backgroundImageView];
        
        // 添加集合视图
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:bounds collectionViewLayout:layout];
        collectionView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds) * 3, 0);
        collectionView.pagingEnabled = YES;
        collectionView.backgroundColor = [UIColor clearColor];
        _collectionView = [collectionView retain];
        [collectionView release];
        [self addSubview:_collectionView];
        
        // 添加分页控件
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.bounds = CGRectMake(0, 0, bounds.size.width - 20, 30);
        pageControl.center = CGPointMake(CGRectGetMidX(bounds),
                                            CGRectGetMaxY(bounds) - CGRectGetMaxY(pageControl.bounds));
        pageControl.numberOfPages = 2;
        pageControl.currentPage = 0;
        pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl = [pageControl retain];
        [pageControl release];
        [self addSubview:_pageControl];
    }
    
    return self;
}

- (void)setView:(UIView<UICollectionViewDelegate, UICollectionViewDataSource> *)view
{
    _view = [view retain];
    [_view addSubview:self];
    _collectionView.delegate = _view;
    _collectionView.dataSource = _view;
}

@end

#import "DDIndex.h"

@interface DDIndex () <
    UITableViewDataSource,
    UITableViewDelegate,
    UICollectionViewDelegate,
    UICollectionViewDataSource>
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
    [layout setItemSize:CGSizeMake(kHotNewsShowComponentFrame.size.width,
                                   kHotNewsShowComponentFrame.size.height)];
    [layout setSectionInset:UIEdgeInsetsMake(20, 30, 60, 10)];
    [layout setMinimumInteritemSpacing:20];
    [layout setMinimumLineSpacing:60];
    CGRect frame = CGRectMake(CGRectGetMinX(_downImageView.frame),
                              CGRectGetMaxY(_downImageView.frame),
                              600,
                              300);
    DDCollectionViewPackage *viewPackage = [DDCollectionViewPackage collectionViewPackageWithFrame:frame
                                                                              collectionViewLayout:layout];
    [layout release];
    viewPackage.view = self;
    viewPackage.backgroundImageView.image = [UIImage imageNamed:@"最热-底_12"];
    viewPackage.collectionView.tag = kHotCollectionViewTag;
    viewPackage.pageControl.numberOfPages = 6;
    [viewPackage.collectionView registerClass:[UICollectionViewCell class]
                   forCellWithReuseIdentifier:@"CollectionViewCellIdenitfer"];
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
    [layout setItemSize:CGSizeMake(kCustomProjectComponentFrame.size.width,
                                   kCustomProjectComponentFrame.size.height)];
    [layout setSectionInset:UIEdgeInsetsMake(20, 10, 60, 10)];
    [layout setMinimumLineSpacing:20];
    CGRect frame = CGRectMake(CGRectGetMaxX(_downImageView.frame) + 25,
                              CGRectGetMaxY(_downImageView.frame),
                              280,
                              300);
    DDCollectionViewPackage *viewPackage = [DDCollectionViewPackage
                                            collectionViewPackageWithFrame:frame
                                            collectionViewLayout:layout];
    viewPackage.view = self;
    viewPackage.pageControl.numberOfPages = 7;
    viewPackage.backgroundImageView.image = [UIImage imageNamed:@"产品定制-底_14"];
    viewPackage.collectionView.tag = kCustomProjectCollectionViewTag;
    [viewPackage.collectionView registerClass:[UICollectionViewCell class]
                   forCellWithReuseIdentifier:@"CustomProjectCollcetionCell"];

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


#pragma mark - <UICollectionViewDatasource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return 11;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *resultCell = nil;
    if (kHotCollectionViewTag == collectionView.tag) {
        // 热门信息
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCellIdenitfer"
                                                                               forIndexPath:indexPath];
        CGRect frame = kHotNewsShowComponentFrame;
        DDProjectShowView *hotNews = [[DDProjectShowView alloc] initWithFrame:frame
                                                          projectShowViewType:DDProjectShowViewTypeSubTitle];
        hotNews.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
        hotNews.detailTextLabel.text = @"detail text";
        hotNews.imageView.image = [UIImage imageNamed:@"网上银行BOCNET1"];
        [cell.contentView addSubview:hotNews];
        [hotNews release];
        resultCell = cell;
    } else {
        // 产品定制
        UICollectionViewCell *customProjectCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CustomProjectCollcetionCell"
                                                                                            forIndexPath:indexPath];
        CGRect customProjectFrame = kCustomProjectComponentFrame;
        DDProjectShowView *customProject = [[DDProjectShowView alloc] initWithFrame:customProjectFrame
                                                                projectShowViewType:DDProjectShowViewTypeDefault];
        customProject.textLabel.text = @"ddddddd";
        customProject.imageView.image = [UIImage imageNamed:@"网上银行BOCNET1"];
        [customProjectCell.contentView addSubview:customProject];
        [customProject release];
        resultCell = customProjectCell;
    }

    return resultCell;
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"section:%ld row:%ld",indexPath.section, indexPath.row);
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

@end