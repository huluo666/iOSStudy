//
//  DDReadViewController.m
//  LighterReader
//
//  Created by 萧川 on 14-4-10.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDReadViewController.h"
#import "DDReadView.h"
#import "DDPullUpControl.h"

#define kPagingDuration 0.5f

@interface DDReadViewController ()
{
    DDReadView *previousReadView;
    DDReadView *appearedReadView;
    DDReadView *followingReadView;
}

@property (assign, nonatomic, getter = isMarked) BOOL marked;

// scorllView read view
- (void)loadReadView;
@property (strong, nonatomic) NSArray *positionFrame;
@property (strong, nonatomic) NSMutableArray *readViews;

@property(nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation DDReadViewController

- (void)dealloc {

    NSLog(@"=============%s", __FUNCTION__);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
	self.view.backgroundColor = [UIColor whiteColor];

    // read views
    [self loadReadView];
}

#pragma mark - read view

- (void)loadReadView {
    
    CGRect frame = self.view.frame;
    CGRect appearedFrame = CGRectMake(0,
                                      0,
                                      CGRectGetWidth(frame),
                                      CGRectGetHeight(frame) - 64);
    CGRect previousFrame = CGRectMake(-CGRectGetWidth(frame),
                                      0,
                                      CGRectGetWidth(appearedFrame),
                                      CGRectGetHeight(appearedFrame));
    CGRect followingFrame = CGRectMake(CGRectGetWidth(appearedFrame),
                                       0,
                                       CGRectGetWidth(appearedFrame),
                                       CGRectGetHeight(appearedFrame));

    _positionFrame = @[
                       [NSValue valueWithCGRect:previousFrame],
                       [NSValue valueWithCGRect:appearedFrame],
                       [NSValue valueWithCGRect:followingFrame]
                       ];
    CGFloat height = [[UIScreen mainScreen] applicationFrame].size.height;
    
    previousReadView = [[DDReadView alloc] initWithFrame:previousFrame];
    previousReadView.contentSize = CGSizeMake(320, height + 50);
    [self.view addSubview:previousReadView];
//    previousReadView.hidden = YES;
    _readViews = [[NSMutableArray alloc] initWithObjects:previousReadView, nil];
    
    appearedReadView = [[DDReadView alloc] initWithFrame:appearedFrame];
    appearedReadView.contentSize = CGSizeMake(320, height + 50);
    appearedReadView.backgroundColor =[UIColor redColor];
    [self.view addSubview:appearedReadView];
    [_readViews addObject:appearedReadView];
//
////    UIView *view = [[UIView alloc] init];
////    [self.view addSubview:view];
////    [_readViews addObject:view];
//
    followingReadView = [[DDReadView alloc] initWithFrame:followingFrame];
    followingReadView.contentSize = CGSizeMake(320, height + 50);
    [self.view addSubview:followingReadView];
//    followingReadView.hidden = YES;
    [_readViews addObject:followingReadView];
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    
//    [self.view addSubview:_readViews[0]];
//    [self.view addSubview:_readViews[2]];
    [_readViews[0] setHidden:NO];
    [_readViews[2] setHidden:NO];

}
//
- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
//    [_readViews[0] removeFromSuperview];
//    [_readViews[2] removeFromSuperview];
    [_readViews[0] setHidden:YES];
    [_readViews[2] setHidden:YES];
}

@end
