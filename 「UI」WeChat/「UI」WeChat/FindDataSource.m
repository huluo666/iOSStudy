//
//  FindDateSource.m
//  「UI」WeChat
//
//  Created by cuan on 14-2-3.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "FindDataSource.h"

@interface FindDataSource ()

@end

@implementation FindDataSource

- (void)dealloc
{
    [_allTables release];
    [super dealloc];
}

#pragma mark - 数据源方法<UITableViewDataSource>
// 第section组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allTables.count;
}

// 每一行的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell.textLabel.text = _allTables[indexPath.row];
    return cell;
}

@end
