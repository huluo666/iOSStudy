//
//  ViewController1.m
//  「UI」标签控制器(day09)
//
//  Created by 萧川 on 14-2-17.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "ViewController1.h"
#import "UIColor+Expand.h"
#import "DetailViewController.h"

@interface ViewController1 ()

- (void)initUserInterface;
- (void)nextPage;

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

- (NSString *)value
{

    if (!_value) {
        UITextField *textField = (UITextField *)[self.view viewWithTag:301];
        _value = [textField.text copy];
    }
    return _value;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self initUserInterface];
}

- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor specialRandomColor];
    
    UITextField *textField = [[UITextField alloc] init];
    textField.bounds = CGRectMake(0, 0, 220, 30);
    textField.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame) - 70);
    textField.placeholder = @"Please input sometings";
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.returnKeyType = UIReturnKeyDone;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.clearsOnBeginEditing = YES;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.tag = 301;
    [self.view addSubview:textField];
    [textField release];
    
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.frame];
    label.font = [UIFont systemFontOfSize:24.0f];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = self.title;
    [self.view addSubview:label];
    [label release];
    
    UIBarButtonItem *next = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(nextPage)];
    self.navigationItem.rightBarButtonItem = next;
    [next release];
}

- (void)nextPage
{
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
    [detailVC release];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



@end
