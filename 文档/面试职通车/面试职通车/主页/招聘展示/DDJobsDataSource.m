//
//  DDJobsDataSource.m
//  面试职通车
//
//  Created by 萧川 on 14-4-17.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDJobsDataSource.h"
#import "DDTableViewCell.h"

@implementation DDJobsDataSource

#pragma mark - dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}

- (DDTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *homeCellIdentifier = @"homeCellIdentifier";
    DDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homeCellIdentifier];
    if (!cell) {
        cell = [[DDTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:homeCellIdentifier];
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (0 == section) {
        return @"名企招聘";
    } else {
        return nil;
    }
}

#pragma mark - delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (0 == section) {
        return 44;
    } else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, kScreenWidth - 5, 34)];
    label.text = @"名企招聘";
    [view addSubview:label];
    view.backgroundColor = [UIColor whiteColor];
    
    CGRect lineFrame = CGRectMake(0, 43, kScreenWidth, 1);
    UIView *blueLine = [[UIView alloc] initWithFrame:lineFrame];
    blueLine.backgroundColor = kBlueColor;
    [view addSubview:blueLine];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

@end
