//
//  DDMainUIViewController.h
//  LighterReader
//
//  Created by 萧川 on 14-3-27.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDMainUIViewController : UIViewController

@property (nonatomic, copy) void(^handleMenuBarItemAction)(void);
@property (nonatomic, copy) void(^handleSearchBarItemAction)(void);

@end
