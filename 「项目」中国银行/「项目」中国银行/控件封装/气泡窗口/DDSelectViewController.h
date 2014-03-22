//
//  DDSelectViewController.h
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-18.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDSelectViewController : UITableViewController

@property (copy, nonatomic) void(^completionHandler)(NSString *returnString, NSInteger index);
@property (retain, nonatomic) UIView *headerView;

- (id)initWithStyle:(UITableViewStyle)style dataSource:(NSArray *)dataSource;

@end
