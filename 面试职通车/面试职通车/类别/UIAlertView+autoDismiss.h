//
//  UIAlertView+autoDismiss.h
//  面试职通车
//
//  Created by 萧川 on 14-4-17.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (autoDismiss)

+ (void)toastWithTitle:(NSString *)theTitle
               message:(NSString *)theMessage
              duration:(NSTimeInterval)theDuration;

@end
