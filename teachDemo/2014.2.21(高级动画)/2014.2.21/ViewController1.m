//
//  ViewController1.m
//  2014.2.21
//
//  Created by 张鹏 on 14-2-21.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "ViewController1.h"

@interface ViewController1 ()

- (void)initializeUserInterface;

@end

@implementation ViewController1

- (id)init
{
    self = [super init];
    if (self) {
        
        self.title = NSStringFromClass([self class]);
        
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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.text = @"Animation";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:40];
    [self.view addSubview:label];
    [label release];
    
    // 自定义按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 150, 150);
    button.center = CGPointMake(CGRectGetMidX(self.view.bounds),
                                CGRectGetMidY(self.view.bounds));
    button.backgroundColor = [UIColor redColor];
    // 图层属性
    // CALayer为UIView提供显示支持
    // 配置视图圆角半径
    button.layer.cornerRadius = 75;
    // 配置边框颜色
    button.layer.borderColor = [UIColor blueColor].CGColor;
    // 配置边框宽度
    button.layer.borderWidth = 5;
    // 配置阴影色
    button.layer.shadowColor = [UIColor blackColor].CGColor;
    // 配置阴影不透明度，默认值0
    button.layer.shadowOpacity = 0.5;
    // 配置阴影偏移量
    button.layer.shadowOffset = CGSizeMake(-50, 50);
//    [self.view addSubview:button];
}

@end















