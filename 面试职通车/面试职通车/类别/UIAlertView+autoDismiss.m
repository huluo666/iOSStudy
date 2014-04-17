//
//  UIAlertView+autoDismiss.m
//  面试职通车
//
//  Created by 萧川 on 14-4-17.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "UIAlertView+autoDismiss.h"

@implementation UIAlertView (autoDismiss)


+ (void)toastWithTitle:(NSString *)theTitle
               message:(NSString *)theMessage
              duration:(NSTimeInterval)theDuration {
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:theTitle
                              message:theMessage
                              delegate:nil
                              cancelButtonTitle:nil
                              otherButtonTitles:nil];
    
    [alertView show];
    
    NSMethodSignature *signature = [UIAlertView instanceMethodSignatureForSelector:
                                    @selector(dismissWithClickedButtonIndex:animated:)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:alertView];
    [invocation setSelector:@selector(dismissWithClickedButtonIndex:animated:)];
    NSInteger index = 0;
    [invocation setArgument:&index atIndex:2];
    BOOL animated = YES;
    [invocation setArgument:&animated atIndex:3];
    [invocation retainArguments];
    [invocation performSelector:@selector(invoke) withObject:nil afterDelay:theDuration];
}

@end
