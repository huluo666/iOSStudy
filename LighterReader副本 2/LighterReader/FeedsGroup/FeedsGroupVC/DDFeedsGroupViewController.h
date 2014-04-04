//
//  DDFeedsGroupViewController.h
//  LighterReader
//
//  Created by 萧川 on 14-4-3.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    DDCellTypeTitleOnly,
    DDCellTypeList,
    DDCellTypeMagazine,
    DDCellTypeCards
} DDCellType;

@interface DDFeedsGroupViewController : UITableViewController

@property (nonatomic, assign) DDCellType celltype;

@end
