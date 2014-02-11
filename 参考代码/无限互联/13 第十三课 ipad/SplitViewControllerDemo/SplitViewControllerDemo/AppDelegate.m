//
//  AppDelegate.m
//  SplitViewControllerDemo
//
//  Created by wei.chen on 13-1-7.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "AppDelegate.h"
#import "MasterViewController.h"
#import "DetailViewController.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    MasterViewController *masterCtrl = [[MasterViewController alloc] init];
    DetailViewController *detailCtrl = [[DetailViewController alloc] init];
    
    UINavigationController *masterNav = [[UINavigationController alloc] initWithRootViewController:masterCtrl];
    UINavigationController *detailNav = [[UINavigationController alloc] initWithRootViewController:detailCtrl];
    
        
    UISplitViewController *splitViewCtrl = [[UISplitViewController alloc] init];
    //是否通过手势控制 浮动显示Master窗口
    splitViewCtrl.presentsWithGesture = YES;
    splitViewCtrl.delegate = self;
    splitViewCtrl.viewControllers = @[masterNav,detailNav];
    self.window.rootViewController = splitViewCtrl;
    
    
    [splitViewCtrl release];
    [masterCtrl release];
    [detailCtrl release];
    [detailNav release];
    [masterNav release];
    
    return YES;
}


//隐藏master窗口调用
- (void)splitViewController:(UISplitViewController *)svc
     willHideViewController:(UIViewController *)aViewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController:(UIPopoverController *)pc {
    NSLog(@"隐藏master窗口");
}

//显示master窗口调用
- (void)splitViewController:(UISplitViewController *)svc
     willShowViewController:(UIViewController *)aViewController
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    NSLog(@"显示master窗口");
}

//master窗口作为浮动窗口显示
- (void)splitViewController:(UISplitViewController *)svc
          popoverController:(UIPopoverController *)pc
  willPresentViewController:(UIViewController *)aViewController {
    NSLog(@"浮动显示");
}

//返回NO:显示master窗口, YES:隐藏master窗口
//如果此协议方法不实现，则横屏Master窗口显示，竖屏隐藏Master窗口
//- (BOOL)splitViewController:(UISplitViewController *)svc
//   shouldHideViewController:(UIViewController *)vc
//              inOrientation:(UIInterfaceOrientation)orientation {
//    return NO;
//}

@end
