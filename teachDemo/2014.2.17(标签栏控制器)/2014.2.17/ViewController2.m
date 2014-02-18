//
//  ViewController2.m
//  2014.2.17
//
//  Created by 张鹏 on 14-2-17.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()

- (void)initializeUserInterface;

@end

@implementation ViewController2

- (id)init
{
    self = [super init];
    if (self) {
        
        self.title = @"Contacts";
        // 配置标签栏按钮
        UITabBarItem *tabBarItem = [[UITabBarItem alloc]
                                    initWithTabBarSystemItem:UITabBarSystemItemContacts
                                    tag:1];
        self.tabBarItem = tabBarItem;
        [tabBarItem release];
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
    
    self.view.backgroundColor = [UIColor specialRandomColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.text = self.title;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:30];
    label.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label];
    [label release];
}

@end
