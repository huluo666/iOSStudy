//
//  SettingViewController.m
//  UITask
//
//  Created by 萧川 on 14-2-14.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "SettingViewController.h"
#import "CellContent.h"
#import "DeatilInfoViewController.h"
#import "CustomCell.h"

@interface SettingViewController ()

@property (retain, nonatomic) NSMutableArray *dataSource;
@property (assign, nonatomic) NSInteger displayCount;

- (void)initDataSource;
- (void)initUserInterface;

- (void)processControl:(UISegmentedControl *)controller;

@end

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"设置";
    }
    return self;
}


- (void)dealloc
{
    [_dataSource release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initDataSource];
    [self initUserInterface];
}

- (void)initDataSource
{
    CellContent *flashinght = [CellContent cellContentWithImageName:@"appmodule_Flashlight"
                                                               text:@"免费应用"
                                                         deatilText:@"限时下载"];
    CellContent *helper = [CellContent cellContentWithImageName:@"appmodule_helper"
                                                           text:@"可优化省电项"
                                                     deatilText:@"3项"];
    CellContent *kbdpro = [CellContent cellContentWithImageName:@"appmodule_kbdpro"
                                                           text:@"当前耗电应用"
                                                     deatilText:@"详情"];
    CellContent *medal = [CellContent cellContentWithImageName:@"appmodule_medal"
                                                          text:@"本月充电情况"
                                                    deatilText:@"无安全充电"];
    NSArray *temp = @[flashinght, helper, kbdpro, medal];
    _dataSource = [[NSMutableArray alloc] init];
    for (int i = 0; i < 5; i++) {
        [_dataSource addObjectsFromArray:temp];
    }
    
    _displayCount = 5;
}

- (void)initUserInterface
{
    UITableView *tableView = [[UITableView alloc] init];
    tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backS"]];
    tableView.separatorColor = [UIColor blackColor];
    tableView.rowHeight = CELL_ROW_HEIGHT;
    self.tableView = tableView;
    [tableView release];
    
    
    UISegmentedControl *segmentedControl  = [[UISegmentedControl alloc]
                                             initWithItems:@[@"5", @"8", @"20"]];
    [segmentedControl setTitle:@"5" forSegmentAtIndex:0];
    [segmentedControl setTitle:@"8" forSegmentAtIndex:1];
    [segmentedControl setTitle:@"20" forSegmentAtIndex:2];
    segmentedControl.bounds               = CGRectMake(0, 0, 120, 30);
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor            = [UIColor whiteColor];
    [segmentedControl addTarget:self
                         action:@selector(processControl:)
               forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segmentedControl;
    [segmentedControl release];
}

- (void)processControl:(UISegmentedControl *)controller
{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)controller;
    
    _displayCount =  [[segmentedControl
                       titleForSegmentAtIndex:segmentedControl.selectedSegmentIndex]
                      integerValue];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _displayCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[CustomCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.customImage = [UIImage imageNamed:[_dataSource[indexPath.row] imageName]];
//    cell.customText = [_dataSource[indexPath.row] text];
    cell.textLabel.text = [_dataSource[indexPath.row] text];
    cell.detailTextLabel.text = [_dataSource[indexPath.row] detailText];
    
    return cell;
}

#pragma mark - delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DeatilInfoViewController *detailInfoVC = [[DeatilInfoViewController alloc] initWithExplain:[_dataSource[indexPath.row] text]];
    detailInfoVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:detailInfoVC animated:YES completion:nil];
    [detailInfoVC release];
}

@end
