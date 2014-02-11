//
//  AnimationSandboxViewController.m
//  AnimationSandbox
//
//  Created by David Casserly on 23/02/2010.
//  Copyright devedup.com 2010. All rights reserved.
//

#import "AnimationSandboxViewController.h"

@implementation AnimationSandboxViewController

#pragma mark -
#pragma mark Memory

- (void)dealloc {
	[customView release];
    [super dealloc];
}

- (void)viewDidLoad {
	UIView *customView = [[Canvas alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
	customView.backgroundColor = [UIColor blackColor];
	[self.view addSubview:customView];
	[customView release];
    [super viewDidLoad];
}


@end
