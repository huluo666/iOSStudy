//
//  NextViewController.m
//  UIDemoDay03
//
//  Created by cuan on 14-1-23.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()

- (void)initializeUserInteface;
- (IBAction)pressedPreviewPage:(UIButton *)sender;
- (IBAction)processControl:(UIControl *)sender;

@end

@implementation NextViewController

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
    
    [self initializeUserInteface];
}

- (void)initializeUserInteface
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *nextPageButton = [UIButton buttonWithType:UIButtonTypeSystem];
    nextPageButton.bounds    = CGRectMake(0, 0, 80, 50);
//    previewNextPage.center = CGPointMake(30, 40);
    nextPageButton.center    = CGPointMake(CGRectGetMinX(self.view.frame) + 30, CGRectGetMinY(self.view.frame)+ 40);
    [nextPageButton setTitle:@"上一页" forState:UIControlStateNormal];
    [nextPageButton addTarget:self action:@selector(pressedPreviewPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextPageButton];

    // 开关
//    UISwitch *switchControl      = [[UISwitch alloc] initWithFrame:CGRectMake(120, 50, 80, 30)];
    UISwitch *switchControl      = [[UISwitch alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 40, CGRectGetMinY(self.view.frame) + 55, 80, 30)];
    switchControl.tintColor      = [UIColor grayColor]; // 主色调,边框
    switchControl.onTintColor    = [UIColor redColor]; // 开启后颜色
    switchControl.thumbTintColor = [UIColor blackColor]; // 开关按钮颜色
//    switchControl.on             = YES; // 默认开启
    [switchControl addTarget:self action:@selector(processControl:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:switchControl];
    [switchControl release];
    
    // 滑条
//    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(80, 100, 200, 30)];
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 100, CGRectGetMaxY(switchControl.frame) + 20, 200, 30)];
    [self.view addSubview:slider];
    slider.value                 = 0.5;
    slider.minimumValue          = 0.2; // 最小值
    slider.maximumValue          = 1.0; // 最大值
    slider.minimumTrackTintColor = [UIColor redColor]; // 滑条最小进度指示色
    slider.maximumTrackTintColor = [UIColor grayColor]; // 滑条最大进度指示色
    slider.continuous            = NO; //是否持续调用事件方法
    self.view.alpha              = slider.value;
    [slider addTarget:self action:@selector(processControl:) forControlEvents:UIControlEventValueChanged];
    [slider release];
    
    // 进度条
//    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(80, 150, 200, 30)];
    UIProgressView *progressView   = [[UIProgressView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 100, CGRectGetMaxY(slider.frame) + 20, 200, 30)];
    progressView.tag               = 20;
    progressView.progress          = slider.value;
    progressView.progressTintColor = [UIColor redColor];
    progressView.trackTintColor    = [UIColor grayColor];
    [self.view addSubview:progressView];
    [progressView release];
    
    // 分段控件
    UISegmentedControl *segmentedControl  = [[UISegmentedControl alloc] initWithItems:@[@"白", @"红", @"绿", @"蓝"]];
    segmentedControl.bounds               = CGRectMake(0, 0, 200, 30);
    segmentedControl.center               = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMaxY(progressView.frame) + 40);
    segmentedControl.selectedSegmentIndex = 0; // 当前默认选中的按钮索引
    segmentedControl.tintColor            = [UIColor blackColor];
    [segmentedControl addTarget:self action:@selector(processControl:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
    [segmentedControl release];
    
    // 进度指示器
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicatorView.bounds           = CGRectMake(0, 0, 40, 40);
    activityIndicatorView.center           = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMaxY(segmentedControl.frame) + 30);
//    activityIndicatorView.hidesWhenStopped = NO; // 进度指示器动画停止后是否显示，默认是YES
    
    activityIndicatorView.tag              = 21;
    [self.view addSubview:activityIndicatorView];
    [activityIndicatorView release];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, 254, 200, 60)];
    label.text     = @"This is the next page";
    [self.view addSubview:label];
    [label release];
}

- (IBAction)pressedPreviewPage:(UIButton *)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        NSLog(@"切换到上一页");
    }];
}

- (IBAction)processControl:(UIControl *)sender
{
    if ([sender isKindOfClass:[UISwitch class]])
    {
        UISwitch *switchControl   = (UISwitch *)sender;
        self.view.backgroundColor = switchControl.isOn ? switchControl.onTintColor : [UIColor whiteColor];
        
        UIActivityIndicatorView *activityIndicatorView = (UIActivityIndicatorView *)[self.view viewWithTag:21];
        if (switchControl.isOn)
        {
            [activityIndicatorView stopAnimating];
        }
        else
        {
            [activityIndicatorView startAnimating];
        }
    }
    else if ([sender isKindOfClass:[UISlider class]])
    {
        UISlider *slider = (UISlider *)sender;
        NSLog(@"slider value = % .2f", slider.value);
        self.view.alpha  = slider.value;
        
        UIProgressView *progressView = (UIProgressView *)[self.view viewWithTag:20];
        progressView.progress        = slider.value;
    }
    else if ([sender isKindOfClass:[UISegmentedControl class]])
    {
        UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
        NSArray *colorList                   = @[[UIColor whiteColor], [UIColor redColor], [UIColor greenColor], [UIColor blueColor]];
        self.view.backgroundColor            = colorList[segmentedControl.selectedSegmentIndex];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
