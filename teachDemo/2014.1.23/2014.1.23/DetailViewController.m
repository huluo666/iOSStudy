//
//  DetailViewController.m
//  2014.1.23
//
//  Created by 张鹏 on 14-1-23.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

- (void)initializeUserInterface;

- (void)buttonPressed:(UIButton *)sender;
- (void)processControl:(UIControl *)sender;

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initializeUserInterface];
}

- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeSystem];
    nextButton.bounds = CGRectMake(0, 0, 80, 30);
    nextButton.center = CGPointMake(CGRectGetMaxX(self.view.bounds) - 20 - CGRectGetMidX(nextButton.bounds), CGRectGetMinY(self.view.bounds) + 20 + CGRectGetMidY(nextButton.bounds));
    [nextButton setTitle:@"上一页" forState:UIControlStateNormal];
    [nextButton addTarget:self
                   action:@selector(buttonPressed:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    
    
    // 开关
    UISwitch *switchControl = [[UISwitch alloc] initWithFrame:CGRectMake(120, 50, 80, 30)];
    // 主色调
    switchControl.tintColor = [UIColor grayColor];
    // 开启颜色
    switchControl.onTintColor = [UIColor redColor];
    // 开关按钮颜色
    switchControl.thumbTintColor = [UIColor blackColor];
    
//    switchControl.backgroundColor = [UIColor greenColor];

    // 设置开关是否开启，默认NO
//    switchControl.on = YES;
    [switchControl addTarget:self
                      action:@selector(processControl:)
            forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:switchControl];
    [switchControl release];
    
    
    // 滑条 UISlider
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(80, 100, 200, 30)];
    // 设置当前值
    slider.value = 0.5;
    // 设置最小值
    slider.minimumValue = 0.2;
    // 设置最大值
    slider.maximumValue = 1.0;
    // 设置最小进度指示色
    slider.minimumTrackTintColor = [UIColor redColor];
    // 设置最大进度指示色
    slider.maximumTrackTintColor = [UIColor blueColor];
    // 设置是否持续调用自身valueChange事件
    slider.continuous = YES;
    [slider addTarget:self
               action:@selector(processControl:)
     forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    [slider release];
    
    self.view.alpha = slider.value;
    
    
    // 进度条
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(80, 150, 200, 30)];
    // 设置当前进度值，0.0 － 1.0
    progressView.progress = slider.value;
    progressView.progressTintColor = [UIColor redColor];
    progressView.trackTintColor = [UIColor blueColor];
    progressView.tag = 20;
    [self.view addSubview:progressView];
    [progressView release];
    
    // 分段控件
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"白", @"红", @"绿", @"蓝"]];
    segmentedControl.bounds = CGRectMake(0, 0, 200, 30);
    segmentedControl.center = CGPointMake(160, 240);
    // 设置当前选中的按钮索引
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = [UIColor blackColor];
    [segmentedControl addTarget:self
                         action:@selector(processControl:)
               forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
    [segmentedControl release];
    
    
    // 进度指示器
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicatorView.bounds = CGRectMake(0, 0, 30, 30);
    indicatorView.center = CGPointMake(160, 300);
    // 设置进度指示器动画停止后是否显示，默认YES
    indicatorView.hidesWhenStopped = YES;
    indicatorView.tag = 21;
    [self.view addSubview:indicatorView];
    [indicatorView release];
    
    [indicatorView startAnimating];
}

- (void)buttonPressed:(UIButton *)sender {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)processControl:(UIControl *)sender {
    
    // 开关UISwitch
    if ([sender isKindOfClass:[UISwitch class]]) {
        UISwitch *switchControl = (UISwitch *)sender;
        self.view.backgroundColor = switchControl.isOn ? switchControl.onTintColor : [UIColor whiteColor];
        
        UIActivityIndicatorView *indicatorView = (UIActivityIndicatorView *)[self.view viewWithTag:21];
        if (switchControl.isOn) {
            // 开始转动，动画
            [indicatorView stopAnimating];
        }
        else {
            [indicatorView startAnimating];
        }
        
    }
    else if ([sender isKindOfClass:[UISlider class]]) {
        UISlider *slider = (UISlider *)sender;
        NSLog(@"slider value = %.2f", slider.value);
        self.view.alpha = slider.value;
        
        UIProgressView *progressView = (UIProgressView *)[self.view viewWithTag:20];
        progressView.progress = slider.value;
    }
    else if ([sender isKindOfClass:[UISegmentedControl class]]) {
        UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
        NSArray *colorList = @[[UIColor whiteColor], [UIColor redColor], [UIColor greenColor], [UIColor blueColor]];
        self.view.backgroundColor = [colorList objectAtIndex:segmentedControl.selectedSegmentIndex];
    }
}


@end














