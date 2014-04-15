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
#import "DDFeeds.h"

#define kPagingDuration 0.5f

@interface DDReadViewController () {

    DDReadView *_previousReadView;
    DDReadView *_appearedReadView;
    DDReadView *_followingReadView;
}

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

@property(nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation DDReadViewController

- (void)dealloc {

    NSLog(@"%s", __FUNCTION__);
}

- (id)initWithDataSource:(NSArray *)dataSource indexPath:(NSIndexPath *)indexPath{
    
    if (self = [super init]) {
        _dataSource = dataSource;
        _indexPath = indexPath;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
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
    UIBarButtonItem *more = [[UIBarButtonItem alloc]
                             initWithImage:DDImageWithName(@"mobile-icon-toolbar-overflow-white")
                             style:UIBarButtonItemStylePlain
                             target:self
                             action:@selector(barItemAction:)];
    more.tag = kBarItemTag;
    
    UIBarButtonItem *mark = [[UIBarButtonItem alloc]
                             initWithImage:DDImageWithName(@"mobile-icon-toolbar-feedly-white")
                             style:UIBarButtonItemStylePlain
                             target:self action:@selector(barItemAction:)];
    mark.tag = kBarItemTag + 1;
    
    UIBarButtonItem *tweet = [[UIBarButtonItem alloc]
                              initWithImage:DDImageWithName(@"mobile-icon-toolbar-twitter-white")
                              style:UIBarButtonItemStylePlain
                              target:self
                              action:@selector(barItemAction:)];
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
    
    _previousReadView = [[DDReadView alloc] initWithFrame:previousFrame];
    _previousReadView.contentSize = CGSizeMake(320, height + 50);
    _readViews = [[NSMutableArray alloc] initWithObjects:_previousReadView, nil];
//    _previousReadView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_previousReadView];
    _previousReadView.hidden = YES;
    [_previousReadView setContent:((DDFeeds *)_dataSource[_indexPath.row]).content];
    
    _appearedReadView = [[DDReadView alloc] initWithFrame:appearedFrame];
    _appearedReadView.contentSize = CGSizeMake(320, height + 50);
//    _appearedReadView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:_appearedReadView];
    [_readViews addObject:_appearedReadView];
    [_appearedReadView setContent:((DDFeeds *)_dataSource[_indexPath.row]).content];
    
    _followingReadView = [[DDReadView alloc] initWithFrame:followingFrame];
    _followingReadView.contentSize = CGSizeMake(320, height + 50);
//    _followingReadView.backgroundColor = [UIColor yellowColor];
    _followingReadView.hidden = YES;
    [_readViews addObject:_followingReadView];
    [self.view addSubview:_followingReadView];
    [_followingReadView setContent:((DDFeeds *)_dataSource[_indexPath.row]).content];
    
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
//    
//    [self.view addSubview:_readViews[0]];
//    [self.view addSubview:_readViews[2]];
    
    [_readViews[0] setHidden:NO];
    [_readViews[2] setHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
//    [_readViews[0] removeFromSuperview];
//    [_readViews[2] removeFromSuperview];
    
    [_readViews[0] setHidden:YES];
    [_readViews[2] setHidden:YES];
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
