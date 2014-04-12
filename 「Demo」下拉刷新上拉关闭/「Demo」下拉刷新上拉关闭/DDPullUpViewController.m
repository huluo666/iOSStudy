//
//  DDPullUpViewController.m
//  「Demo」下拉刷新上拉关闭
//
//  Created by 萧川 on 14-4-12.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDPullUpViewController.h"
#import "DDPullUp.h"

@interface DDPullUpViewController ()

@property (strong, nonatomic) DDPullUp *pullUp;

@end

@implementation DDPullUpViewController

- (void)dealloc {
    
    [_pullUp free];
    NSLog(@"%s", __FUNCTION__);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    UIScrollView *scrollow = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrollow.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds),
                                      CGRectGetHeight(self.view.bounds) + 20);
    [self.view addSubview:scrollow];
    
    _pullUp = [DDPullUp pullUp];
    _pullUp.scrollView = scrollow;
    
    __weak DDPullUpViewController *weakSelf = self;
    _pullUp.beginRefreshBaseView = ^(DDRefreshBaseView *refreshBaseView) {
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
        
    };
}

@end
