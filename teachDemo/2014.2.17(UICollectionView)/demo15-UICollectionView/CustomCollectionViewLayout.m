//
//  CustomCollectionViewLayout.m
//  demo15-UICollectionView
//
//  Created by 张鹏 on 13-9-28.
//  Copyright (c) 2013年 张鹏. All rights reserved.
//

#import "CustomCollectionViewLayout.h"

@implementation CustomCollectionViewLayout

- (void)prepareLayout {
    
    [super prepareLayout];
}


- (CGSize)collectionViewContentSize {
    
    return CGSizeZero;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    return @[];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind
                                                                     atIndexPath:(NSIndexPath *)indexPath {
    
    return [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:kind
                                                                          withIndexPath:indexPath];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind
                                                                  atIndexPath:(NSIndexPath *)indexPath {
    
    return [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:decorationViewKind
                                                                       withIndexPath:indexPath];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    return NO;
}

@end
