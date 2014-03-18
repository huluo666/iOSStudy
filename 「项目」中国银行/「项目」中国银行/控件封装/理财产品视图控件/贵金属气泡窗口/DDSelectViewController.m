//
//  DDSelectViewController.m
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-18.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDSelectViewController.h"

static NSString *CellIdentifier = @"Cell";

@interface DDSelectViewController ()

@property (retain, nonatomic) NSArray *dataSource;

@end

@implementation DDSelectViewController

- (void)dealloc
{
    NSLog(@"气泡窗口over");
    [_completionHandler release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style dataSource:(NSArray *)dataSource
{
    self = [super initWithStyle:style];
    if (self) {
        self.dataSource = dataSource;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UITableView *tableView = [[UITableView alloc] init];
    tableView.backgroundColor = kRandomColor;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    self.tableView = tableView;
    [tableView release];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.text = _dataSource[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

#pragma mark - Table view dalegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *returnString = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    if (_completionHandler) {
        _completionHandler(returnString, indexPath.row);
    }
}

@end
