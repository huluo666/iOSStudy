//
//  ReTabBarViewController.m
//  「UI」WeChat
//
//  Created by cuan on 14-2-1.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "WeChatTabBarViewController.h"
#import "ChatViewController.h"
#import "ContactsViewController.h"
#import "FindViewController.h"
#import "BaseNavigationController.h"

#define BOTTOM_VIEW_TAG 999
#define LABEL_TAG 222

@interface WeChatTabBarViewController ()

@property (retain, nonatomic) UIButton *selectedButton;

- (void)initControllers;
- (void)loadCustomTabBar;

@end

@implementation WeChatTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // 干掉系统的标签栏
        self.tabBar.hidden = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initControllers];
    [self loadCustomTabBar];
}

// 初始化各标签项的导航控制器
- (void)initControllers
{
    ChatViewController *chatVC = [[ChatViewController alloc] init];
    UINavigationController *chatNavi = [[UINavigationController alloc] initWithRootViewController:chatVC];
    [chatVC release];
    
    FindViewController *findVC = [[FindViewController alloc] init];
    BaseNavigationController *findNavi = [[BaseNavigationController alloc] initWithRootViewController:findVC];
    [findVC release];
    
    ContactsViewController *contactsVc = [[ContactsViewController alloc] init];
    BaseNavigationController *contactsNavi = [[BaseNavigationController alloc] initWithRootViewController:contactsVc];
    [contactsVc release];
    
    self.viewControllers = @[chatNavi, findNavi, contactsNavi];
    [chatNavi release];
    [findNavi release];
    [contactsNavi release];
}

// 载入自定义的标签栏
- (void)loadCustomTabBar
{
    // 模拟标签栏TabBar
    UIView *bottomView = [[UIView alloc] init];
    bottomView.bounds = CGRectMake(0, 0, 320, 35);
    //    bottomView.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMaxY(self.view.frame) - 35/2.0);
    bottomView.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMinY(self.view.frame) + 20 + 44 + 35/2.0);
    bottomView.tag = BOTTOM_VIEW_TAG;
    bottomView.backgroundColor = [UIColor colorWithRed:0.768 green:0.868 blue:0.924 alpha:1.000];
    [self.view addSubview:bottomView];
    [bottomView release];
    
    // 模拟标签栏的按钮tabBatItem
    NSArray *titles = @[@"聊天", @"发现", @"通讯录"];
    for (int index = 0 ; index < titles.count; index++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.bounds = CGRectMake(0, 0, 320/3.0, 30);
        button.center = CGPointMake(320/3.0/2.0 + 320/3.0*index, bottomView.bounds.size.height/2);
        button.tag = 100 + index;
        [button setTitle:titles[index] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:0.001 green:0.680 blue:0.002 alpha:1.000] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor colorWithRed:0.001 green:0.680 blue:0.002 alpha:1.000] forState:UIControlStateSelected];
        if (0 == index)
        {
            button.selected = YES;
            _selectedButton = button;
        }
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:button];
    }
    
    // 模拟选中效果(文本下面的一条线)
    UILabel *label = [[UILabel alloc] init];
    label.bounds = CGRectMake(0, 0, 320/3.0/2, 2);
    label.center = CGPointMake(320/3.0/2.0, bottomView.frame.size.height - 1);
    label.tag = LABEL_TAG;
    label.backgroundColor = [UIColor colorWithRed:0.001 green:0.680 blue:0.002 alpha:1.000];
    [bottomView addSubview:label];
    [label release];
}

- (void)buttonClicked:(UIButton *)sender
{
    // 切换选中文本颜色
    self.selectedIndex = sender.tag - 100;
    UIButton *button = (UIButton *)[self.view viewWithTag:sender.tag];
    button.selected = YES;
    _selectedButton.selected = NO;
    _selectedButton = button;
    
    // 获取底图
    UIView *bottomView = (UIView *)[self.view viewWithTag:BOTTOM_VIEW_TAG];
    // 选中横线动画效果
    UILabel *indicatorLabel = (UILabel *)[self.view viewWithTag:LABEL_TAG];
    // 设置动画效果
    [UIView animateWithDuration:0.3f animations:^{
        indicatorLabel.center = CGPointMake(320/3.0/2.0 + 320/3.0*(sender.tag - 100), bottomView.frame.size.height - 1);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_selectedButton release];
    [super dealloc];
}

- (void)showTabBar
{
    UIView *bottomView = (UIView *)[self.view viewWithTag:BOTTOM_VIEW_TAG];
//    bottomView.hidden = NO;
    /*
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDelay:0.05f];
//    bottomView.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMinY(self.view.frame) + 20 + 44 + 35/2.0);
//    [UIView commitAnimations];
     */
    [UIView animateWithDuration:0.35f animations:^{
        bottomView.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMinY(self.view.frame) + 20 + 44 + 35/2.0);
    }];
}

- (void)hiddenTabBar;
{
    UIView *bottomView = (UIView *)[self.view viewWithTag:BOTTOM_VIEW_TAG];
//    bottomView.hidden = YES;
    /*
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDelay:0.15f];
//    bottomView.center = CGPointMake(-CGRectGetMidX(self.view.frame), CGRectGetMinY(self.view.frame) + 20 + 44 + 35/2.0);
//    [UIView commitAnimations];
    */
    [UIView animateWithDuration:0.1f animations:^{
        bottomView.center = CGPointMake(-CGRectGetMidX(self.view.frame), CGRectGetMinY(self.view.frame) + 20 + 44 + 35/2.0);
    }];
}

@end