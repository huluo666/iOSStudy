//
//  DDMainUINaviController.h
//  LighterReader
//
//  Created by 萧川 on 14-3-28.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDMainUINaviController : UINavigationController <UIViewControllerTransitioningDelegate>

// Display floater adjust view
- (void)showFloaterAdjustView;

// floater adjust action blocks
@property (copy, nonatomic) void (^titleOnlyView)(void);
@property (copy, nonatomic) void (^listView)(void);
@property (copy, nonatomic) void (^magazineView)(void);
@property (copy, nonatomic) void (^cardsView)(void);

@property (copy, nonatomic) void (^refresh)(void);
@property (copy, nonatomic) void (^markCategroyAsRead)(void);
@property (copy, nonatomic) void (^toggleOldestFirst)(void);
@property (copy, nonatomic) void (^toggleShowStoriesPolicy)(void);
@property (copy, nonatomic) void (^openWebpageDirectly)(void);

@end
