//
//  DetailViewController.h
//  1.FontTableViewDemo
//
//  Created by 周泉 on 13-2-24.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G开发培训中心. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
@private
    UITableView    *_tableView;
    NSMutableArray *_fontsArray;
}

@property (nonatomic, assign) BOOL isBaseCell;

@end
