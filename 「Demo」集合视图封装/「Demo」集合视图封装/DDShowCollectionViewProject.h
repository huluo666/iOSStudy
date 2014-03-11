//
//  DDShowCollectionViewProject.h
//  「Demo」集合视图封装
//
//  Created by 萧川 on 3/9/14.
//  Copyright (c) 2014 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDShowCollectionViewProject : UIView

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIViewController<UICollectionViewDelegate, UICollectionViewDataSource>  *viewController;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

- (id)initWithFrame:(CGRect)frame layOut:(UICollectionViewFlowLayout *)layout;

@end
