//
//  AppDelegate.m
//  Class1demo
//
//  Created by 张鹏 on 14-1-21.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)dealloc {
    
    [_textField release];
    [_label     release];
    [_window    release];
    
    [super dealloc];
}

// home键：command + shift + h

// 程序加载完成：自定义界面加载、数据导入、初始化等
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // _cmd：代表当前方法的选择器
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    // bounds:边界大小
    // UIWindow:设备的主窗口，作为界面元素的容器
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    // UIColor:表示颜色的对象
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 将window作为程序当前激活并显示的窗口，keywindow
    [self.window makeKeyAndVisible];
    
    
    // windowLevel:描述窗口级别，级别越高，会覆盖级别低的窗口
    // appdelegate中默认创建的window等级为UIWindowLevelNormal
//    self.window.windowLevel = UIWindowLevelAlert;
    
//    NSLog(@"window:%.2f  alert:%.2f  normal:%.2f statusBar:%.2f", self.window.windowLevel, UIWindowLevelAlert, UIWindowLevelNormal, UIWindowLevelStatusBar);
    
    
    // UILabel：文本展示视图、控件
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 320, 50)];
    // 需要展示的文本
    _label.text = @"Hello World!";
    // 文本颜色
    _label.textColor = [UIColor blackColor];
    // 文本字体类型
    _label.font = [UIFont italicSystemFontOfSize:25];
    // UILabel视图的背景色
    _label.backgroundColor = [UIColor clearColor];
    // 文本对齐方式，默认是左对齐
    _label.textAlignment = NSTextAlignmentCenter;
    // 当一个视图添加到另一个视图之上时，被添加的视图将被持有
    [self.window addSubview:_label];
    
    // UITextField:文本输入框
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(60, _label.frame.origin.y + _label.frame.size.height + 50, 200, 30)];
    // 占位符
    _textField.placeholder = @"请输入文本";
    // 边框类型
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.window addSubview:_textField];

    
    // UIButton:按钮
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(110, CGRectGetMaxY(textField.frame) + 50, 100, 30)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    // 设置边界大小
    button.bounds = CGRectMake(0, 0, 100, 30);
    // 设置位置
    button.center = CGPointMake(160, CGRectGetMaxY(_textField.frame) + 50);
    // 设置标题文字
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setTitle:@"高亮" forState:UIControlStateHighlighted];
    // 关联按钮事件
    [button addTarget:self
               action:@selector(buttonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.window addSubview:button];
    
    
    return YES;
}

- (void)buttonPressed:(UIButton *)sender {
    
//    NSLog(@"%@", sender.currentTitle);
//    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    // 关闭键盘
    [_textField resignFirstResponder];
    
    // 1.获取UITextField的文本
    NSString *text = _textField.text;
    // 2.判断文本有效
    if (!text || text.length == 0) {
        return;
    }
    // 3.给UILabel赋值文本内容
    _label.text = text;
}

// 程序将要失活：保存用户的数据，断开网络链接，游戏暂停
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

// 程序进入后台：施放界面元素，视频、音频媒体，降低程序的驻留内存开销
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

// 程序进入前台：恢复界面、数据等
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

// 程序激活：恢复用户数据，恢复网络链接等
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

@end







