//
//  ViewController.m
//  2014.3.6
//
//  Created by 张鹏 on 14-3-6.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"

// 获取设备屏幕宽度
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
// 获取设备屏幕高度
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface ViewController () {
    
    NSDictionary *_dataSource;
}

- (void)initializeDataSource;
- (void)initializeUserInterface;
- (void)buttonPressed:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)initializeDataSource {
    
    NSString *filePath = [[NSBundle mainBundle] pathForAuxiliaryExecutable:@"Information.plist"];
    _dataSource = [NSDictionary dictionaryWithContentsOfFile:filePath];
}

- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect bounds = self.view.bounds;
    NSLog(@"%@", NSStringFromCGRect(bounds));
    
    UIButton *jobsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    jobsButton.bounds = CGRectMake(0, 0, 120, 120);
    jobsButton.center = CGPointMake(CGRectGetMidX(bounds) - 70, CGRectGetMidY(bounds));
    [jobsButton setBackgroundImage:[UIImage imageNamed:@"Steve Jobs.png"] forState:UIControlStateNormal];
    [jobsButton addTarget:self
                   action:@selector(buttonPressed:)
         forControlEvents:UIControlEventTouchUpInside];
    jobsButton.tag = 10;
    [self.view addSubview:jobsButton];
    
    UIButton *cookButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cookButton.bounds = CGRectMake(0, 0, 120, 120);
    cookButton.center = CGPointMake(CGRectGetMidX(bounds) + 70, CGRectGetMidY(bounds));
    [cookButton setBackgroundImage:[UIImage imageNamed:@"Tim Cook.png"] forState:UIControlStateNormal];
    [cookButton addTarget:self
                   action:@selector(buttonPressed:)
         forControlEvents:UIControlEventTouchUpInside];
    cookButton.tag = 11;
    [self.view addSubview:cookButton];
}

- (void)buttonPressed:(UIButton *)sender {
    
    NSInteger index = sender.tag - 10;
    NSDictionary *infoDict = nil;
    infoDict = index == 0 ? _dataSource[@"Steve Jobs"] : _dataSource[@"Tim Cook"];
    CustomView *view = [[CustomView alloc] initWithFrame:self.view.bounds
                                                infoDict:infoDict];
    [self.view addSubview:view];
}

@end


















