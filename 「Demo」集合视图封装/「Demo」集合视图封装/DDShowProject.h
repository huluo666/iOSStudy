//
//  DDShowProject.h
//  「Demo」集合视图封装
//
//  Created by 萧川 on 3/9/14.
//  Copyright (c) 2014 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDShowProject : UIView

@property (strong, nonatomic) UIViewController <UITableViewDelegate, UITableViewDataSource> *viewController;
@property (strong, nonatomic) UITableView *tableView;

@end
