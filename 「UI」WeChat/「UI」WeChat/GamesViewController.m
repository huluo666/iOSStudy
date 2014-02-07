//
//  GamesViewController.m
//  「UI」WeChat
//
//  Created by cuan on 14-2-4.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "GamesViewController.h"

@interface GamesViewController ()

@end

@implementation GamesViewController

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
	self.view.backgroundColor = [UIColor orangeColor];
    [self customTitleViewWithText:self.title];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
