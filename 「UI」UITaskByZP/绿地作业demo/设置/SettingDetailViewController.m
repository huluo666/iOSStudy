//
//  SettingDetailViewController.m
//  绿地作业demo
//
//  Created by 张鹏 on 14-2-15.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "SettingDetailViewController.h"

@interface SettingDetailViewController ()

- (void)initializeUserInterface;
- (void)buttonPressed:(UIButton *)sender;

@end

@implementation SettingDetailViewController

- (id)initWithItemName:(NSString *)item {
    
    self = [super init];
    if (self) {
        
        self.title = item;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initializeUserInterface];
}

- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backS.png"]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.text = self.title;
    label.textColor = [UIColor colorWithWhite:1.0 alpha:0.8];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:30];
    [self.view addSubview:label];
    [label release];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.bounds = CGRectMake(0, 0, 70, 30);
    backButton.center = CGPointMake(CGRectGetMinX(self.view.bounds) + 20 + CGRectGetMidX(backButton.bounds),
                                    CGRectGetMinY(self.view.bounds) + 40 + CGRectGetMidY(backButton.bounds));
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.8] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:15];
    backButton.layer.borderWidth = 1.5;
    backButton.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:0.8].CGColor;
    [backButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}

- (void)buttonPressed:(UIButton *)sender {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    
    return UIStatusBarAnimationFade;
}

@end
