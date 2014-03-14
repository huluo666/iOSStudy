//
//  DDCollectionViewController.m
//  「UI」下拉刷新上拉加载
//
//  Created by 萧川 on 14-3-1.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDCollectionViewController.h"
#import "DDPullDown.h"
#import "DDPullUp.h"

@interface DDCollectionViewController () <DDRefreshBaseDelegate>
{
    NSInteger _dataSource;
    UIAlertView *_alertView;
}

- (void)initUserInterface;
// 加载数据
- (void)loadData:(DDRefreshBaseView *)refreshBaseView;
// 清除提示
- (void)dissmissAlertView:(DDRefreshBaseView *)refreshBaseView;

@end

@implementation DDCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"集合视图展示";
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        UICollectionViewFlowLayout *layout = [[[UICollectionViewFlowLayout alloc] init] autorelease];
        layout.itemSize = CGSizeMake(80, 80);
        layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
        layout.minimumInteritemSpacing = 20;
        layout.minimumLineSpacing = 20;
        self = [self initWithCollectionViewLayout:layout];
    }
    return self;
}

- (void)dealloc
{
    [_alertView release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _dataSource = 3;
    [self initUserInterface];
}

- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.alwaysBounceVertical = YES;
    
    // 加载下拉刷新控件
    DDPullDown *pullDown = [DDPullDown pullDown];
    pullDown.scrollView = self.collectionView;
    pullDown.delegate = self;
    
    // 加载下拉加载更多控件
    DDPullUp *pullUp = [DDPullUp pullUp];
    pullUp.scrollView = self.collectionView;
    pullUp.delegate = self;
}

- (void)dissmissAlertView:(DDRefreshBaseView *)refreshBaseView
{
    [_alertView dismissWithClickedButtonIndex:0 animated:YES];
    [refreshBaseView endRefreshingWithSuccess:NO];
}

- (void)loadData:(DDRefreshBaseView *)refreshBaseView
{
//    [self.collectionView reloadData];
//    [refreshBaseView endRefreshingWithSuccess:YES];
}

#pragma mark - <DDRefreshBaseDelegate>

- (void)refreshBaseViewbeginRefreshing:(DDRefreshBaseView *)refreshBaseView
{
    // 模拟网络请求过程，返回请求成功或者失败和一个数组对象
    BOOL success = YES;
//    BOOL success = NO;
    if (success) {
        // 模拟加载数据等待过程, 加载完成更新数据
        _dataSource += 6;
        [self performSelector:@selector(loadData:)
                   withObject:refreshBaseView
                   afterDelay:1.0];
    } else {
        _alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                message:@"刷新数据失败，或者没有更新的数据，或者网络连接不正常，请稍候重试"
                                               delegate:nil
                                      cancelButtonTitle:nil
                                      otherButtonTitles:nil];
        [_alertView show];
        [self performSelector:@selector(dissmissAlertView:)
                   withObject:refreshBaseView
                   afterDelay:1.5];
    }
}

#pragma mark - collection数据源委托方法

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return _dataSource;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdenitfer = @"Cell";
    [self.collectionView registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier:cellIdenitfer];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdenitfer
                                                                           forIndexPath:indexPath];
    cell.backgroundColor = kRandomColor;

    return cell;
}

@end
