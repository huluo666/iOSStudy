//
//  FirstViewController.m
//  「UI」TabBar、Navi联合
//
//  Created by cuan on 14-1-31.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "ChatController.h"
#import "ChatDetailViewController.h"

@interface ChatController ()

@end

@implementation ChatController

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
	// Do any additional setup after loading the view.
    
    UIButton *pushButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [pushButton setCenter:CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMinY(self.view.frame) + 50 + 49)];
    [pushButton setBounds:CGRectMake(0, 0, 320, 40)];
    pushButton.layer.borderWidth = 1.0f;
    pushButton.layer.borderColor = [UIColor greenColor].CGColor;
    [pushButton setTitle:@"PUSH" forState:UIControlStateNormal];
    [pushButton addTarget:self action:@selector(pushButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushButton];
    
    self.navigationItem.title = @"聊天";
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:nil] autorelease];

}

- (void)pushButtonPressed
{
    NSLog(@"PUSH");
    ChatDetailViewController *firstDVC = [[ChatDetailViewController alloc] init];
    [self.navigationController pushViewController:firstDVC animated:YES];
    [firstDVC release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
