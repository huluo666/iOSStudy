//
//  MainViewController.h
//  Notification
//
//  Created by imac  on 13-9-17.
//  Copyright (c) 2013年 imac . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
@interface MainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate,EGORefreshTableHeaderDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    
    BOOL _reloading;

}
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)UIImageView *barView;
@property(nonatomic,retain)NSMutableArray *list;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end
