//
//  ViewController.m
//  「Demo」集合视图封装
//
//  Created by 萧川 on 3/9/14.
//  Copyright (c) 2014 CUAN. All rights reserved.
//

#import "ViewController.h"
#import "DDShowProject.h"
#import "DDShowCollectionViewProject.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    DDShowProject *showProject = [[DDShowProject alloc] initWithFrame:self.view.frame];
//    showProject.viewController = self;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [layout setItemSize:CGSizeMake(220, 100)];
    [layout setSectionInset:UIEdgeInsetsMake(20, 30, 60, 10)];
    [layout setMinimumInteritemSpacing:20];
    [layout setMinimumLineSpacing:80];
    
    DDShowCollectionViewProject *showCollectionView = [[DDShowCollectionViewProject alloc] initWithFrame:self.view.frame layOut:layout];
    showCollectionView.viewController = self;
    [showCollectionView.collectionView registerClass:[UICollectionViewCell class]forCellWithReuseIdentifier:@"CustomProjectCollcetionCell"];
}

#pragma mark - collectionView ---

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return 11;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *resultCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CustomProjectCollcetionCell" forIndexPath:indexPath];
    resultCell.backgroundColor = [UIColor redColor];
    return resultCell;
}

#pragma mark - tableView ---

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    cell.textLabel.text = @"dddd";
    return cell;
}






@end
