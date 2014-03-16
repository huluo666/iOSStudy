//
//  DDPreciousMetal.m
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-14.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDPreciousMetal.h"
#import "DDPullDown.h"
#import "DDOptional.h"
#import "DDShowDetail.h"

@interface DDPreciousMetal () <
    UICollectionViewDelegate,
    UICollectionViewDataSource>

// 创建label
- (UILabel *)label;

// 创建button
- (UIButton *)buttonWithStateNormalTitle:(NSString *)title;

// button点击处理事件
- (void)buttonAction:(UIButton *)sender;

@end

@implementation DDPreciousMetal

- (void)dealloc
{
    NSLog(@"%@ is dealloced", [self class]);
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor brownColor];

        // 类别
        UILabel *categorylabel = [self label];
        categorylabel.center = CGPointMake(CGRectGetMidX(categorylabel.bounds),
                                           CGRectGetMidY(categorylabel.bounds));
        categorylabel.text = @"类别:";
        categorylabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:categorylabel];

        UIButton *categoryButton = [self buttonWithStateNormalTitle:@"默认"];
        categoryButton.center = CGPointMake(CGRectGetMaxX(categorylabel.frame) + CGRectGetMidX(categoryButton.bounds) + 5,
                                            CGRectGetMidY(categoryButton.bounds));
        [categoryButton addTarget:self
                           action:@selector(buttonAction:)
                 forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:categoryButton];

        // 供应商
        UILabel *supplierLabel = [self label];
        supplierLabel.center = CGPointMake(CGRectGetMaxX(categoryButton.frame) + CGRectGetMidX(supplierLabel.bounds) + 5,
                                           CGRectGetMidY(supplierLabel.bounds));
        supplierLabel.text = @"供应商:";
        supplierLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:supplierLabel];
        
        UIButton *supplierButton = [self buttonWithStateNormalTitle:@"默认"];
        supplierButton.center = CGPointMake(CGRectGetMaxX(supplierLabel.frame) + CGRectGetMidX(supplierButton.bounds) + 5,
                                            CGRectGetMidY(supplierButton.bounds));
        [supplierButton addTarget:self
                           action:@selector(buttonAction:)
                 forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:supplierButton];
        
        // 适宜人群，按年龄
        UILabel *targetAgeLabel = [self label];
        targetAgeLabel.center = CGPointMake(CGRectGetMaxX(supplierButton.frame) + CGRectGetMidX(targetAgeLabel.bounds) + 5,
                                           CGRectGetMidY(targetAgeLabel.bounds));
        targetAgeLabel.text = @"适宜人群（按年龄)";
        targetAgeLabel.bounds = CGRectMake(0, 0, 80, 40);
        targetAgeLabel.numberOfLines = 2;
        targetAgeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:targetAgeLabel];
        
        UIButton *targetAgeButton = [self buttonWithStateNormalTitle:@"默认"];
        targetAgeButton.center = CGPointMake(CGRectGetMaxX(targetAgeLabel.frame) + CGRectGetMidX(targetAgeButton.bounds) + 5,
                                            CGRectGetMidY(targetAgeButton.bounds));
        [targetAgeButton addTarget:self
                           action:@selector(buttonAction:)
                 forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:targetAgeButton];
        
        // 适宜人群，按意愿
        UILabel *targetWishLabel = [self label];
        targetWishLabel.center = CGPointMake(CGRectGetMaxX(targetAgeButton.frame) + CGRectGetMidX(targetWishLabel.bounds) + 5,
                                            CGRectGetMidY(targetWishLabel.bounds));
        targetWishLabel.text = @"适宜人群（按意愿)";
        targetWishLabel.bounds = CGRectMake(0, 0, 80, 40);
        targetWishLabel.numberOfLines = 2;
        targetWishLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:targetWishLabel];
        
        UIButton *targetWishButton = [self buttonWithStateNormalTitle:@"默认"];
        targetWishButton.center = CGPointMake(CGRectGetMaxX(targetWishLabel.frame) + CGRectGetMidX(targetWishButton.bounds) + 5,
                                             CGRectGetMidY(targetWishButton.bounds));
        [targetWishButton addTarget:self
                            action:@selector(buttonAction:)
                  forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:targetWishButton];
        
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
        collectionView.center = CGPointMake(CGRectGetMidX(frame),
                                            CGRectGetMaxY(targetWishButton.frame) + CGRectGetMidY(collectionView.bounds));
        
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

- (UILabel *)label
{
    UILabel *label = [[[UILabel alloc] init] autorelease];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    label.bounds = CGRectMake(0, 0, 60, 40);
    return label;
}

- (UIButton *)buttonWithStateNormalTitle:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.borderColor = [UIColor grayColor].CGColor;
    button.layer.borderWidth = 1.0f;
    button.layer.cornerRadius = 5;
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    button.titleLabel.textColor = [UIColor grayColor];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.bounds = CGRectMake(0, 0, 130, 40);
    [button addTarget:self
               action:@selector(buttonAction:)
    forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (void)buttonAction:(UIButton *)sender
{
    
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"自选模式"
                                                                           forIndexPath:indexPath];
    DDOptional *optional = [[DDOptional alloc] initWithFrame:CGRectZero];
    optional.bounds = CGRectMake(0, 0, 300, 300);
    optional.center = CGPointMake(CGRectGetMidX(cell.bounds), CGRectGetMidY(cell.bounds));
    __block DDPreciousMetal *view = self;
    optional.tapAction = ^(UIButton *sender) {
        if (sender.tag == kDetailButtonTag) {
            DDShowDetail *detail = [[DDShowDetail alloc] initWithFrame:CGRectZero];
            [view.superview addSubview:detail];
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
