//
//  ViewController4.m
//  2014.2.17
//
//  Created by 张鹏 on 14-2-17.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "ViewController4.h"

@interface ViewController4 ()

- (void)initializeUserInterface;

@end

@implementation ViewController4

- (id)init
{
    self = [super init];
    if (self) {
        
        self.title = @"Downloads";
        // 配置标签栏按钮
        UITabBarItem *tabBarItem = [[UITabBarItem alloc]
                                    initWithTabBarSystemItem:UITabBarSystemItemDownloads
                                    tag:3];
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

- (void)setValue:(NSString *)value {
    
    if (_value != value) {
        [_value release];
        _value = [value copy];
        
        [(UILabel *)[self.view viewWithTag:20] setText:_value];
    }
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
    
    UILabel *valueDisplay = [[UILabel alloc] init];
    valueDisplay.bounds = CGRectMake(0, 0, 200, 44);
    valueDisplay.center = CGPointMake(CGRectGetMidX(self.view.bounds), 200);
    valueDisplay.textAlignment = NSTextAlignmentCenter;
    valueDisplay.textColor = [UIColor whiteColor];
    valueDisplay.font = [UIFont systemFontOfSize:20];
    valueDisplay.backgroundColor = [UIColor clearColor];
    valueDisplay.tag = 20;
    [self.view addSubview:valueDisplay];
    [valueDisplay release];

}

@end









