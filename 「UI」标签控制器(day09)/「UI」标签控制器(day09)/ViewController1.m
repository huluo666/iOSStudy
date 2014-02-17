//
//  ViewController1.m
//  「UI」标签控制器(day09)
//
//  Created by 萧川 on 14-2-17.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "ViewController1.h"
#import "UIColor+Expand.h"

@interface ViewController1 ()

- (void)initUserInterface;

@end

@implementation ViewController1

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"Bookmarks";
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:100];
        self.tabBarItem = tabBarItem;
        [tabBarItem release];
        
        self.tabBarItem.badgeValue = @"99+";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self initUserInterface];
}

- (void)initUserInterface
{
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
