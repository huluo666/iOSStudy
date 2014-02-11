//
//  ViewController.m
//  2014.2.10
//
//  Created by 张鹏 on 14-2-10.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+Expand.h"

#define FUNCTION_BUTTON_TAG 10

@interface ViewController () <UIActionSheetDelegate, UIAlertViewDelegate>

- (void)initializeUserInterface;
- (void)buttonPressed:(UIBarButtonItem *)sender;
- (void)dismissAlertView:(UIAlertView *)alert;

- (void)popToRoot;
- (void)pushToNext;
- (void)share;
- (void)refresh;

@end

@implementation ViewController

- (void)dealloc {
    
    NSLog(@"%@ dealloced.", NSStringFromClass([self class]));
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initializeUserInterface];
}

- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor specialRandomColor];
    
    CGRect bounds = self.view.bounds;
    
    // 设置导航栏标题
    // 方法1:设置控制器title属性
    self.title = @"RIMI";
    // 方法2:设置导航栏title属性
//    self.navigationItem.title = @"rimi";
    
    NSUInteger count = [self.navigationController.viewControllers count];
    
    UILabel *label = [[UILabel alloc] initWithFrame:bounds];
    label.text = [NSString stringWithFormat:@"%@%u", NSStringFromClass([self class]), count];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:25];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
    [label release];
    
//    UIButton *backToRootButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    backToRootButton.bounds = CGRectMake(0, 0, CGRectGetWidth(bounds) / 2, 30);
//    backToRootButton.center = CGPointMake(CGRectGetMidX(bounds) - CGRectGetMidX(backToRootButton.bounds), CGRectGetMaxY(bounds) - 150);
//    backToRootButton.tag = FUNCTION_BUTTON_TAG;
//    [backToRootButton setTitle:@"Back To Root" forState:UIControlStateNormal];
//    [backToRootButton addTarget:self
//                         action:@selector(buttonPressed:)
//               forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:backToRootButton];
//    
//    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    nextButton.bounds = CGRectMake(0, 0, CGRectGetWidth(bounds) / 2, 30);
//    nextButton.center = CGPointMake(CGRectGetMidX(bounds) + CGRectGetMidX(nextButton.bounds), CGRectGetMaxY(bounds) - 150);
//    nextButton.tag = FUNCTION_BUTTON_TAG + 1;
//    [nextButton setTitle:@"Next" forState:UIControlStateNormal];
//    [nextButton addTarget:self
//                   action:@selector(buttonPressed:)
//         forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:nextButton];
    
    // 返回根页面
    UIBarButtonItem *backToRootItem = [[UIBarButtonItem alloc]
                                       initWithTitle:@"Back To Root"
                                       style:UIBarButtonItemStylePlain
                                       target:self
                                       action:@selector(buttonPressed:)];
    backToRootItem.tag = FUNCTION_BUTTON_TAG;
    
    // 推入下一页
    UIBarButtonItem *nextItem = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Next"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(buttonPressed:)];
    nextItem.tag = FUNCTION_BUTTON_TAG + 1;
    
    // 空间延展占位符
    UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc]
                                     initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                     target:nil
                                     action:NULL];
    
    // 配置工具栏按钮
    self.toolbarItems = @[backToRootItem, flexibleItem, nextItem];
    [backToRootItem release];
    [nextItem       release];
    
    
    
    // 定制返回按钮，返回按钮一旦配置就无法修改，只能重新生成并配置
    // 下一个页面返回按钮的风格，在前一个页面进行配置
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]
                                 initWithTitle:[NSString stringWithFormat:@"返回%u", count]
                                 style:UIBarButtonItemStylePlain
                                 target:nil
                                 action:NULL];
    self.navigationItem.backBarButtonItem = backItem;
    [backItem release];
    
    
    // 分享
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                  target:self
                                  action:@selector(buttonPressed:)];
    shareItem.tag = FUNCTION_BUTTON_TAG + 2;
    
    // 刷新
    UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc]
                                    initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                    target:self
                                    action:@selector(buttonPressed:)];
    refreshItem.tag = FUNCTION_BUTTON_TAG + 3;
    
    self.navigationItem.rightBarButtonItems = @[refreshItem, shareItem];
    [refreshItem release];
    [shareItem   release];
}

- (void)buttonPressed:(UIBarButtonItem *)sender {
    
    NSInteger index = sender.tag - FUNCTION_BUTTON_TAG;
    switch (index) {
            
        case 0: [self popToRoot]; break;
            
        case 1: [self pushToNext]; break;
            
        case 2: [self share]; break;
            
        case 3: [self refresh]; break;
            
        default: break;
    }
}

- (void)popToRoot {
    
    // 返回根控制器页面
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)pushToNext {
    
    ViewController *vc = [[ViewController alloc] init];
    // 推入导航栈，导航控制器持有导航栈中的控制器，出栈会释放出栈的控制器
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

- (void)share {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"分享"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:@"删除"
                                  otherButtonTitles:@"新浪微博", @"腾讯微博", nil];
    [actionSheet showInView:self.view];
    [actionSheet release];
}

- (void)refresh {
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"温馨提示"
                          message:@"网络异常，稍后再试！"
                          delegate:self
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:@"重试", @"取消", nil];
    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [alert show];
    
    // 延迟操作
    [self performSelector:@selector(dismissAlertView:) withObject:alert afterDelay:3];
    
    [alert release];
}

- (void)dismissAlertView:(UIAlertView *)alert {
    
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}

#pragma mark - <UIActionSheetDelegate>

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSLog(@"button index = %d", buttonIndex);
}

#pragma mark - <UIAlertViewDelegate>

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    UITextField *text = [alertView textFieldAtIndex:0];
    NSLog(@"string = %@", text.text);
    NSLog(@"button index = %d", buttonIndex);
}


@end















