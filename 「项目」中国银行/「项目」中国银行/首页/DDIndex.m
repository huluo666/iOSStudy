//
//  DDIndex.m
//  「项目」中国银行
//
//  Created by 萧川 on 3/7/14.
//  Copyright (c) 2014 CUAN. All rights reserved.
//

#import "DDIndex.h"

@interface DDIndex ()
{
    NSMutableDictionary *_dataSource;  // 数据源，存储网络获取的数据
    UIImageView *_downImageView;       // 下面的图片展示视图
    UIImageView *_upImageView;         // 上面的图片展示视图
    NSInteger _currentShowImageIndex;  // 记录上面当前显示的是第几张图片
    
    
}

// 网络请求
- (void)requestForImages;
// 初始化循环播放图片视图
- (void)initializePlayImagesRunLoopView;
// 开始图片循环播放
- (void)startRunLoop;
// 获取真实的应该显示的图片的索引
- (NSInteger)realImageIndexWithIndex:(NSInteger)index;

@end

@implementation DDIndex

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {        
        self.backgroundColor = [UIColor grayColor];
        [self requestForImages];
        [self initializePlayImagesRunLoopView];
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

- (void)requestForImages
{
    // 请求网络获取图片
#pragma mark - TODO net request

    // 将获取到的图片存入字典中
    _dataSource = [[NSMutableDictionary alloc] init];
    UIImage *image1 = [UIImage imageNamed:@"view_05"];
    UIImage *image2 = [UIImage imageNamed:@"中银保险"];
    NSArray *loopImages = @[image1, image2];
    [_dataSource setObject:loopImages forKey:kLoopImagesKey];
}

- (void)initializePlayImagesRunLoopView
{
    CGRect frame = CGRectMake(10, 15, 600, 320);
    
    // 下面的图片展示视图
    _downImageView = [[UIImageView alloc] initWithFrame:frame];
    _downImageView.contentMode = UIViewContentModeScaleToFill;
    _downImageView.backgroundColor = [UIColor yellowColor];
    [self addSubview:_downImageView];
    
    // 上面的图片展示视图
    _upImageView = [[UIImageView alloc] initWithFrame:frame];
    _upImageView.contentMode = UIViewContentModeScaleToFill;
    _upImageView.backgroundColor = [UIColor greenColor];
    [self addSubview:_upImageView];

    [self startRunLoop];
}

- (void)startRunLoop
{
    NSInteger upImageViewIndex = [self realImageIndexWithIndex:_currentShowImageIndex];
    NSInteger downImageViewIndex = [self realImageIndexWithIndex:_currentShowImageIndex + 1];
    NSArray *images = [_dataSource objectForKey:kLoopImagesKey];
    _upImageView.image = images[upImageViewIndex];
    _downImageView.image = images[downImageViewIndex];
    // 将上面的图片展示视图向左播放，并设置渐隐
    CGPoint center = _upImageView.center;
    [UIView animateWithDuration:kAnimateDuration
                     animations:^{
                         _upImageView.alpha = 0.5f;
                         _upImageView.center = CGPointMake(center.x - CGRectGetWidth(_upImageView.bounds),
                                                           center.y);
                         [self sendSubviewToBack:_upImageView];
                     }
                     completion:^(BOOL finished) {
                         _upImageView.center = center;
                         _upImageView.alpha = 1.0f;
                         _currentShowImageIndex = downImageViewIndex;
                         [self bringSubviewToFront:_upImageView];
//                         _upImageView.image = images[downImageViewIndex];
//                         _downImageView.image = images[[self realImageIndexWithIndex:downImageViewIndex + 1]];
                     }];
    // 循环播放
    [self performSelector:@selector(startRunLoop)
               withObject:nil
               afterDelay:kAnimateDuration];
}

- (NSInteger)realImageIndexWithIndex:(NSInteger)index
{
    NSArray *images = [_dataSource objectForKey:kLoopImagesKey];
    if (index == images.count) {
        index = 0;
    }
    return index;
}

@end
