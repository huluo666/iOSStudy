//
//  DDDetailViewController.m
//  「Demo」PullControlDemo
//
//  Created by 萧川 on 14-4-12.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDDetailViewController.h"
#import "DDPullDownControl.h"
#import "DDPullUpControl.h"

@interface DDDetailViewController () <DDPullControlDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DDPullDownControl *pullDownControl;

@property (nonatomic, strong) DDPullUpControl *pullUpControl;

@end

@implementation DDDetailViewController

- (void)dealloc {
    
    NSLog(@"%s", __FUNCTION__);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // Black Background
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, -400, 320, 400)];
    bgView.backgroundColor = [UIColor clearColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
//    self.tableView.contentSize = CGSizeMake(320, 900);
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:bgView];
    
    _pullDownControl = [[DDPullDownControl alloc] init];
    _pullDownControl.delegate = self;
    [self.tableView addSubview:_pullDownControl];
    
    _pullUpControl = [[DDPullUpControl alloc] init];
    _pullUpControl.delegate = self;
    [self.tableView addSubview:_pullUpControl];
}

- (void)pullControlDidBeginAction:(DDPullControl *)pullControl {
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [_pullDownControl endAction];
    });
}

#pragma mark - UITableViewDataSource 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cellIdenitfier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

@end
