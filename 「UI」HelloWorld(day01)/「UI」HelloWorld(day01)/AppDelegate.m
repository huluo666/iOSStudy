//
//  AppDelegate.m
//  「UI」HelloWorld(day01)
//
//  Created by cuan on 14-1-21.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)dealloc
{
    [_textField release];
    [_label release];
    [_window release];
    [super dealloc];
}

#pragma mark 程序加载完成,自定义界面加载，数据导入，初始化等
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    _cmd 代表当前方法的选择器
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    // bounds: 边界大小
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // 设置背景色
    self.window.backgroundColor = [UIColor whiteColor];
    // 将window作为程序当前激活并显示的窗口，keywindow
    [self.window makeKeyAndVisible];
    
    // UIWindowLevel：用来描述窗口级别的，级别高的会覆盖级别低的窗口
    // appDelegate中默认的窗口级别是UIWindowLevelNormal
//    NSLog(@"%.2f, %.2f, %.2f, %.2f", self.window.windowLevel, UIWindowLevelAlert, UIWindowLevelNormal, UIWindowLevelStatusBar);

    _label                 = [[UILabel alloc] initWithFrame:CGRectMake(85, 20, 150, 50)];
    _label.text            = @"Hellow, world!";
    _label.textColor       = [UIColor blackColor];
    _label.font            = [UIFont systemFontOfSize:20];
    _label.backgroundColor = [UIColor clearColor];
    _label.textAlignment   = NSTextAlignmentCenter;
    // 当一个视图添加到另一个试图之上时，被添加的试图会被持有
    [self.window addSubview:_label];
    [_label release];

    _textField                 = [[UITextField alloc] initWithFrame:CGRectMake(60, _label.frame.origin.y + _label.frame.size.height + 20, 200, 30)];
    _textField.backgroundColor = [UIColor colorWithWhite:0.879 alpha:1.000];
    _textField.borderStyle     = UITextBorderStyleRoundedRect;
    _textField.placeholder     = @"请输入文本";
    [self.window addSubview:_textField];
    [_textField release];
    
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(110, CGRectGetMaxY(textField.frame)+50, 100, 30)];
//    button.backgroundColor = [UIColor colorWithRed:0.314 green:0.706 blue:0.523 alpha:1.000];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    // 设置边界大小
    button.bounds = CGRectMake(0, 0, 100, 30);
    // 设置位置
    button.center = CGPointMake(160, CGRectGetMaxY(_textField.frame)+50);
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setTitle:@"高亮" forState:UIControlStateHighlighted];
    // 关联按钮事件
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.window addSubview:button];
    return YES;
}

- (void)buttonPressed:(UIButton *)sender
{
//    NSLog(@"%@", NSStringFromSelector(_cmd));
//    NSLog(@"%@", sender.currentTitle);
    
    // 关闭键盘
    [_textField resignFirstResponder];
    
    // 获取UITextField的文本
    NSString *text = _textField.text;
    // 判断文本有效
    if (!text || text.length == 0)
    {
        return ;
    }
    // 给UILabel赋值文本内容
    _label.text = text;
    
    
}

#pragma mark 程序将要失活，保存用户数据，断开网络连接,游戏暂停
- (void)applicationWillResignActive:(UIApplication *)application
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

#pragma mark 程序进入后台,释放界面元素，视频，音频媒体，降低程序的驻留内存开销
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

#pragma mark 程序进入前台，恢复界面，数据等
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

#pragma mark 程序激活，恢复用户数据，恢复网络连接
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

#pragma mark 程序结束
- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}


@end
