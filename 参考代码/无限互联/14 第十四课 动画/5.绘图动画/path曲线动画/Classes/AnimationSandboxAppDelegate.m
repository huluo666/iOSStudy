//
//  AnimationSandboxAppDelegate.m
//  AnimationSandbox
//
//  Created by David Casserly on 23/02/2010.
//  Copyright devedup.com 2010. All rights reserved.
//

#import "AnimationSandboxAppDelegate.h"
#import "AnimationSandboxViewController.h"

@implementation AnimationSandboxAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
