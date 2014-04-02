//
//  DDDisplayView.h
//  LighterReader
//
//  Created by 萧川 on 14-3-31.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDDisplayView : UITableView

@property (retain, nonatomic) UIView *upView;
@property (copy, nonatomic) void (^upSlipCompletionHandler)(void);
@property (copy, nonatomic) void (^downSlipCompletionHandler)(void);

@property (copy, nonatomic) void (^willUpSliphandler)(void);
@property (copy, nonatomic) void (^selfIdentityCompletionHandler)(void);
@property (copy, nonatomic) void (^upViewIdentityCompletionHandler)(void);


@end
