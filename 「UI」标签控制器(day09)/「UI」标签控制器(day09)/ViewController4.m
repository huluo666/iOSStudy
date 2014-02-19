//
//  ViewController4.m
//  「UI」标签控制器(day09)
//
//  Created by 萧川 on 14-2-17.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "ViewController4.h"
#import "UIColor+Expand.h"

@interface ViewController4 ()

- (void)initUserInterface;

@end

@implementation ViewController4

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
	[self initUserInterface];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"Contacts";
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:100];
        self.tabBarItem = tabBarItem;
        [tabBarItem release];
    }
    return self;
}

- (void)setValue:(NSString *)value
{
    if (_value != value) {
        [_value release];
        _value = [value copy];
        
        UILabel *label = (UILabel *)[self.view viewWithTag:401];
        NSLog(@"vc4.value");
        label.text = _value;
    }
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
    
    UILabel *transValueLabel = [[UILabel alloc] init];
    transValueLabel.bounds = CGRectMake(0, 0, 220, 30);
    transValueLabel.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame) - 60);
    transValueLabel.font = [UIFont systemFontOfSize:24.0f];
    transValueLabel.textColor = [UIColor whiteColor];
    transValueLabel.textAlignment = NSTextAlignmentCenter;
    transValueLabel.tag = 401;
    transValueLabel.text = _value;
    [self.view addSubview:transValueLabel];
    [transValueLabel release];
}

@end
