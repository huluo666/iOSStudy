//
//  ViewController.m
//  「UI」MVC设计模式(day02)
//
//  Created by cuan on 14-1-22.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController

// 自定义初始化方法，用于XIB加载控制器界面的时候
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

// 控制器的视图加载完成
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSLog(@"%@", self.view);
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 320, 50)];
    NSLog(@"self.view.frame.origin.x = %f", self.view.frame.origin.x); // 0
    NSLog(@"self.view.frame.origin.y = %f", self.view.frame.origin.y); // 0
    NSLog(@"self.view.frame.size.width = %f", self.view.frame.size.width); // 320
    NSLog(@"self.view.frame.origin.height = %f", self.view.frame.size.height); //568 (4.5in)
    label.text = @"ViewController";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:28];
    [self.view addSubview:label];
    [label release];
    
    
//    // ****************************************************
//    
//    // UIView:基本试图，UILabel, UIButton, UITextField
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 134, 300, 300)];
//
//    // superview:父视图，试图需要添加在父试图上才能被显示器显示和管理
//    view.backgroundColor = [UIColor grayColor];
//    [self.view addSubview:view];
//    view.alpha = 0.5;
//
//    view.hidden = NO;
//
//    // center: 描述了相对父视图自己的中心点位置
//    NSLog(@"center: %@", NSStringFromCGPoint(view.center));
//
//    // bounds: 描述了视图相对自己的边界大小
//    NSLog(@"bounds: %@", NSStringFromCGRect(view.bounds));
//
//    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(110, 234, 100, 100)];
//    subView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:subView];
//
//    UIView *subView2 = [[UIView alloc] init];
//    subView2.bounds = CGRectMake(0, 0, 50, 50);
//    subView2.center = CGPointMake(160, 284);
//    subView2.backgroundColor = [UIColor blueColor];
//    [self.view addSubview:subView2];
//
//    [view release];
//    [subView release];
//    [subView2 release];
    
    
    // ****************************************************
    
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(5, 120, 175, 175)];
    // tag：标签，通过标签可以在当前试图的父视图中访问与标签匹配的试图, 唯一性， <10的系统占用
    grayView.tag = 10;
    grayView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:grayView];
    [grayView release];

    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(140, 250, 175, 175)];
    blueView.tag = 11;
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    [blueView release];

//    // 视图层级调整方法
//    // 把视图提前
//    [self.window bringSubviewToFront:grayView];
//
//    // 把视图延后
//    [self.window sendSubviewToBack:blueView];
//
//    // 把视图移除
//    [blueView removeFromSuperview];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.bounds = CGRectMake(0, 0, 80, 50);
    button.center = CGPointMake(CGRectGetMidX(self.view.bounds),  CGRectGetMaxY(self.view.bounds) - 100);
    [button setTitle:@"Exchange" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *detailButton = [UIButton buttonWithType:UIButtonTypeSystem];
    detailButton.bounds = CGRectMake(0, 0, 100, 50);
    detailButton.center = CGPointMake(CGRectGetMaxX(self.view.bounds) - 50, 30);
    [detailButton setTitle:@"Show Detail" forState:UIControlStateNormal];
    [detailButton addTarget:self action:@selector(showDetail:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:detailButton];
}

- (void)buttonPressed:(UIButton *)sender
{
    [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:2];
}

- (void)showDetail:(UIButton *)sender
{
    DetailViewController *detailViewControl = [[[DetailViewController alloc] init] autorelease];
    
    // 设置切换动画效果
    detailViewControl.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    // 控制器模态切换
    [self presentViewController:detailViewControl animated:YES completion:^{
        NSLog(@"Detail View Controller is show. ");
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"viewDidDisappear");
}

// 是否支持自动旋转
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

// 控制器支持设备朝向
- (BOOL)shouldAutorotate
{
    return NO;
}

// 控制器试图将要旋转到某个朝向，在方法中处理新的界面布局
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    
}

@end
