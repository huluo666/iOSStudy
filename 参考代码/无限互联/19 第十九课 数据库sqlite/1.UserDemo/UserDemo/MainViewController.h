//
//  MainViewController.h
//  UserDemo
//
//  Created by wei.chen on 13-2-27.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain)NSArray *data;
@property(nonatomic,retain)UITableView *tableView;

@end
