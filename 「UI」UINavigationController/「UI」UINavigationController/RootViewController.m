//
//  RootViewController.m
//  「UI」UINavigationController
//
//  Created by cuan on 14-1-29.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"

@interface RootViewController ()

- (void)initializationUserInterface;
- (void)buttonPressed;
- (void)itemClicked:(UIBarButtonItem *)item;

@end


@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializationUserInterface];
}

- (void)initializationUserInterface
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"self.view.frame.origin.y = %f", self.view.frame.origin.y);
    NSLog(@"super.view.frame.origin.y = %f", super.view.frame.origin.y);
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeSystem];
    nextButton.bounds = CGRectMake(0, 0, 300, 40);
    nextButton.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMaxY(self.navigationController.navigationBar.frame) + 40);
    [nextButton setTitle:@"下一页" forState:UIControlStateNormal];
    nextButton.backgroundColor = [UIColor cyanColor];
    [nextButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
  
#pragma mark navigationBar 导航条
    
    // 设置导航条样式风格
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    // 只有barStyle为黑色半透明时背景颜色才有效果，
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:1.000 green:0.800 blue:0.529 alpha:1.000];
    // 设置背景图片，IOS5以后支持。(UIBarMetrics)，ip模式，横屏竖屏
//    [self.navigationController.navigationBar setBackgroundImage:<#(UIImage *)#> forBarMetrics:(UIBarMetrics)]
    // 导航条的自动裁剪属性,将背景图片超出部分裁剪
//    self.navigationController.navigationBar.clipsToBounds = YES;
    
    // 隐藏导航栏, 被隐藏后视图控制器的视图会自动上移44
//    self.navigationController.navigationBarHidden = YES;
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    
    // 设置导航条标题
    [self.navigationItem setTitle:@"RootViewController"];
  
#pragma mark navigationItem

    // 设置导航条左侧按钮
    UIBarButtonItem *itemLeft = [[UIBarButtonItem alloc] initWithTitle:@"首页" style:UIBarButtonItemStylePlain target:self action:@selector(itemClicked:)];
    self.navigationItem.leftBarButtonItem = itemLeft;
    [itemLeft release];
    
    // 数组中的元素都是BarButtonItem的实例
//    self.navigationItem.leftBarButtonItems
   
#pragma mark toolBar 工具栏
    
    // 显示toolBar
//    self.navigationController.toolbarHidden = NO;
    [self.navigationController setToolbarHidden:NO animated:YES];
    self.navigationController.toolbar.backgroundColor = [UIColor purpleColor];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(itemClicked:)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(itemClicked:)];
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(itemClicked:)];
    // item之间的间隔
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:@selector(itemClicked:)];
    
    // 通过toolbarItems来定制工具栏的显示，数组中放的是UIBarButtonItem实例
    self.toolbarItems = [NSArray arrayWithObjects:item1, flexibleSpace, item2, flexibleSpace, item3, nil];

#pragma mark UINavigationController的正向和反向传值
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button1.bounds = CGRectMake(0, 0, 300, 40);
    button1.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMaxY(nextButton.frame) + 40);
    
    [button1 setTitle:@"正向传值按钮" forState:UIControlStateNormal];
    button1.layer.borderWidth = 1.0f;
    button1.layer.borderColor = [UIColor greenColor].CGColor;
    [button1 addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
}

- (void)itemClicked:(UIBarButtonItem *)item
{
    [self.view setBackgroundColor:[UIColor greenColor]];
}

- (void)buttonPressed
{
    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    // 指定代理,用于反向传值
    detailViewController.delegate = self;
    
    // 指定属性值，用于正向传值
    detailViewController.currentTitle = self.navigationItem.title;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}

#pragma mark - <SendValue>

- (void)sendButtonTitle:(NSString *)title
{
    self.navigationItem.title = title;
}


@end
