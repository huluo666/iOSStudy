//
//  ViewController.m
//  demo15-UICollectionView
//
//  Created by 张鹏 on 13-9-28.
//  Copyright (c) 2013年 张鹏. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+RandomColor.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [layout setItemSize:CGSizeMake(100, 100)];
    [layout setMinimumInteritemSpacing:10];
    [layout setMinimumLineSpacing:10];
//    [layout setHeaderReferenceSize:CGSizeMake(320, 60)];
//    [layout setFooterReferenceSize:CGSizeMake(320, 60)];
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [collectionView setBackgroundColor:[UIColor clearColor]];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
//    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
//              withReuseIdentifier:@"Supplementary"];
//    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
//              withReuseIdentifier:@"Supplementary"];
    [collectionView setDelegate:self];
    [collectionView setDataSource:self];
    [self.view addSubview:collectionView];
    [collectionView release];
    [layout release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <UICollectionViewDatasource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 100;
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
//           viewForSupplementaryElementOfKind:(NSString *)kind
//                                 atIndexPath:(NSIndexPath *)indexPath {
//    
//    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind
//                                                                        withReuseIdentifier:@"Supplementary"
//                                                                               forIndexPath:indexPath];
//    
//    [view setBackgroundColor:[UIColor blackColor]];
//    
//    return view;
//}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    [cell.contentView setBackgroundColor:[UIColor specialRandomColor]];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"section:%d row:%d",indexPath.section, indexPath.row);
}

@end
