//
//  DDInsurance.m
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-14.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDInsurance.h"
#import "DDPullDown.h"
#import "DDOptional.h"
#import "DDShowDetail.h"

@interface DDInsurance () <
    UICollectionViewDelegate,
    UICollectionViewDataSource>

@end

@implementation DDInsurance

- (void)dealloc
{
    NSLog(@"%@ is dealloced", [self class]);
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
//        DDPullDown *pullDown = [DDPullDown pullDown];
//        pullDown.scrollView = collectionView;
//        pullDown.lastUpdate.textColor = [UIColor whiteColor];
//        pullDown.status.textColor = [UIColor whiteColor];
//        pullDown.indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
//        pullDown.arrow.image = [UIImage imageNamed:@"blackArrow"];
#pragma mark - TODO 刷新数据CollectionView
    }
    return self;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"自选模式"
                                                                           forIndexPath:indexPath];
    DDOptional *optional = [[DDOptional alloc] initWithFrame:CGRectZero];
    optional.bounds = CGRectMake(0, 0, 300, 300);
    optional.center = CGPointMake(CGRectGetMidX(cell.bounds), CGRectGetMidY(cell.bounds));
    optional.tapAction = ^(UIButton *sender) {
        if (sender.tag == kDetailButtonTag) {
            DDShowDetail *detail = [[DDShowDetail alloc] initWithFrame:CGRectZero];
            [self.superview addSubview:detail];
            [detail release];
        } else {
#pragma mark - TODO
            NSLog(@"选购");
        }
    };
    //    cell.backgroundColor = [UIColor grayColor];
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
