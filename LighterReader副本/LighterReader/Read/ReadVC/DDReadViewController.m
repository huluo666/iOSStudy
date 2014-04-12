//
//  DDReadViewController.m
//  LighterReader
//
//  Created by 萧川 on 14-4-10.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDReadViewController.h"
#import "DDReadView.h"
#import "DDPullUp.h"
#import "DDPullDown.h"
#import "UIView+FindUIViewController.h"

#define kPagingDuration 0.5f

@interface DDReadViewController ()

- (void)loadRightBarButtonItems;

// rightBarButtonItems actions
- (void)barItemAction:(UIBarButtonItem *)sender;
- (void)savedForLater;
@property (assign, nonatomic, getter = isMarked) BOOL marked;

// scorllView read view
- (void)loadReadView;
@property (strong, nonatomic) NSArray *positionFrame;
@property (strong, nonatomic) NSMutableArray *readViews;

// slip paging
- (void)loadGesture;
- (void)pagingAction:(UIPanGestureRecognizer *)panGesture;
- (void)previousPage;
- (void)followingPage;
- (void)pagingCancel;

@end

@implementation DDReadViewController

- (void)dealloc {

    NSLog(@"%@, dealloced", [self class]);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

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
    self.automaticallyAdjustsScrollViewInsets = NO;
    
	self.view.backgroundColor = [UIColor whiteColor];

    // bar itmes
    [self loadRightBarButtonItems];
    // read views
    [self loadReadView];
    // pan gesture
    [self loadGesture];
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
    
    DDReadView *previousReadView = [[DDReadView alloc] initWithFrame:previousFrame];
    previousReadView.contentSize = CGSizeMake(320, height + 250);
    previousReadView.backgroundColor = [UIColor greenColor];
    _readViews = [[NSMutableArray alloc] initWithObjects:previousReadView, nil];
    
    DDReadView *appearedReadView = [[DDReadView alloc] initWithFrame:appearedFrame];
    appearedReadView.contentSize = CGSizeMake(320, height + 250);
    appearedReadView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:appearedReadView];
    [_readViews addObject:appearedReadView];
    
    DDReadView *followingReadView = [[DDReadView alloc] initWithFrame:followingFrame];
    followingReadView.contentSize = CGSizeMake(320, height + 250);
    followingReadView.backgroundColor = [UIColor redColor];
    [_readViews addObject:followingReadView];
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    
    [self.view addSubview:_readViews[0]];
    [self.view addSubview:_readViews[2]];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [_readViews[0] removeFromSuperview];
    [_readViews[2] removeFromSuperview];
}

#pragma mark - slip paging

- (void)loadGesture {
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(pagingAction:)];
    [self.view addGestureRecognizer:panGesture];
}

- (void)pagingAction:(UIPanGestureRecognizer *)panGesture {
    
    static CGPoint startCenter;

    switch (panGesture.state) {
        case UIGestureRecognizerStatePossible: {
        }
            break;
        case UIGestureRecognizerStateBegan: {
            
            CGRect fristFrame = [_positionFrame[1] CGRectValue];
            startCenter = CGPointMake(CGRectGetMidX(fristFrame), CGRectGetMidY(fristFrame));
        }
            break;
        case UIGestureRecognizerStateChanged: {
            CGPoint translation = [panGesture translationInView:self.view];
            DDReadView *appearedReadView = _readViews[1];
            DDReadView *previousReadView = _readViews[0];
            DDReadView *followingReadView = _readViews[2];
            
            appearedReadView.center = CGPointMake(startCenter.x + translation.x,
                                                  startCenter.y);
            previousReadView.center = CGPointMake(startCenter.x -
                                                  CGRectGetWidth(previousReadView.bounds) +
                                                  translation.x,
                                                  startCenter.y);
            followingReadView.center = CGPointMake(startCenter.x +
                                                   CGRectGetWidth(followingReadView.bounds) +
                                                   translation.x,
                                                   startCenter.y);
        }
            break;
        case UIGestureRecognizerStateEnded: {
            CGPoint velocity = [panGesture velocityInView:self.view];
            CGPoint translation = [panGesture translationInView:self.view];
            
            if (translation.x > 0) {
                // slip right
                if (velocity.x < 0) {
                    // cancel
                    [self pagingCancel];
                } else {
                    [self previousPage];
                }
            } else {
                // slip left
                if (velocity.x > 0) {
                    // cancel
                    [self pagingCancel];
                } else {
                    [self followingPage];
                }
            }
        }
            break;
        case UIGestureRecognizerStateCancelled: {
        }
            break;
        case UIGestureRecognizerStateFailed: {
        }
            break;
        default:
            break;
    }
}

- (void)previousPage {

    [UIView animateWithDuration:kPagingDuration animations:^{
        DDReadView *appearedReadView = _readViews[1];
        DDReadView *previousReadView = _readViews[0];
        previousReadView.frame = [_positionFrame[1] CGRectValue];
        appearedReadView.frame = [_positionFrame[2] CGRectValue];
        
    } completion:^(BOOL finished) {
        DDReadView *followingReadView = _readViews[2];
        followingReadView.frame = [_positionFrame[0] CGRectValue];
        
        DDReadView *needAdjust = [_readViews lastObject];
        [_readViews removeLastObject];
        [_readViews insertObject:needAdjust atIndex:0];
    }];
}

- (void)followingPage {
    
    [UIView animateWithDuration:kPagingDuration animations:^{
        DDReadView *appearedReadView = _readViews[1];
        DDReadView *followingReadView = _readViews[2];
        followingReadView.frame = [_positionFrame[1] CGRectValue];
        appearedReadView.frame = [_positionFrame[0] CGRectValue];

    } completion:^(BOOL finished) {
        DDReadView *previousReadView = _readViews[0];
        previousReadView.frame = [_positionFrame[2] CGRectValue];
        
        DDReadView *needAdjust = [_readViews firstObject];
        [_readViews removeObjectAtIndex:0];
        [_readViews addObject:needAdjust];
    }];
}

- (void)pagingCancel {
    
    DDReadView *appearedReadView = _readViews[1];
    DDReadView *previousReadView = _readViews[0];
    DDReadView *followingReadView = _readViews[2];
    
    [UIView animateWithDuration:kPagingDuration animations:^{
        appearedReadView.frame = [_positionFrame[1] CGRectValue];
        previousReadView.frame = [_positionFrame[0] CGRectValue];
        followingReadView.frame = [_positionFrame[2] CGRectValue];
    }];
}

@end
