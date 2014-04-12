//
//  DDPageViewController.h
//  「Demo」FlipPage
//
//  Created by 萧川 on 14-4-2.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    DDCellTypeTitleOnly,
    DDCellTypeList,
    DDCellTypeMagazine,
    DDCellTypeCards
} DDCellType;

@interface DDPageViewController : UITableViewController

@property (strong, nonatomic) NSArray *dataSource;
@property (nonatomic, assign) DDCellType celltype;

- (id)initWithCellType:(DDCellType)type;

@end
