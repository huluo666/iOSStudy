//
//  RootViewController.h
//  1.FontTableViewDemo
//
//  Created by 周泉 on 13-2-24.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G开发培训中心. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
@private
    UITableView  *_tableView;
    NSDictionary *_dataDic;
    NSArray      *_keyArray;
}

@end
