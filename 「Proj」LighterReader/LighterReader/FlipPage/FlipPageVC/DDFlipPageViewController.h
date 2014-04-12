//
//  DDFlipPageViewController.h
//  「Demo」上下翻页
//
//  Created by 萧川 on 14-4-2.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDPageViewController.h"

@interface DDFlipPageViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *dataSource;

- (id)initWithCellType:(DDCellType)type;
- (void)refresh;

@end
