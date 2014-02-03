//
//  MainViewController.m
//  「UI」TabBar、Navi联合
//
//  Created by cuan on 14-2-1.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "MainViewController.h"
#import "ChatController.h"
#import "FindViewController.h"
#import "SettingViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    ChatController *chatVC = [[ChatController alloc] init];
    chatVC.tabBarItem = [[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:102] autorelease];
    UINavigationController *chatNvaiController = [[UINavigationController alloc] initWithRootViewController:chatVC];
    [chatVC release];
    
    FindViewController *findVC = [[FindViewController alloc] init];
    findVC.tabBarItem = [[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:101] autorelease];
    UINavigationController *findNaviController = [[UINavigationController alloc] initWithRootViewController:findVC];
    [findVC release];
    
    SettingViewController *settingVC = [[SettingViewController alloc] initWithStyle:UITableViewStylePlain];
    settingVC.tabBarItem = [[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:103] autorelease];
    UINavigationController *settingNaivController = [[UINavigationController alloc] initWithRootViewController:settingVC];
    [settingVC release];
    
    NSArray *controllers = @[chatNvaiController, findNaviController, settingNaivController];
    [chatNvaiController release];
    [findNaviController release];
    [settingNaivController release];
    
    self.viewControllers = controllers;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
