//
//  DDHomeViewController.m
//  面试职通车
//
//  Created by 萧川 on 14-4-17.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDHomeViewController.h"
#import "DDInterviewScheduleViewController.h"
#import "DDNaviDataSource.h"
#import "DDNaviCell.h"
#import "DDLoginViewController.h"
#import "DDJobsDataSource.h"
#import "UIAlertView+autoDismiss.h"
#import "DDPullDownControl.h"

@interface DDHomeViewController () <UIAlertViewDelegate>

@property (nonatomic, strong) DDNaviDataSource *naviDataSource;
@property (nonatomic, strong) DDJobsDataSource *jobsDataSource;

@end

@implementation DDHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"面试职通车";
        _naviDataSource = [[DDNaviDataSource alloc] init];
        _jobsDataSource = [[DDJobsDataSource alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 隐藏左上角按钮
    [[[self.titleView subviews] lastObject] setHidden:YES];
    
    // 添加登录与注册
    UIButton *authorityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    authorityButton.frame = CGRectMake(CGRectGetWidth(self.titleView.bounds) - 44, 0, 44, 44);
    [authorityButton setBackgroundImage:DDImageWithName(@"title_login") forState:UIControlStateNormal];
    [authorityButton addTarget:self action:@selector(authorityAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview:authorityButton];
    
    // 添加导航
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    [layout setItemSize:CGSizeMake(width / 3 - 10, width / 3 - 10)];
    [layout setMinimumInteritemSpacing:0];
    [layout setMinimumLineSpacing:15];
    [layout setSectionInset:UIEdgeInsetsMake(1, 1, 0, 1)];
    
    CGRect naviFrame = CGRectMake(0, 64, width, 226);
    UICollectionView *naviCollection = [[UICollectionView alloc] initWithFrame:naviFrame collectionViewLayout:layout];
    [naviCollection setBackgroundColor:[UIColor clearColor]];
    [naviCollection registerClass:[DDNaviCell class] forCellWithReuseIdentifier:@"naviCell"];
    
    naviCollection.dataSource = _naviDataSource;
    [self.view addSubview:naviCollection];
    
    // 添加名企招聘信息
    CGFloat height = [[UIScreen mainScreen] bounds].size.height;
    CGRect frame = CGRectMake(0, CGRectGetMaxY(naviFrame), width, height - CGRectGetHeight(naviFrame));
    UITableView *jobsTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    jobsTableView.backgroundColor = [UIColor redColor];
    jobsTableView.dataSource = _jobsDataSource;
    [self.view addSubview:jobsTableView];
    
    DDPullDownControl *pullDown = [[DDPullDownControl alloc] init];
    [jobsTableView addSubview:pullDown];
    __weak UITableView *weakTableView = jobsTableView;
    pullDown.pullControlDidBeginAction = ^(DDPullControl *pullControl){
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [pullControl endAction];
            [weakTableView reloadData];
        });
    };
}

- (void)authorityAction:(UIButton *)sender {

    if ([DDAuthorityManager defaultAuthorityManager].isLogined) {
        // 注销;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:@"你确定要注销？"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
        [alert show];
        
    } else {
        // 登录
        DDLoginViewController *loginVC = [[DDLoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex) {
        // 确定退出
        [[DDAuthorityManager defaultAuthorityManager] setLogined:NO];
        [UIAlertView toastWithTitle:nil message:@"您已经退出" duration:0.8];
    }
}

@end
