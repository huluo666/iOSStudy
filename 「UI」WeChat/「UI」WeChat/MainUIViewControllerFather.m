//
//  MainViewController.m
//  「UI」WeChat
//
//  Created by cuan on 14-2-1.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "MainUIViewControllerFather.h"
#import "WeChatTabBarController.h"

@interface MainUIViewControllerFather ()

- (void)initNavigationBar;
- (void)loadNavigationBarItem;

@end
 
@implementation MainUIViewControllerFather

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    WeChatTabBarController *tabBarViewController = (WeChatTabBarController *)self.tabBarController;
    [tabBarViewController showTabBar];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavigationBar];
    
    [self loadNavigationBarItem];
    self.title = WECHAT;
}

- (void)initNavigationBar
{
    /*
    // 设置导航条样式风格
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    // 只有barStyle为黑色半透明时背景颜色才有效果，
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0.065 green:0.052 blue:0.035 alpha:1.000];
    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"tabBar_bg"]; // invalid
    */
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tabBar_bg"] forBarMetrics:UIBarMetricsDefault];
}

- (void)loadNavigationBarItem
{
    // 右侧items
    UIBarButtonItem *itemMore = [[UIBarButtonItem alloc] init];
    itemMore.image = [UIImage imageNamed:@"taBbar_more_icon"];
    itemMore.tintColor = [UIColor whiteColor];
    itemMore.target = self;
    itemMore.action = @selector(rithtItemsPressed:);
    
    UIBarButtonItem *itemAdd = [[UIBarButtonItem alloc] init];
    itemAdd.image = [UIImage imageNamed:@"tabBar_add_icon"];
    itemAdd.tintColor = [UIColor whiteColor];
    itemAdd.target = self;
    itemAdd.action = @selector(rithtItemsPressed:);
    
    UIBarButtonItem *itemSearch = [[UIBarButtonItem  alloc] init];
    itemSearch.tintColor = [UIColor whiteColor];
    itemSearch.image = [UIImage imageNamed:@"taBbar_search_icon"];
    itemSearch.target = self;
    itemSearch.action = @selector(rithtItemsPressed:);

    NSArray *rightItems = @[itemMore, itemAdd, itemSearch];
    [itemSearch release];
    [itemAdd release];
    self.navigationItem.rightBarButtonItems = rightItems;
    
    // 左侧item
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] init];
    leftItem.tintColor = [UIColor whiteColor];
    leftItem.image = [UIImage imageNamed:@"taBbar_icon"];
    self.navigationItem.leftBarButtonItem = leftItem;
    [leftItem release];
    
    // 设置中间item
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    titleLabel.text = WECHAT;
    titleLabel.hidden = YES;
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    [titleLabel release];
    
    // 设置项UITableView(ItemMore)
    
}

- (void)rithtItemsPressed:(UIBarButtonItem *)sender
{
    if ([_delegate respondsToSelector:@selector(mainUIViewCotrollerFatherShowSettingTableView:)])
    {
        [_delegate mainUIViewCotrollerFatherShowSettingTableView:self];
    }
}

@end



























