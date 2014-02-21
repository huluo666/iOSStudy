//
//  CasusViewController.m
//  「UI」UITest
//
//  Created by 萧川 on 14-2-20.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "CasusViewController.h"
#import "PullRefreshViewController.h"
#import "AudioPlayerViewController.h"

@interface CasusViewController () <UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic) NSMutableArray *dataSource;
@property (retain, nonatomic) UITableView *tableView;

// 初始化数据源
- (void)initDataSource;
// 初始化用户界面
- (void)initUserInterface;

@end

@implementation CasusViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"个人案例";
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        UITabBarItem *tabBarItem = [[UITabBarItem alloc]
                                    initWithTitle:@"个人案例"
                                    image:[UIImage imageNamed:@"item3"]
                                    tag:13];
        self.tabBarItem = tabBarItem;
        [tabBarItem release];
    }
    return self;
}

- (void)dealloc
{
    [_dataSource release];
    [_tableView release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initDataSource];
    [self initUserInterface];
}

#pragma mark 私有方法

- (void)initDataSource
{
    _dataSource = [[NSMutableArray alloc]
                   initWithArray:@[@"项目一", @"项目二", @"项目三"]];

}

- (void)initUserInterface
{
    _tableView = [[UITableView alloc]
                  initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.bounces = NO;
    [self.view addSubview:_tableView];
}

#pragma mark - <UITableViewDataSource>数据源方法

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleDefault
                 reuseIdentifier:cellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.imageView.image = [UIImage imageNamed:@"cell"];
    }
    
    cell.textLabel.text = _dataSource[indexPath.row];
    return cell;
}


#pragma mark - <UITableViewDelegate>代理方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        PullRefreshViewController *pullRefresh =
            [[PullRefreshViewController alloc] init];
        [self.navigationController pushViewController:pullRefresh animated:YES];
        [pullRefresh release];
    }
    if (indexPath.row == 1) {
        NSArray *nameLists = [@[@"Deemo Title Song - Website Version",
                         @"Release My Soul",
                         @"Rё.L",
                         @"Wings of piano"] retain];
        AudioPlayerViewController *audioPlayerVC = [[AudioPlayerViewController alloc]
                                                    initWithDataSource:nameLists
                                                    currentAudioIndex:indexPath.row];
        [self.navigationController pushViewController:audioPlayerVC animated:YES];
        [audioPlayerVC release];
    }
    if (indexPath.row == 2) {

    }
}

@end
