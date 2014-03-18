//
//  DDOptional.m
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-14.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDOptionalView.h"
#import "DDShowDetail.h"
#import "DDPullDown.h"
#import "DDAppDelegate.h"
#import "DDOptionalCellView.h"

@interface DDOptionalView () <
    UICollectionViewDelegate,
    UICollectionViewDataSource>
{
    UIScrollView *_menuView;                    // 菜单视图
    UIButton *_currentSelectedButton;           // 记录当前选中标题按钮
    NSMutableArray *_dataSource;                 // 数据源
}

// 切换标题对应的视图
- (void)toggleTitle:(UIButton *)sender;
// 移动标题位置
- (void)moveTitle:(UIButton *)sender;

// 文本尺寸大小自动适应
- (CGRect)rectWithString:(NSString *)string font:(UIFont *)font constraintSize:(CGSize)constraintSize;

@end

@implementation DDOptionalView

- (void)dealloc
{
    NSLog(@"%@ dealloc", [self class]);
    [_menuView release];
    _currentSelectedButton = nil;
    [_dataSource release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 集合视图
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setItemSize:CGSizeMake(290, 290)];
        [layout setSectionInset:UIEdgeInsetsMake(10, 10, 10, 0)];
        [layout setMinimumInteritemSpacing:10];
        [layout setMinimumLineSpacing:10];

        // Collection view
        CGRect frame = self.bounds;

        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                                              collectionViewLayout:layout];
        [layout release];
        
        collectionView.bounds = CGRectMake(0, 0, CGRectGetWidth(frame) * 0.98, 640);
        collectionView.center = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame) + 60);
        
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:[UICollectionViewCell class]
           forCellWithReuseIdentifier:@"OptionalCell"];
        collectionView.alwaysBounceVertical = YES;
        collectionView.showsVerticalScrollIndicator = YES;
        [self addSubview:collectionView];
        [collectionView release];

        // 下拉刷新
        DDPullDown *pullDown = [DDPullDown pullDown];
        pullDown.scrollView = collectionView;
        pullDown.lastUpdate.textColor = [UIColor whiteColor];
        pullDown.status.textColor = [UIColor whiteColor];
        pullDown.indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        pullDown.arrow.image = [UIImage imageNamed:@"blackArrow"]; // cache
        pullDown.beginRefreshBaseView = ^(DDRefreshBaseView *refreshBaseView) {
            [DDHTTPManager sendRequstForOptionalWithUserId:[[NSUserDefaults standardUserDefaults] objectForKey:kUserInfoId]
                                                    typeId:@"1"
                                                pageNumber:@"22"
                                                  pageSize:@"6"
                                         completionHandler:^(id content, NSString *resultCode) {
                                             NSMutableArray *data = content;
                                             if (_dataSource != data) {
                                                 [_dataSource release];
                                                 _dataSource = nil;
                                                 _dataSource = [data mutableCopy];
                                                 [collectionView reloadData];
                                             }
                                             [refreshBaseView performSelector:@selector(endRefreshingWithSuccess:)
                                                                   withObject:nil
                                                                   afterDelay:1];
                                         }];
        };
        
        // 菜单
        _menuView = [[UIScrollView alloc] init];
        _menuView.bounds = CGRectMake(0, 0, CGRectGetWidth(collectionView.bounds) * 0.62 , 30);
        _menuView.center = CGPointMake(CGRectGetMidX(collectionView.frame),
                                      CGRectGetMinY(collectionView.frame) - CGRectGetHeight(_menuView.bounds) * 0.8);
        _menuView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_menuView];
        
        // 菜单两侧按钮
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftButton setBackgroundImage:kImageWithName(@"箭头左") forState:UIControlStateNormal];
        leftButton.bounds = CGRectMake(0, 0, 30, 30);
        leftButton.center = CGPointMake(CGRectGetMinX(_menuView.frame) - CGRectGetMidX(leftButton.bounds) * 1.5,
                                        CGRectGetMidY(_menuView.frame));
        leftButton.tag = kLeftButtonTag;
        [leftButton addTarget:self
                       action:@selector(moveTitle:)
             forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:leftButton];
        
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightButton setBackgroundImage:kImageWithName(@"箭头右") forState:UIControlStateNormal];
        rightButton.bounds = CGRectMake(0, 0, 30, 30);
        rightButton.center = CGPointMake(CGRectGetMaxX(_menuView.frame) + CGRectGetMidX(rightButton.bounds) * 1.5,
                                         CGRectGetMidY(_menuView.frame));
        [rightButton addTarget:self
                        action:@selector(moveTitle:)
              forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:rightButton];
        
        NSArray *titles = @[@"中银汇兑", @"境内代理海外开户见证业务", @"借记卡产品",
                            @"信用卡服务", @"理想之家.留学贷款", @"网上银行BOCNET",
                            @"中银保险", @"中银理财产品"];
        
        // 计算每个按钮的尺寸大小
        CGFloat lastButtonMaxX = 0;
        CGSize size = CGSizeMake(_menuView.bounds.size.width, _menuView.bounds.size.height);
        for (int i = 0; i < titles.count; i++ ) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:titles[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:16];
            CGRect rect = [self rectWithString:titles[i] font:[UIFont systemFontOfSize:18] constraintSize:size];
            button.bounds = rect;
            button.center = CGPointMake(lastButtonMaxX + CGRectGetMidX(button.bounds) + 20,
                                        CGRectGetMidY(_menuView.bounds));
            lastButtonMaxX = CGRectGetMaxX(button.frame);
            [button addTarget:self
                       action:@selector(toggleTitle:)
             forControlEvents:UIControlEventTouchUpInside];
            button.tag = kTitleButtonTag + i;
            [_menuView addSubview:button];
            
            // 默认选中第一个
            if (0 == i) {
                button.selected = YES;
                _currentSelectedButton = button;
            }
        }
        lastButtonMaxX += 20;
        _menuView.contentSize = CGSizeMake(lastButtonMaxX, CGRectGetHeight(_menuView.bounds));
        
        // 初始化界面的同时获取数据
        [DDHTTPManager sendRequstForOptionalWithUserId:[[NSUserDefaults standardUserDefaults] objectForKey:kUserInfoId]
                                                typeId:@"1"
                                            pageNumber:@"22"
                                              pageSize:@"2"
                                     completionHandler:^(id content, NSString *resultCode) {
                                         if (0 != [resultCode intValue]) {
                                             return;
                                         }
                                         if ([content isKindOfClass:[NSArray class]]) {
                                             NSMutableArray *data = content;
                                             if (0 == data.count) {
                                                 return;
                                             }
                                             if (_dataSource != data) {
                                                 [_dataSource release];
                                                 _dataSource = [content mutableCopy];
                                                 
                                                 // 更新界面
                                                 [collectionView reloadData];
                                             }
                                         }
                                     }];
    }

    return self;
}

- (void)toggleTitle:(UIButton *)sender
{
    if (_currentSelectedButton == sender) {
        return;
    }
    _currentSelectedButton.selected = NO;
    sender.selected = YES;
    _currentSelectedButton = sender;
    
    //    NSInteger index = sender.tag;
#pragma mark - TODO更新数据
}

- (void)moveTitle:(UIButton *)sender
{
    NSInteger index = sender.tag;
    if (index == kLeftButtonTag) {
        // 左移
        if (_menuView.contentOffset.x + 100 < 600) {
            [UIView animateWithDuration:kAnimateDuration / 2 animations:^{
                _menuView.contentOffset = CGPointMake(_menuView.contentOffset.x + 100,
                                                      _menuView.contentOffset.y);
            }];
        }
    } else {
        // 右移
        [UIView animateWithDuration:kAnimateDuration / 2 animations:^{
            if (_menuView.contentOffset.x > 100) {
                _menuView.contentOffset = CGPointMake(_menuView.contentOffset.x - 100,
                                                      _menuView.contentOffset.y);
            }
        }];
    }
}

#pragma mark - 文本大小自动适应

- (CGRect)rectWithString:(NSString *)string font:(UIFont *)font constraintSize:(CGSize)constraintSize
{
    CGRect rect = [string boundingRectWithSize:constraintSize
                                       options:NSStringDrawingTruncatesLastVisibleLine |
                   NSStringDrawingUsesFontLeading |
                   NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName:font}
                                       context:nil];
    return rect;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OptionalCell"
                                                                           forIndexPath:indexPath];
    DDOptionalCellView *optional = [[DDOptionalCellView alloc] initWithFrame:CGRectZero];
    optional.center = CGPointMake(CGRectGetMidX(cell.bounds), CGRectGetMidY(cell.bounds));
    if (_dataSource) {
        optional.titleLabel.text = [NSString stringWithFormat:@"%@", _dataSource[indexPath.row][@"productId"]];
        optional.displayLabel.text = _dataSource[indexPath.row][@"published"];
    }
    [cell.contentView addSubview:optional];
    [optional release];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"section:%ld row:%ld",indexPath.section, indexPath.row);
}

@end
