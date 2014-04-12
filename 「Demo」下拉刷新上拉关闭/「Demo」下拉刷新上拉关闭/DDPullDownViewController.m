//
//  DDPullDownViewController.m
//  「Demo」下拉刷新上拉关闭
//
//  Created by 萧川 on 14-4-12.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDPullDownViewController.h"
#import "DDPullDown.h"

@interface DDPullDownViewController ()

@property (strong, nonatomic) DDPullDown *pullDown;

@end

@implementation DDPullDownViewController

- (void)dealloc {

    [_pullDown free];
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
    
    UIScrollView *scrollow = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrollow.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds),
                                      CGRectGetHeight(self.view.bounds) + 20);
    [self.view addSubview:scrollow];
    
    
    
    __weak DDPullDownViewController *weakSelf = self;
    
    DDPullDown *pullDown = [DDPullDown pullDown];
    pullDown.scrollView = scrollow;
    pullDown.beginRefreshBaseView = ^(DDRefreshBaseView *refreshBaseView) {
        // 刷新
        [weakSelf performSelector:@selector(stopWithRefreshBaseView:) withObject:refreshBaseView afterDelay:0.01];
    };
    
    pullDown.didRefreshBaseView = ^(DDRefreshBaseView *refreshBaseView) {
        // 刷新完成以后调用
        NSLog(@"!!!!!!!!%@当前状态：数据刷新完成", [refreshBaseView class]);
    };
    
    _pullDown = pullDown;
}

- (void)stopWithRefreshBaseView:(DDRefreshBaseView *)refreshBaseView {

    [refreshBaseView endRefreshingWithSuccess:YES];
}

@end
