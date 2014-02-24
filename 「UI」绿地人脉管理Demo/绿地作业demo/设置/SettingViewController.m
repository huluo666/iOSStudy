//
//  SettingViewController.m
//  绿地作业demo
//
//  Created by 张鹏 on 14-2-14.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingDetailViewController.h"
#import "SettingTableViewCell.h"

@interface SettingViewController () <UITableViewDelegate, UITableViewDataSource> {
    
    UITableView *_tableView;
    
    NSArray *_imageNameList;
    NSArray *_titleList;
    NSArray *_subTitleList;
    NSInteger _rowCount;
}

- (void)initializeDataSource;
- (void)initializeUserInterface;
- (void)processControl:(UISegmentedControl *)sender;

@end

@implementation SettingViewController

- (id)init
{
    self = [super init];
    if (self) {
        
        self.title = @"设置";
        
    }
    return self;
}

- (void)dealloc {
    
    [_tableView     release];
    [_imageNameList release];
    [_titleList     release];
    [_subTitleList  release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)initializeDataSource {
    
    _imageNameList = [[NSArray alloc] initWithObjects:
                      @"appmodule_DeviceInfo.png",
                      @"appmodule_Flashlight.png",
                      @"appmodule_medal.png",
                      @"appmodule_kbdpro.png", nil];
    _titleList = [[NSArray alloc] initWithObjects:
                  @"免费应用",
                  @"可优化省电项",
                  @"当前耗电情况",
                  @"本月充电情况", nil];
    _subTitleList = [[NSArray alloc] initWithObjects:
                     @"限时下载",
                     @"3项",
                     @"详情",
                     @"无安全充电", nil];
}

- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _rowCount = 5;
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = [UIColor blackColor];
    _tableView.separatorInset = UIEdgeInsetsZero;
    _tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backS.png"]];
    [self.view addSubview:_tableView];
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"3", @"5", @"8"]];
    segmentedControl.bounds = CGRectMake(0, 0, 150, 25);
    segmentedControl.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backS.png"]];
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self action:@selector(processControl:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segmentedControl;
    [segmentedControl release];
}

- (void)processControl:(UISegmentedControl *)sender {
    
    NSInteger index = sender.selectedSegmentIndex;
    switch (index) {
        case 0: _rowCount = 5; break;
        case 1: _rowCount = 8; break;
        case 2: _rowCount = 20; break;
        default: break;
    }
    [_tableView reloadData];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[SettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:cellIdentifier] autorelease];
    }
    cell.titleImageView.image = IMAGE_WITH_NAME(_imageNameList[indexPath.row % 4]);
    cell.titleDisplay.text = _titleList[indexPath.row % 4];
    cell.subTitleDisplay.text = _subTitleList[indexPath.row % 4];
    
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SettingDetailViewController *detailVC = [[SettingDetailViewController alloc] initWithItemName:_titleList[indexPath.row % 4]];
    [self presentViewController:detailVC animated:YES completion:nil];
    [detailVC release];
}

@end
