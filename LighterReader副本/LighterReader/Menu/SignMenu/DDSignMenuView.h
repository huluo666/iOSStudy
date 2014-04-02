//
//  DDMenuView.h
//  LighterReader
//
//  Created by 萧川 on 14-3-27.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDSignMenuView : UITableView

// swip close self
- (void)swipLeftAction;

@property (nonatomic ,copy) void (^handleLeftSwip)(void);

@end
