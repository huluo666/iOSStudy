//
//  DDViewController.h
//  面试职通车
//
//  Created by 萧川 on 14-4-16.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    DDViewControllerTypeDefault,
    DDViewControllerTypeHasExtends
} DDViewControllerType;

@interface DDViewController : UIViewController

@property (nonatomic, assign) DDViewControllerType viewControllerType;
- (id)initWithType:(DDViewControllerType)aViewControllerType;

@property (nonatomic, strong) UIView *titleView;


@end
