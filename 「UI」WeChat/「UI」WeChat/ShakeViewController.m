//
//  ShakeViewController.m
//  「UI」WeChat
//
//  Created by cuan on 14-2-4.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "ShakeViewController.h"

@interface ShakeViewController ()

@end

@implementation ShakeViewController

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
	self.view.backgroundColor = [UIColor cyanColor];
    [self customTitleViewWithText:self.title];
}


@end
