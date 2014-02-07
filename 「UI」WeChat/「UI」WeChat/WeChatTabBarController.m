//
//  ReTabBarViewController.m
//  「UI」WeChat
//
//  Created by cuan on 14-2-1.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "WeChatTabBarController.h"
#import "ChatListViewController.h"
#import "ContactsListViewController.h"
#import "FindListViewController.h"
#import "BaseNavigationController.h"
#import "UIViewController+SettingDecoilClose.h"

@interface WeChatTabBarController ()

@property (retain, nonatomic) UIButton *selectedButton;

- (void)initControllers;
- (void)loadCustomTabBar;

@end

@implementation WeChatTabBarController

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
    
//    [self loadSettingView];
}

// 初始化各标签项的导航控制器
- (void)initControllers
{
    
#pragma mark 使用自定义的导航控制器样式
    
    ChatListViewController *chatVC = [[ChatListViewController alloc] init];
    chatVC.delegate = self;
    UINavigationController *chatNavi = [[UINavigationController alloc] initWithRootViewController:chatVC];
//    BaseNavigationController *chatNavi = [[BaseNavigationController alloc] initWithRootViewController:chatVC];
    [chatVC release];
    
    FindListViewController *findVC = [[FindListViewController alloc] init];
    findVC.delegate = self; 
    BaseNavigationController *findNavi = [[BaseNavigationController alloc] initWithRootViewController:findVC];
    [findVC release];
    
    ContactsListViewController *contactsVc = [[ContactsListViewController alloc] init];
    contactsVc.delegate = self;
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
    NSArray *titles = @[CHAT, FIND, CONTACTS];
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

#pragma mark 代理方法 <MianVCDelegate>
- (void)mainUIViewCotrollerFatherShowSettingTableView:(MainUIViewControllerFather *)mainVCfather
{
    /*
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, 320, 568);
    view.tag = SETTING_TABLE_BG_VIEW_TAG;
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
    [view release];
    
    UITableView *settingTV = [[UITableView alloc] initWithFrame:CGRectMake(320 - 150, 20 + 44, 150, 264) style:UITableViewStylePlain];
    settingTV.tag = SETTING_TABLE_VIEW_TAG;
    settingTV.backgroundColor = [UIColor colorWithRed:0.434 green:0.451 blue:0.471 alpha:1.000];
//    settingTV.dataSource = self;
//    settingTV.delegate = self;
    [self.view addSubview:settingTV];
    [settingTV release];
    */
    
    // 类别方法
    [self settingDecoilCloseWithFrame:CGRectMake(320 - 150, 20 + 44, 150, 264) color:[UIColor colorWithRed:0.434 green:0.451 blue:0.471 alpha:1.000] tableViewDataSource:nil tableViewDalegate:nil forViewController:self];
}

/*
#pragma mark 监听器方法
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIView *view = (UIView *)[self.view viewWithTag:SETTING_TABLE_BG_VIEW_TAG];
    if (view)
    {
        [view removeFromSuperview];
    }
    
    UITableView *settingTV = (UITableView *)[self.view viewWithTag:SETTING_TABLE_VIEW_TAG];
    if (settingTV)
    {
        [settingTV removeFromSuperview];
    }
}
*/
@end