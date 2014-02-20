//
//  ProductsViewController.m
//  「UI」UITest
//
//  Created by 萧川 on 14-2-20.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "ProductsViewController.h"
#import "ProductsDetailViewController.h"

@interface ProductsViewController () <
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout,
    UITableViewDataSource,
    UITableViewDelegate>

@property (retain, nonatomic) UICollectionView *collectionView;

// 处理分段控件事件
- (void)processControl:(UISegmentedControl *)sender;
// 加载集合视图
- (void)loadCollectionViewUserInterface;
// 加载表视图
- (void)loadTableViewUserInterface;
// 清除加载过的视图
- (void)clearViews;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UISegmentedControl *segmentedControl  = [[UISegmentedControl alloc]
                                             initWithItems:@[@"Collection", @"TableView"]];
    segmentedControl.bounds               = CGRectMake(0, 0, 320, 30);
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor            = [UIColor whiteColor];
    [segmentedControl addTarget:self
                         action:@selector(processControl:)
               forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segmentedControl;
    [segmentedControl release];
    self.navigationItem.titleView = segmentedControl;
    
	[self loadCollectionViewUserInterface];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.navigationController.isNavigationBarHidden) {
        self.navigationController.navigationBarHidden = NO;
    }

}

- (void)processControl:(UISegmentedControl *)sender
{
    NSInteger index = sender.selectedSegmentIndex;
    if (index == 0) {
        [self loadCollectionViewUserInterface];
    }
    else {
        [self loadTableViewUserInterface];
    }
}

- (void)clearViews
{
    NSArray *views = self.view.subviews;
    for (UIView *view in views) {
        [view removeFromSuperview];
    }
}

- (void)loadCollectionViewUserInterface
{
    [self clearViews];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [layout setItemSize:CGSizeMake(60, 60)];
    [layout setMinimumInteritemSpacing:30];
    [layout setMinimumLineSpacing:50];
    [layout setSectionInset:UIEdgeInsetsMake(20, 20, 0, 20)];
    
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

- (void)loadTableViewUserInterface
{
    [self clearViews];
    
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect frame = CGRectMake(0, 0, 320, 560);
    NSLog(@"%@", self.view);
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor redColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    [tableView release];
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
    if (!cell) {
        cell = [[[UICollectionViewCell alloc] init] autorelease];
    }

    NSString *imageName = [NSString stringWithFormat:@"iicon%ld",
                           indexPath.row + 1];
    UIImageView *imageView = [[UIImageView alloc]
                              initWithImage:[UIImage imageNamed:imageName]];
    cell.backgroundView = imageView;
    [imageView release];
    
    return cell;
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleSubtitle
                 reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
    }
    
    NSString *imageName = [NSString stringWithFormat:@"iicon%ld",
                           indexPath.row + 1];
    cell.imageView.image = [UIImage imageNamed:imageName];
    cell.textLabel.text = [NSString stringWithFormat:@"产品列表%ld", indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductsDetailViewController *detailVC = [[ProductsDetailViewController alloc]
                                              initWithText:[NSString stringWithFormat:@"产品列表%ld\n向右滑动返回", indexPath.row]];
    [self.navigationController pushViewController:detailVC animated:YES];
    [detailVC release];
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductsDetailViewController *detailVC =
        [[ProductsDetailViewController alloc] initWithText:[NSString stringWithFormat:@"产品列表%ld\n向右滑动返回", indexPath.row]];
    [self.navigationController pushViewController:detailVC animated:YES];
    [detailVC release];
}

@end
