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
    UISegmentedControl *_segmentedControl; // 分段控件
    
    NSArray *_images; // 未选中状态标题图片
    NSArray *_imgaesSelected; // 选中状态标题图片
}

// 选中事件
- (void)segmentAction:(UISegmentedControl *)sender;
// 选中segment
- (void)selectedIndex:(NSInteger)index;

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
    [_segmentedControl release];
    [_images release];
    [_imgaesSelected release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        // 标题
        UIImage *consult = [UIImage imageNamed:@"a_07@2x"];
        UIImage *combo = [UIImage imageNamed:@"b_08@2x"];
        UIImage *optional = [UIImage imageNamed:@"c_09@2x"];
        if ([UIImage instancesRespondToSelector:@selector(imageWithRenderingMode:)]) {
            consult = [consult imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            combo = [combo imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            optional = [optional imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        _images = [@[consult, combo, optional] retain];
        
        
        // 标题
        UIImage *consultSelected = [UIImage imageNamed:@"aa_07@2x"];
        UIImage *comboSelected = [UIImage imageNamed:@"bb_08@2x"];
        UIImage *optionalSelected = [UIImage imageNamed:@"cc_09@2x"];
        if ([UIImage instancesRespondToSelector:@selector(imageWithRenderingMode:)]) {
            consultSelected = [consultSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            comboSelected = [comboSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            optionalSelected = [optionalSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        _imgaesSelected = [@[consultSelected, comboSelected, optionalSelected] retain];
        
        // 分段控件
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:_images];
        segmentedControl.tintColor = [UIColor clearColor];
        segmentedControl.selectedSegmentIndex = 0;
        segmentedControl.bounds = CGRectMake(0, 0, 400, 50);
        segmentedControl.center = CGPointMake(self.center.x, 50);
        [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
        _segmentedControl = [segmentedControl retain];
        [segmentedControl release];
        [self addSubview:_segmentedControl];
        
        [self loadConsultView];
    }
    return self;
}

- (void)segmentAction:(UISegmentedControl *)sender
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
    
    _segmentedControl.selectedSegmentIndex = 0;
    [self selectedIndex:0];
    
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
    _segmentedControl.selectedSegmentIndex = 1;
    [self selectedIndex:1];
    
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
    
    [self selectedIndex:2];
    _segmentedControl.selectedSegmentIndex = 2;
    
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

- (void)selectedIndex:(NSInteger)index
{
    if (0 == index) {
        [_segmentedControl setImage:_imgaesSelected[0] forSegmentAtIndex:0];
        [_segmentedControl setImage:_images[1] forSegmentAtIndex:1];
        [_segmentedControl setImage:_images[2] forSegmentAtIndex:2];
    }
    if (1 == index) {
        [_segmentedControl setImage:_imgaesSelected[1] forSegmentAtIndex:1];
        [_segmentedControl setImage:_images[0] forSegmentAtIndex:0];
        [_segmentedControl setImage:_images[2] forSegmentAtIndex:2];
    }
    if (2 == index) {
        [_segmentedControl setImage:_imgaesSelected[2] forSegmentAtIndex:2];
        [_segmentedControl setImage:_images[0] forSegmentAtIndex:0];
        [_segmentedControl setImage:_images[1] forSegmentAtIndex:1];
    }
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
