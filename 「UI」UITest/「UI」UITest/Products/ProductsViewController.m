//
//  ProductsViewController.m
//  「UI」UITest
//
//  Created by 萧川 on 14-2-20.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "ProductsViewController.h"
#import "ProDuctsDetailViewController.h"

@interface ProductsViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (retain, nonatomic) UICollectionView *collectionView;

- (void)initUserInterface;

@end

@implementation ProductsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        UITabBarItem *tabBarItem = [[UITabBarItem alloc]
                                    initWithTitle:@"产品中心"
                                    image:[UIImage imageNamed:@"item2"]
                                    tag:12];
        self.tabBarItem = tabBarItem;
        [tabBarItem release];
    }
    return self;
}

- (void)dealloc
{
    [_collectionView release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self initUserInterface];
}

- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor orangeColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [layout setItemSize:CGSizeMake(100, CGRectGetHeight(self.view.frame) / 5)];
    [layout setMinimumInteritemSpacing:10];
    [layout setMinimumLineSpacing:10];
    
    CGRect frame = CGRectMake(0, 20, CGRectGetWidth(self.view.frame),
                              CGRectGetHeight(self.view.frame));
    UICollectionView *collectionView = [[UICollectionView alloc]
                                        initWithFrame:frame
                                        collectionViewLayout:layout];
    [collectionView setBackgroundColor:[UIColor clearColor]];
    [collectionView registerClass:[UICollectionViewCell class]
       forCellWithReuseIdentifier:@"Cell"];
    [collectionView setDelegate:self];
    [collectionView setDataSource:self];
    [self.view addSubview:collectionView];
    [collectionView release];
    [layout release];
}


#pragma mark - <UICollectionViewDatasource>

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView
                                  dequeueReusableCellWithReuseIdentifier:@"Cell"
                                  forIndexPath:indexPath];

    NSString *imageName = [NSString stringWithFormat:@"iicon%ld",
                           indexPath.row + 1];
    UIImageView *imageView = [[UIImageView alloc]
                              initWithImage:[UIImage imageNamed:imageName]];
    [cell.contentView addSubview:imageView];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProDuctsDetailViewController *deatilVC =
        [[ProDuctsDetailViewController alloc] init];
    [self.navigationController pushViewController:deatilVC animated:YES];
}

@end
