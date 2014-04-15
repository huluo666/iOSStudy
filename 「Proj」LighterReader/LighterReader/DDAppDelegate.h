//
//  DDAppDelegate.h
//  LighterReader
//
//  Created by 萧川 on 14-3-26.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DDRootViewController;

@interface DDAppDelegate : UIResponder <
    UIApplicationDelegate,
    WeiboSDKDelegate
>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) DDRootViewController *rootVC;

@property (strong, nonatomic) NSString *wbtoken;

@end
