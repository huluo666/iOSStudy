//
//  DDShowCollectionViewProject.m
//  「Demo」集合视图封装
//
//  Created by 萧川 on 3/9/14.
//  Copyright (c) 2014 CUAN. All rights reserved.
//

#import "DDShowCollectionViewProject.h"

@implementation DDShowCollectionViewProject


- (void)setLayout:(UICollectionViewFlowLayout *)layout
{
    _layout = layout;
    _collectionView.collectionViewLayout = _layout;
}

- (id)initWithFrame:(CGRect)frame layOut:(UICollectionViewFlowLayout *)layout
{
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionView *collection = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        collection.backgroundColor = [UIColor yellowColor];
            [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CustomProjectCollcetionCell"];
        _collectionView = collection;
        [self addSubview:collection];
        
    }
    return self;
}


- (void)setViewController:(UIViewController<UICollectionViewDelegate, UICollectionViewDataSource> *)viewController
{
    _viewController = viewController;
    [_viewController.view addSubview:self];
    _collectionView.delegate = _viewController;
    _collectionView.dataSource = _viewController;
}


@end
