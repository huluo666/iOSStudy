//
//  AboutViewController.m
//  UITask
//
//  Created by 萧川 on 14-2-17.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "AboutViewController.h"
#import "AudioPlayerViewController.h"

@interface AboutViewController () <UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic) UITableView *tableView;
@property (retain, nonatomic) NSArray *dataSource;

- (void)initDataSource;
- (void)initUserInterface;

@end

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"关于";
    }
    return self;
}

- (void)dealloc
{
    [_tableView release];
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
    _dataSource = [@[@"Deemo Title Song - Website Version",
                    @"Release My Soul",
                    @"Rё.L",
                    @"Wings of piano"] retain];
}

- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc] init];
    _tableView.frame = CGRectMake(0, 0, 320, 568);
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = nil;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = _dataSource[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AudioPlayerViewController *audioPlayerVC = [[AudioPlayerViewController alloc] initWithDataSource:_dataSource currentAudioIndex:indexPath.row];
    [self.navigationController pushViewController:audioPlayerVC animated:YES];
    [audioPlayerVC release];
}

@end
