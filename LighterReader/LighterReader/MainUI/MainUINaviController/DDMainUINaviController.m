//
//  DDMainUINaviController.m
//  LighterReader
//
//  Created by 萧川 on 14-3-28.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDMainUINaviController.h"
#import "DDPresentAnimation.h"
#import "DDDismissAnimation.h"

@interface DDMainUINaviController () <
    UITableViewDataSource,
    UITableViewDelegate
>

@property (retain, nonatomic) NSArray *dataSource;

@end

@implementation DDMainUINaviController

- (void)deallo {
    
    [_dataSource release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationBar.barTintColor = [UIColor whiteColor];
        self.navigationBar.tintColor = [UIColor grayColor];
        [self.navigationBar setBackgroundImage:DDImageWithName(@"navi")
                                 forBarMetrics:UIBarMetricsDefault];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - UIViewControllerTransitioningDelegate

// Present
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[[DDPresentAnimation alloc] init] autorelease];
    
}

// Dismiss
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[[DDDismissAnimation alloc] init] autorelease];
}

#pragma mark - 
- (void)showSettingView {

    UIView *clearView = [[UIView alloc] init];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    clearView.frame = screenBounds;
    clearView.tag = kClearViewTag;
    [self.view addSubview:clearView];
    [clearView release];
    
    CGRect frame = CGRectMake(CGRectGetWidth(screenBounds) * 0.2,
                              70,
                              CGRectGetWidth(screenBounds) * 0.78,
                              40 * 6);
    UITableView *settingTableView = [[UITableView alloc]
                                     initWithFrame:frame
                                     style:UITableViewStylePlain];
    settingTableView.tag = kSettingViewTag;
    settingTableView.bounces = NO;
    settingTableView.rowHeight = 40;
    settingTableView.delegate = self;
    settingTableView.dataSource = self;
    settingTableView.separatorColor = [UIColor grayColor];
    [self.view addSubview:settingTableView];
    [settingTableView release];
    
    UIView *headerView = [[UIView alloc] init];
    headerView.bounds = CGRectMake(0, 0, CGRectGetWidth(screenBounds) * 0.78, 40);
    headerView.backgroundColor = [UIColor greenColor];
    settingTableView.tableHeaderView = headerView;
    [headerView release];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    UIView *clearView = (UIView *)[self.view viewWithTag:kClearViewTag];
    if (clearView) {
        [clearView removeFromSuperview];
    }
    
    UITableView *settingTableView = (UITableView *)[self.view viewWithTag:kSettingViewTag];
    if (settingTableView) {
        [settingTableView removeFromSuperview];
    }
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

//    NSInteger count = 0;
//    if (_dataSource && [_dataSource isKindOfClass:[NSArray class]]) {
//        count = _dataSource.count;
//    }
//    return count;
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *settingViewCellIdentifier = @"settingViewCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:settingViewCellIdentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:settingViewCellIdentifier] autorelease];
        cell.backgroundColor = [UIColor colorWithWhite:0.296 alpha:1.000];
        UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        selectedBackgroundView.backgroundColor = [UIColor colorWithWhite:0.196 alpha:1.000];
        cell.selectedBackgroundView = selectedBackgroundView;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    cell.tintColor = [UIColor redColor];
    return cell;
}

@end
