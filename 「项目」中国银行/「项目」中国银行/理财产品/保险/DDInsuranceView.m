//
//  DDInsurance.m
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-14.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDInsuranceView.h"
#import "DDPullDown.h"
#import "DDShowDetail.h"
#import "DDInsureCellView.h"

@interface DDInsuranceView () <
    UICollectionViewDelegate,
    UICollectionViewDataSource>
{
    NSMutableArray *_dataSource;
}

@end

@implementation DDInsuranceView

- (void)dealloc
{
    NSLog(@"%@ is dealloced", [self class]);
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
        collectionView.bounds = CGRectMake(0, 0, CGRectGetWidth(self.bounds) * 0.98, 640);
        collectionView.center = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame) + 10);
        
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:[UICollectionViewCell class]
           forCellWithReuseIdentifier:@"自选模式"];
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
        pullDown.arrow.image = [UIImage imageNamed:@"blackArrow"];

        pullDown.beginRefreshBaseView = ^(DDRefreshBaseView *refreshBaseView) {
            [DDHTTPManager sendRequestFortInsureWithUserId:[[NSUserDefaults standardUserDefaults] objectForKey:kUserInfoId]
                                                pageNumber:@"1"
                                                  pageSize:@"12"
                                         completionHandler:^(id content, NSString *resultCode) {
                                             NSMutableArray *data = content;
                                             if (_dataSource != data) {
                                                 [_dataSource release];
                                                 _dataSource = nil;
                                                 _dataSource = [content mutableCopy];
                                                 [collectionView reloadData];
                                             }
                                             [refreshBaseView performSelector:@selector(endRefreshingWithSuccess:)
                                                                   withObject:nil
                                                                   afterDelay:1];
                                         }];

        };
        
        // 加载网络数据
        [DDHTTPManager sendRequestFortInsureWithUserId:[[NSUserDefaults standardUserDefaults] objectForKey:kUserInfoId]
                                            pageNumber:@"1"
                                              pageSize:@"12"
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

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    NSInteger count = 2;
    if (_dataSource) {
        count = _dataSource.count;
    }
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"自选模式"
                                                                           forIndexPath:indexPath];
    DDInsureCellView *insure = [[DDInsureCellView alloc] initWithFrame:CGRectZero];
    insure.center = CGPointMake(CGRectGetMidX(cell.bounds), CGRectGetMidY(cell.bounds));
    if (_dataSource) {
        insure.titleLabel.text = _dataSource[indexPath.row][@"name"];
        insure.categoryNameLabel.text = _dataSource[indexPath.row][@"categoryName"];
        insure.characteristicLabel.text = [NSString stringWithFormat:@"产品属性：%@",
                                           _dataSource[indexPath.row][@"characteristic"]];
        insure.companyLabel.text = [NSString stringWithFormat:@"发行公司：%@",
                                           _dataSource[indexPath.row][@"company"]];
        insure.crowdAgeLabel.text = [NSString stringWithFormat:@"使用人群：%@岁客户",
                                    [NSString stringWithFormat:@"%@", _dataSource[indexPath.row][@"crowd_age"]]];
        insure.timesLabel.text = [NSString stringWithFormat:@"保险期限：%@年",
                                     [NSString stringWithFormat:@"%@", _dataSource[indexPath.row][@"crowd_age"]]];
    }
    [cell.contentView addSubview:insure];
    [insure release];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"section:%ld row:%ld",indexPath.section, indexPath.row);
}

@end
