//
//  DetailViewController.m
//  「UI」标签控制器(day09)
//
//  Created by 萧川 on 14-2-17.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "DetailViewController.h"
#import "UIColor+Expand.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        self.title = @"DetailViewController";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor specialRandomColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.frame];
    label.font = [UIFont systemFontOfSize:24.0f];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = self.title;
    [self.view addSubview:label];
    [label release];

}


@end
