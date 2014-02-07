//
//  FriendsCricleViewController.m
//  「UI」WeChat
//
//  Created by cuan on 14-2-4.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "FriendsCricleViewController.h"

@interface FriendsCricleViewController ()

@end

@implementation FriendsCricleViewController

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
    self.view.backgroundColor = [UIColor greenColor];
    [self customTitleViewWithText:self.title]; // 自定义titleView

}

@end
