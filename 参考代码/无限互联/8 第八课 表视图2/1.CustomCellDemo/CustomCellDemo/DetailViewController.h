//
//  DetailViewController.h
//  CustomCellDemo
//
//  Created by 周泉 on 13-2-27.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G开发培训中心. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UITableViewController
{
@private
    NSArray *_listArray;
}

@property (nonatomic, assign) kTableViewCellType cellType;

@end
