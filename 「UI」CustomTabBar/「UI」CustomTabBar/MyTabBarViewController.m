//
//  MyTabBarViewController.m
//  「UI」CustomTabBar
//
//  Created by cuan on 14-1-30.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "MyTabBarViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"

@interface MyTabBarViewController ()

@property (retain, nonatomic) UIButton *currentSelectedButton;

- (void)createCustomTabBar;
- (void)btnClocked:(UIButton *)btn;
- (void)createControllers;

@end

@implementation MyTabBarViewController

- (void)dealloc
{
    [_currentSelectedButton release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBar.hidden = YES;
    [self createControllers];
    [self createCustomTabBar];
}

- (void)createCustomTabBar
{
    // 创建一个UIImageView作为底图
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.frame = CGRectMake(0, 568 - 49, 320, 49);
//    bgView.frame = CGRectMake(0, 20, 320, 49);
    bgView.image = [UIImage imageNamed:@"tabBar.png"];
    bgView.userInteractionEnabled = YES;
    bgView.tag = 999;
    [self.view addSubview:bgView];
    [bgView release];
    
    NSArray *titles = @[@"聊天", @"发现", @"通讯录", @"更多"];
    
    // 创建button实例模拟tabBarItem
    for (int i = 0; i < 4; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
//        NSString *img = [NSString stringWithFormat:@"%d.png", i + 1];
//        NSString *imgSel = [NSString stringWithFormat:@"%d.s.png", i + 1];
//        [btn setBackgroundImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
//        [btn setBackgroundImage:[UIImage imageNamed:imgSel] forState:UIControlStateSelected];
        
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        btn.bounds = CGRectMake(0, 0, 60, 30);
        btn.center = CGPointMake(40 + 80 * i, 49 / 2);
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(btnClocked:) forControlEvents:UIControlEventTouchUpInside];
        if (0 == i)
        {
            btn.selected = YES;
            self.currentSelectedButton = btn;
        }
        [bgView addSubview:btn];
    }
    
    // 创建一个UILabel的实例, 作为指示条
    UILabel *indicatorLabel = [[UILabel alloc] init];
    indicatorLabel.bounds = CGRectMake(0, 0, 30, 2);
    indicatorLabel.center = CGPointMake(40, 46);
    indicatorLabel.backgroundColor = [UIColor redColor];
    indicatorLabel.tag = 333;
    [bgView addSubview:indicatorLabel];
}

- (void)btnClocked:(UIButton *)btn
{
    // 点击不同按钮，切换不同的视图控制器
    self.selectedIndex = btn.tag - 100;
    
    // 切换不同btn的显示状态
    UIImageView *bgView = (UIImageView *)[self.view viewWithTag:999];
    for (UIView *subView in bgView.subviews)
    {
        if ([subView isKindOfClass:[UIButton class]])
        {
            UIButton *button = (UIButton *)btn;
            if (button.tag == btn.tag)
            {
                _currentSelectedButton.selected = NO;
                btn.selected = YES;
                self.currentSelectedButton = btn;
                
                // 根据点击的button，改变label的横坐标
                UILabel *indicatorLabel = (UILabel *)[bgView viewWithTag:333];
                // 设置动画效果
                [UIView animateWithDuration:0.3f animations:^{
                    indicatorLabel.center = CGPointMake((btn.tag - 100) * 80 + 40, 46);
                }];
            
                // 上面一种更好，可以自己控制时间
//                [UIView beginAnimations:nil context:nil];
//                indicatorLabel.center = CGPointMake((btn.tag - 100) * 80 + 40, 46);
//                [UIView commitAnimations];
            }
            else
            {
                btn.selected = NO;
            }
        }
    }
    
}


- (void)createControllers
{
    FirstViewController *first = [[FirstViewController alloc] init];
//    first.title = @"界面一";
//    first.tabBarItem.image = [UIImage imageNamed:@"1.png"];
    
    SecondViewController *second = [[SecondViewController alloc] init];
//    second.title = @"界面二";
//    second.tabBarItem.image = [UIImage imageNamed:@"2.png"];
    
    ThirdViewController *third = [[ThirdViewController alloc] init];
//    third.title = @"界面三";
//    third.tabBarItem.image = [UIImage imageNamed:@"3.png"];
    
    FourthViewController *fourth = [[FourthViewController alloc] init];
//    fourth.title = @"界面四";
//    fourth.tabBarItem.image = [UIImage imageNamed:@"4.png"];
    
    NSArray *controllers = @[first, second, third, fourth];
    
    [first release];
    [second release];
    [third release];
    [fourth release];
    
    self.viewControllers = controllers;
}
@end
