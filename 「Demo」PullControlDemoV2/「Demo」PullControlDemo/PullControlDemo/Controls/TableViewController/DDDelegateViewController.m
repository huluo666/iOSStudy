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

@property (nonatomic, strong) DDPullDownControl *pullDownControl;
@property (nonatomic, strong) DDPullUpControl *pullUpControl;

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
    
    _pullDownControl = [[DDPullDownControl alloc] init];
    _pullDownControl.delegate = self;
    _pullDownControl.backgroundColor = [UIColor yellowColor];
    [self.tableView addSubview:_pullDownControl];
    
    _pullUpControl = [[DDPullUpControl alloc] init];
    _pullUpControl.delegate = self;
    _pullUpControl.backgroundColor = [UIColor greenColor];
    [self.tableView addSubview:_pullUpControl];
}

#pragma mark - <DDPullControlDelegate>

- (void)pullControlDidBeginAction:(DDPullControl *)pullControl {
    
    if ([pullControl isMemberOfClass:[DDPullDownControl class]]) {
        for (NSInteger i = 0; i < 5; i++) {
            NSString *str = [NSString stringWithFormat:@"下拉随机数据编号：%ld", i];
            [_dataSource insertObject:str atIndex:0];
        }
    }
    
    if ([pullControl isMemberOfClass:[DDPullUpControl class]]) {
        for (NSInteger i = 0; i < 15; i++) {
            NSString *str = [NSString stringWithFormat:@"上拉随机数据编号：%ld", i];
            [_dataSource addObject:str];
        }
    }
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [_pullDownControl endAction];
        [_pullUpControl endAction];
        [self.tableView reloadData];
    });
}

#pragma mark - <UITableViewDataSource >

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cellIdenitfier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = _dataSource[indexPath.row];
    return cell;
}

@end
