//
//  DeatilInfoViewController.m
//  UITask
//
//  Created by 萧川 on 14-2-14.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "DeatilInfoViewController.h"

@interface DeatilInfoViewController ()

@property (retain, nonatomic) NSString *explain;

- (void)initUserInterface;
- (void)backButtonPressed;

@end

@implementation DeatilInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithExplain:(NSString *)explain
{
    if (self = [super init]) {
        self.explain = explain;
    }
    
    return self;
}

- (void)dealloc
{
    [_explain release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self initUserInterface];
}

- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backS"]];
    
    UILabel *explainLabel =  [[UILabel alloc] initWithFrame:self.view.frame];
    explainLabel.text = _explain;
    explainLabel.textAlignment = NSTextAlignmentCenter;
    explainLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:explainLabel];
    [explainLabel release];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(20, 50, 80, 30);
    backButton.layer.borderColor = [UIColor greenColor].CGColor;
    backButton.layer.borderWidth = 1.0f;
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}

- (void)backButtonPressed
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
