//
//  DDMainUIViewController.m
//  LighterReader
//
//  Created by 萧川 on 14-3-27.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDMainUIViewController.h"
#import "DDHomeView.h"
#import "Reachability.h"
#import "DDMainUINaviController.h"

@interface DDMainUIViewController ()

@property (nonatomic, retain) NSString *titleViewTitle;

// load home page view
- (void)loadHomeView;

// title view single tap action
- (void)titleViewSingleTapAction:(UITapGestureRecognizer *)singleTap;

// judge network connect is working
-(BOOL)isConnectionAvailable;
// reload data action
- (void)reloadAction:(UIButton *)sender;
// reload data with animation
- (void)reloadData;


@property (retain, nonatomic) UIView *clearView;
@property (retain, nonatomic) UIView *listView;


@end

@implementation DDMainUIViewController

- (void)dealloc
{
    [_titleViewTitle release];
    [_handleMenuBarItemAction release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithWhite:0.870 alpha:1.000];
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = YES;
        
        // left menu bar
        UIImage *menuBarImage = DDImageWithName(@"mobile-icon-home-white");
        UIBarButtonItem *menuBarItem = [[UIBarButtonItem alloc]
                                        initWithImage:menuBarImage
                                        style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(menuBarItemAction)];
        self.navigationItem.leftBarButtonItem = menuBarItem;
        [menuBarItem release];
        
        // right search bar
        UIImage *serchBarImage = DDImageWithName(@"mobile-icon-store-white");
        UIBarButtonItem *serchBarItem = [[UIBarButtonItem alloc]
                                         initWithImage:serchBarImage
                                         style:UIBarButtonItemStylePlain
                                         target:self
                                         action:@selector(searchBarItemAction)];
        self.navigationItem.rightBarButtonItem = serchBarItem;
        [serchBarItem release];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // load home page
    [self loadHomeView];
    
    [self setTitleViewTitle:@"All/Home"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showNetworkLinkHint];
}

- (void)setTitleViewTitle:(NSString *)titleViewTitle {
    
    if (_titleViewTitle != titleViewTitle) {
        [_titleViewTitle release];
        _titleViewTitle = [titleViewTitle retain];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(0, 0, 0, 44);
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc]
                                              initWithTarget:self
                                              action:@selector(titleViewSingleTapAction:)];
        [titleLabel addGestureRecognizer:singleTapGesture];
        [singleTapGesture release];
        titleLabel.text = _titleViewTitle;
        [self.view addSubview:titleLabel];
        [titleLabel release];
        
        self.navigationItem.titleView = titleLabel;
    }
}

#pragma mark - private messages

#pragma mark - load Views

- (void)loadHomeView
{
    DDHomeView *homeView = [[DDHomeView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:homeView];
    [homeView release];
    
    [self setTitleViewTitle:@"All/Home"];
}

#pragma mark - Actions

- (void)menuBarItemAction
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    if (_handleMenuBarItemAction) {
        _handleMenuBarItemAction();
    }
}

- (void)searchBarItemAction
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    DDMainUINaviController *mainUINavi = (DDMainUINaviController *)self.navigationController;
    [mainUINavi showSettingView];
}


- (void)titleViewSingleTapAction:(UITapGestureRecognizer *)singleTap {
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

#pragma mark - check network link

-(BOOL)isConnectionAvailable {

    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"192.243.119.92"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            break;
    }
    return isExistenceNetwork;
}

- (void)showNetworkLinkHint {

    BOOL available = [self isConnectionAvailable];
    if (!available) {
        UIButton *reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect screenBounds = [[UIScreen mainScreen] bounds];
        reloadButton.bounds = CGRectMake(0, 0, CGRectGetWidth(screenBounds), 30);
        reloadButton.center = CGPointMake(CGRectGetMidX(screenBounds),
                                   CGRectGetMaxY(screenBounds) -
                                   CGRectGetMidY(reloadButton.bounds));
        [reloadButton setBackgroundColor:[UIColor colorWithWhite:0.353 alpha:1.000]];
        [reloadButton setTitleColor:[UIColor lightGrayColor]
                           forState:UIControlStateNormal];
        [reloadButton setTitle:@"No network. Tap here to reload"
                      forState:UIControlStateNormal];
        [reloadButton addTarget:self
                         action:@selector(reloadAction:)
               forControlEvents:UIControlEventTouchUpInside];
        reloadButton.tag = kReloadButtonTag;
        [self.view addSubview:reloadButton];
        
        [UIView animateWithDuration:1 animations:^{
            reloadButton.center = CGPointMake(CGRectGetMidX(screenBounds),
                                              CGRectGetMaxY(screenBounds) -
                                              CGRectGetMidY(reloadButton.bounds) - 64);
        }];
    }
}

- (void)reloadAction:(UIButton *)sender {

    UIButton *reloadButton = (UIButton *)[self.view viewWithTag:kReloadButtonTag];
    if (reloadButton) {
        [UIView animateWithDuration:1 animations:^{
            CGRect screenBounds = [[UIScreen mainScreen] bounds];
            reloadButton.center = CGPointMake(CGRectGetMidX(screenBounds),
                                              CGRectGetMaxY(screenBounds) -
                                              CGRectGetMidY(reloadButton.bounds));
        } completion:^(BOOL finished) {
            [reloadButton removeFromSuperview];
            
            // start reload data, start progress animation
            [self reloadData];
        }];
    }
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

// reload data with animation
- (void)reloadData {

    // animation
    UIView *backgroundView = [[UIView alloc] init];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    backgroundView.bounds = CGRectMake(0, 0, CGRectGetWidth(screenBounds),80);
    backgroundView.center = CGPointMake(CGRectGetMidX(self.view.bounds),
                                        CGRectGetMidY(self.view.bounds) - 34);
    [self.view addSubview:backgroundView];
    [backgroundView release];
    
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc]
                                              initWithActivityIndicatorStyle:
                                              UIActivityIndicatorViewStyleWhiteLarge];
    indicatorView.color = [UIColor grayColor];
    indicatorView.frame = CGRectMake(0,
                                     0,
                                     CGRectGetWidth(backgroundView.bounds),
                                     CGRectGetHeight(backgroundView.bounds) * 0.6);
    [backgroundView addSubview:indicatorView];
    [indicatorView release];
    [indicatorView startAnimating];
    
    UILabel *hintLabel = [[UILabel alloc] initWithFrame:
                          CGRectMake(0,
                                     CGRectGetHeight(backgroundView.bounds) * 0.6,
                                     CGRectGetWidth(backgroundView.bounds),
                                     CGRectGetHeight(backgroundView.bounds) * 0.4)];
    hintLabel.text = @"Loading...";
    hintLabel.textAlignment = NSTextAlignmentCenter;
    hintLabel.textColor = [UIColor lightGrayColor];
    [backgroundView addSubview:hintLabel];
    [hintLabel release];
    
    // reload data
    
    // after reload date ,stop animation
}


@end
