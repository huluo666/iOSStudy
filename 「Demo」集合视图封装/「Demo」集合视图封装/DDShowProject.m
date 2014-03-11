//
//  DDShowProject.m
//  「Demo」集合视图封装
//
//  Created by 萧川 on 3/9/14.
//  Copyright (c) 2014 CUAN. All rights reserved.
//

#import "DDShowProject.h"

@implementation DDShowProject

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:frame];
        tableView.backgroundColor = [UIColor redColor];
        _tableView = tableView;
        [self addSubview:_tableView];
    }
    return self;
}

- (void)setViewController:(UIViewController<UITableViewDelegate,UITableViewDataSource> *)viewController
{
    _viewController = viewController;
    [_viewController.view addSubview:self];
    _tableView.delegate = _viewController;
    _tableView.dataSource = _viewController;
}

@end
