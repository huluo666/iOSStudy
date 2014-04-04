//
//  DDSearchMenuView.h
//  LighterReader
//
//  Created by 萧川 on 14-4-4.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDSearchMenuView : UIView

// swip right close self
- (void)swipRightAction;
@property (nonatomic ,copy) void (^handleSwipRight)(void);

@end
