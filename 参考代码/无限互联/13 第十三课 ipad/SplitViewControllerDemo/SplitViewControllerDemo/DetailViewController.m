//
//  DetailViewController.m
//  SplitViewControllerDemo
//
//  Created by wei.chen on 13-1-7.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "DetailViewController.h"
#import "PopViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"详情窗口";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"pop窗口" style:UIBarButtonItemStyleBordered target:self action:@selector(clickAction:)];
    self.navigationItem.leftBarButtonItem = [leftItem autorelease];
    
    
    PopViewController *popViewController = [[PopViewController alloc] init];
    UINavigationController *popNav = [[UINavigationController alloc] initWithRootViewController:popViewController];
    
    //创建气泡窗口
    self.popCtrl = [[UIPopoverController alloc] initWithContentViewController:popNav];
    _popCtrl.popoverContentSize = CGSizeMake(320, 600);
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"模态窗口" style:UIBarButtonItemStyleBordered target:self action:@selector(showModal:)];
    self.navigationItem.rightBarButtonItem = [rightItem autorelease];
    
}

- (void)clickAction:(UIBarButtonItem *)buttonItem {
    if (self.popCtrl.popoverVisible) {
        [self.popCtrl dismissPopoverAnimated:YES];
    } else {
        //显示浮动窗口
        [self.popCtrl presentPopoverFromBarButtonItem:buttonItem
                             permittedArrowDirections:UIPopoverArrowDirectionAny
                                             animated:YES];
    }
}

//显示模态窗口
- (void)showModal:(UIBarButtonItem *)buttonItem {
    UIViewController *modalViewCtrl = [[UIViewController alloc] init];
    modalViewCtrl.view.backgroundColor = [UIColor orangeColor];
    modalViewCtrl.title = @"模态窗口";
    UINavigationController *modalNav = [[UINavigationController alloc] initWithRootViewController:modalViewCtrl];
    //默认是UIModalPresentationFullScreen
    modalNav.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentViewController:modalNav animated:YES completion:NULL];
}

@end
