//
//  DDReadViewController.m
//  LighterReader
//
//  Created by 萧川 on 14-4-10.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDReadViewController.h"
#import "DDPullUp.h"

@interface DDReadViewController ()

- (void)loadRightBarButtonItems;

// rightBarButtonItems actions
- (void)barItemAction:(UIBarButtonItem *)sender;
- (void)savedForLater;
@property (assign, nonatomic, getter = isMarked) BOOL marked;

// scorllView
- (void)loadReadView;

@end

@implementation DDReadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithDataSource:(id)dataSource {
    
    if (self = [super init]) {
        _dataSource = dataSource;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor greenColor];
    
    [self loadRightBarButtonItems];

    [self loadReadView];
}

#pragma mark - RightBarButtonItems

- (void)loadRightBarButtonItems {
    
    // rightbar items
    UIBarButtonItem *more = [[UIBarButtonItem alloc] initWithImage:DDImageWithName(@"mobile-icon-toolbar-overflow-white") style:UIBarButtonItemStylePlain target:self action:@selector(barItemAction:)];
    more.tag = kBarItemTag;
    
    UIBarButtonItem *mark = [[UIBarButtonItem alloc] initWithImage:DDImageWithName(@"mobile-icon-toolbar-feedly-white") style:UIBarButtonItemStylePlain target:self action:@selector(barItemAction:)];
    mark.tag = kBarItemTag + 1;
    
    UIBarButtonItem *tweet = [[UIBarButtonItem alloc] initWithImage:DDImageWithName(@"mobile-icon-toolbar-twitter-white") style:UIBarButtonItemStylePlain target:self action:@selector(barItemAction:)];
    tweet.tag = kBarItemTag + 2;
    
    self.navigationItem.rightBarButtonItems = @[more, mark, tweet];
}

- (void)barItemAction:(UIBarButtonItem *)sender {

    NSLog(@"barItemAction");
    NSInteger index = sender.tag - kBarItemTag;
    switch (index) {
        case 0: {

        }
            break;
            
        case 1: {
            if (_marked) {
                sender.tintColor = [UIColor grayColor];
                _marked = NO;
            } else {
                sender.tintColor = [UIColor greenColor];
                _marked = YES;
            }
        }
            break;
         
        case 2: {

        }
            break;
            
        default:
            break;
    }
}

- (void)savedForLater {
    
    
}

#pragma mark - read view

- (void)loadReadView {
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
    scrollView.pagingEnabled = YES;
//    scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.view.bounds), 0);
    [self.view addSubview:scrollView];
    
    DDPullUp *pullUp = [DDPullUp pullUp];
    pullUp.scrollView = scrollView;
    
    __weak DDReadViewController *weakSelf = self;
    pullUp.beginRefreshBaseView = ^(DDRefreshBaseView *refreshBaseView) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
        
    };
}

@end
