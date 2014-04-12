//
//  DDNaviMenuView.h
//  LighterReader
//
//  Created by 萧川 on 14-3-29.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDNaviMenuView : UIView

// swip close self
- (void)swipLeftAction;
@property (nonatomic ,copy) void (^handleSwipLeft)(void);

@end
