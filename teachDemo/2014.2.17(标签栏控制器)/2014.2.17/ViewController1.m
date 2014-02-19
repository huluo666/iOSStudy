//
//  ViewController1.m
//  2014.2.17
//
//  Created by 张鹏 on 14-2-17.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "ViewController1.h"
#import "DetailViewController.h"

@interface ViewController1 () <UITextFieldDelegate>

- (void)initializeUserInterface;
- (void)barButtonPressed:(UIBarButtonItem *)sender;

@end

@implementation ViewController1

- (id)init
{
    self = [super init];
    if (self) {
        
        self.title = @"Bookmarks";
        // 配置标签栏按钮
        // tabBarItem饿image属性要求图片分辨率：30 x 30 （普通）  60 x 60 （Retina）
        UITabBarItem *tabBarItem = [[UITabBarItem alloc]
                                    initWithTabBarSystemItem:UITabBarSystemItemBookmarks
                                    tag:0];
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

- (NSString *)value {
    
    UITextField *textField = (UITextField *)[self.view viewWithTag:10];
    if (textField.text.length > 0) {
        self.value = textField.text;
    }
    return _value;
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
    
    UIBarButtonItem *nextItem = [[UIBarButtonItem alloc]
                                 initWithTitle:@"Next"
                                 style:UIBarButtonItemStylePlain
                                 target:self
                                 action:@selector(barButtonPressed:)];
    self.navigationItem.rightBarButtonItem = nextItem;
    [nextItem release];
    
    UITextField *textField = [[UITextField alloc] init];
    textField.bounds = CGRectMake(0, 0, 200, 25);
    textField.center = CGPointMake(CGRectGetMidX(self.view.bounds), 200);
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"请输入需要传递的文本";
    textField.font = [UIFont systemFontOfSize:15];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.tag = 10;
    textField.delegate = self;
    [self.view addSubview:textField];
    [textField release];
}

- (void)barButtonPressed:(UIBarButtonItem *)sender {
    
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
    [detailVC release];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 遍历所有子视图，若子视图是UITextField、UITextView等类型，则关闭键盘
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

@end





















