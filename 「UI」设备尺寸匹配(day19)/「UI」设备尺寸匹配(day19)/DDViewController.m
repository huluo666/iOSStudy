//
//  DDViewController.m
//  「UI」设备尺寸匹配(day19)
//
//  Created by 萧川 on 14-3-6.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDViewController.h"
#import "DDCustomView.h"

#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width

@interface DDViewController ()
{
    NSDictionary *_dataSource;
}

- (void)initializeDataSource;
- (void)initializeUserInterface;

@end

@implementation DDViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)initializeDataSource
{
    NSString *filePath = [[NSBundle mainBundle] pathForAuxiliaryExecutable:@"information.plist"];
    _dataSource = [NSDictionary dictionaryWithContentsOfFile:filePath];
}

- (void)initializeUserInterface
{
//    self.view.backgroundColor = [UIColor whiteColor];
//    
//    CGRect bounds = self.view.bounds;
//    NSLog(@"%@", NSStringFromCGRect(bounds));
//    
//    UIView *view = [[UIView alloc] init];
//    view.bounds = CGRectMake(0, 0, 200, kScreenHeight - 100);
////    view.center = CGPointMake(160, bounds.size.height - 100);
////    view.center = CGPointMake(160, [[UIScreen mainScreen] bounds].size.height - 100);
//    view.center = CGPointMake(160, kScreenHeight - CGRectGetMidY(view.bounds));
//    view.backgroundColor = [UIColor orangeColor];
//    [self.view addSubview:view];
    
    UIButton *jobsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    jobsButton.bounds = CGRectMake(0, 0, 150, 150);
    jobsButton.center = CGPointMake(self.view.center.x / 2, self.view.center.y);
    jobsButton.tag = 11;
    [jobsButton setBackgroundImage:[UIImage imageNamed:@"Steve Jobs"]
                          forState:UIControlStateNormal];
    [jobsButton addTarget:self action:@selector(processPressed:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jobsButton];
    
    UIButton *cookButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cookButton.bounds = CGRectMake(0, 0, 150, 150);
    cookButton.center = CGPointMake(self.view.center.x / 2 * 3, self.view.center.y);
    cookButton.tag = 12;
    [cookButton setBackgroundImage:[UIImage imageNamed:@"Tim Cook"]
                          forState:UIControlStateNormal];
    [cookButton addTarget:self action:@selector(processPressed:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cookButton];
}

- (void)processPressed:(UIButton *)sender
{
    NSInteger index = sender.tag - 10;
    NSDictionary *dict = index == 0 ? _dataSource[@"Steve Jobs"] : _dataSource[@"Tim Cook"];
    DDCustomView *customView = [[DDCustomView alloc] initWithFrame:self.view.frame infoDict:dict];
    [self.view addSubview:customView];
}

@end
