//
//  DDSignupViewController.h
//  LighterReader
//
//  Created by 萧川 on 14-3-27.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    DDSignTypeSignin,  // singn in
    DDSignTypeSignup  // singn up
} DDSignType;

@interface DDSignViewController : UIViewController

@property (nonatomic, assign) DDSignType signtype;

@end
