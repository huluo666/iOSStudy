//
//  AnimationSandboxAppDelegate.h
//  AnimationSandbox
//
//  Created by David Casserly on 23/02/2010.
//  Copyright devedup.com 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AnimationSandboxViewController;

@interface AnimationSandboxAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    AnimationSandboxViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet AnimationSandboxViewController *viewController;

@end

