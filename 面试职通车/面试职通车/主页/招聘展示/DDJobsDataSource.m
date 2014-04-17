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


@end
