//
//  DDDelegateViewController.m
//  「Demo」PullControlDemo
//
//  Created by 萧川 on 14-4-13.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDDelegateViewController.h"
#import "DDPullDownControl.h"
#import "DDPullUpControl.h"

@interface DDDelegateViewController () <DDPullControlDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation DDDelegateViewController

- (void)dealloc {

    NSLog(@"%s", __FUNCTION__);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataSource = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 6; i++) {
        NSString *str = [NSString stringWithFormat:@"初始数据编号：%ld", i];
        [_dataSource addObject:str];
    }
    
    DDPullDownControl *pullDownControl = [[DDPullDownControl alloc] init];
    pullDownControl.delegate = self;
    pullDownControl.backgroundColor = [UIColor yellowColor];
    pullDownControl.pullAction = @"刷新中...";
    pullDownControl.pullToAction = @"下拉刷新";
    pullDownControl.pullReleaseToAction = @"松手开始刷新";
    pullDownControl.showsScrollIndicatorPolicy = NO;
    [self.tableView addSubview:pullDownControl];
    
    DDPullUpControl *pullUpControl = [[DDPullUpControl alloc] init];
    pullUpControl.delegate = self;
    pullUpControl.backgroundColor = [UIColor greenColor];
    pullUpControl.showsScrollIndicatorPolicy = NO;
    [self.tableView addSubview:pullUpControl];
}

#pragma mark - <DDPullControlDelegate>

- (void)pullControlDidBeginAction:(DDPullControl *)pullControl {
    
    if ([pullControl isMemberOfClass:[DDPullDownControl class]]) {
        for (NSInteger i = 0; i < 5; i++) {
            NSString *str = [NSString stringWithFormat:@"下拉随机数据编号：%d",
                             arc4random() % 999];
            [_dataSource insertObject:str atIndex:0];
        }
    }
    
    if ([pullControl isMemberOfClass:[DDPullUpControl class]]) {
        for (NSInteger i = 0; i < 5; i++) {
            NSString *str = [NSString stringWithFormat:@"上拉随机数据编号：%d",
                             arc4random() % 999];
            [_dataSource addObject:str];
        }
    }
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [pullControl endAction];
        [self.tableView reloadData];
    });
}

#pragma mark - <UITableViewDataSource >

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cellIdenitfier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = _dataSource[indexPath.row];
    return cell;
}

@end
