//
//  DDAbroad.m
//  「项目」中国银行
//
//  Created by 萧川 on 3/7/14.
//  Copyright (c) 2014 CUAN. All rights reserved.
//

#import "DDAbroad.h"
#import "DDCombo.h"
#import "DDOptional.h"

@interface DDAbroad () <UITableViewDelegate, UITableViewDataSource>
{
    UIView *_currentSelectedView;
    NSArray *_imageViewLocationList; // 用于存储5个坐标点
    NSMutableArray *_imageViewList;  // 视图重用集合
}

- (void)processControl:(UISegmentedControl *)sender;

// 加载政策咨询视图
- (void)loadConsultView;
// 加载套餐模式视图
- (void)loadComboView;
// 加载自选模式视图
- (void)loadOptionalView;

@end

@implementation DDAbroad

- (void)dealloc
{
    [_currentSelectedView release];
    [_imageViewLocationList release];
    [_imageViewList release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        // 标题
        UIImage *consult = kImageWithName(@"aa_07.png");
        UIImage *combo = kImageWithName(@"bb_08.png");
        UIImage *optional = kImageWithName(@"cc_09.png");
        NSArray *images = @[consult, combo, optional];
        
        // 分段控件
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"1", @"2", @"3"]];
       
        for (int i = 0; i < 3; i++) {
             [segmentedControl setImage:[UIImage imageNamed:@"cc_09"] forSegmentAtIndex:i];//设置指定索引的图片
        }
        segmentedControl.selectedSegmentIndex = 0;
        segmentedControl.apportionsSegmentWidthsByContent = YES;
        [self loadConsultView];
        segmentedControl.bounds = CGRectMake(0, 0, 400, 50);
        segmentedControl.center = CGPointMake(self.center.x, 50);
        segmentedControl.backgroundColor = [UIColor whiteColor];
        [segmentedControl addTarget:self action:@selector(processControl:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:segmentedControl];
        [segmentedControl release];


    }
    return self;
}

- (void)processControl:(UISegmentedControl *)sender
{
    NSUInteger index = sender.selectedSegmentIndex;
    switch (index) {
        case 0:
            [self loadConsultView];
            break;
        case 1:
            [self loadComboView];
            break;
        case 2:
            [self loadOptionalView];
            break;
        default:
            break;
    }
}

- (void)loadConsultView
{
    [_currentSelectedView removeFromSuperview];
    // tableView
    UITableView *tableView = [[UITableView alloc] init];
    tableView.bounds = CGRectMake(0, 0, 600, 400);
    tableView.center = self.center;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.rowHeight = 60;
    _currentSelectedView = [tableView retain];
    [self addSubview:tableView];
    [tableView release];
}

- (void)loadComboView
{
    [_currentSelectedView removeFromSuperview];
    _currentSelectedView = nil;
    
    // 初始化三个视图的center坐标点
    _imageViewLocationList = [@[[NSValue valueWithCGPoint:CGPointMake(-100, 550)],
                                [NSValue valueWithCGPoint:CGPointMake(175, 550)],
                                [NSValue valueWithCGPoint:CGPointMake(425, 550)],
                                [NSValue valueWithCGPoint:CGPointMake(800, 550)],
                                [NSValue valueWithCGPoint:CGPointMake(1200, 550)]] retain];
    
    // 初始化图片


 
}


- (void)loadOptionalView
{
    [_currentSelectedView removeFromSuperview];
    DDOptional *optionalView = [[DDOptional alloc] initWithFrame:CGRectZero];
    optionalView.bounds = CGRectMake(0, 0, 300, 300);
    optionalView.center = self.center;
    optionalView.processTap = ^(UIButton *sender){
        NSLog(@"选购点击按钮回调");
    };
    _currentSelectedView = [optionalView retain];
    [self addSubview:optionalView];
    [optionalView release];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier  = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier] autorelease];
        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"excel_23"]];
        cell.backgroundView = backgroundView;
        [backgroundView release];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.numberOfLines = 1;
        cell.detailTextLabel.textAlignment = NSTextAlignmentCenter;
        cell.detailTextLabel.textColor = [UIColor redColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];

    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld------------", indexPath.row];

    return cell;
}

#pragma mark - <UITableViewDelegate>

@end
