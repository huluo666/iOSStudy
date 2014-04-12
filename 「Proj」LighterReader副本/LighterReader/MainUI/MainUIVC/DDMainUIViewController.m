//
//  DDMainUIViewController.m
//  LighterReader
//
//  Created by 萧川 on 14-3-27.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDMainUIViewController.h"
#import "Reachability.h"
#import "DDMainUINaviController.h"
#import "DDFlipPageViewController.h"

@interface DDMainUIViewController ()

@property (nonatomic, strong) NSString *titleViewTitle;

// set navi titleView title
- (void)setTitleViewTitle:(NSString *)titleViewTitle;
// title view single tap action
- (void)titleViewSingleTapAction:(UITapGestureRecognizer *)singleTap;

// cheak network connect is working
-(BOOL)isConnectionAvailable;
// reload data action
- (void)reloadAction:(UIButton *)sender;
// reload data with animation
- (void)reloadData;

@property (assign, nonatomic, getter = isAnimationRunning) BOOL animationRunning;

@property (strong, nonatomic) UIView *clearView;
@property (strong, nonatomic) UIView *listView;

// swicth page VC
@property (nonatomic, assign) DDCellType currentCellTyp;

@property (nonatomic, strong) NSMutableArray *dataSource;

// switch cell type
- (void)setCurrentCellTyp:(DDCellType)currentCellTyp;
- (void)setPageViewControllerWithCellType:(DDCellType)cellType;

// bar item actions
- (void)menuBarItemAction;
- (void)floaterSettingItemAction;
- (void)searchBarItemAction;

// notify
- (void)processNotify:(NSNotification *)notify;

@end

@implementation DDMainUIViewController

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"login"
                                                  object:nil];
}

- (id)init
{
    self = [super init];
    if (self) {
        // left menu bar
        UIImage *menuBarImage = DDImageWithName(@"mobile-icon-home-white");
        UIBarButtonItem *menuBarItem = [[UIBarButtonItem alloc]
                                        initWithImage:menuBarImage
                                        style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(menuBarItemAction)];
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -15;
        
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, menuBarItem];
//        self.navigationItem.leftBarButtonItem = menuBarItem;
        
        // right search bar
        UIImage *serchBarImage = DDImageWithName(@"mobile-icon-store-white");
        UIBarButtonItem *serchBarItem = [[UIBarButtonItem alloc]
                                         initWithImage:serchBarImage
                                         style:UIBarButtonItemStylePlain
                                         target:self
                                         action:@selector(searchBarItemAction)];
        self.navigationItem.rightBarButtonItems = @[negativeSpacer, serchBarItem];
        
        // regist notify
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(processNotify:)
                                                     name:@"login" object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    
    self.title = @"";
    
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.892 alpha:1.000];

    [self setTitleViewTitle:@"All/Home"];
    
    // add hint label
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds),
                              CGRectGetHeight(self.view.bounds) - 64);
    UILabel *hintLabel = [[UILabel alloc] initWithFrame:frame];
    hintLabel.font = [UIFont systemFontOfSize:24];
    hintLabel.textAlignment = NSTextAlignmentCenter;
    hintLabel.textColor = [UIColor orangeColor];
    hintLabel.text = @"Swip right to get started";
    [self.view addSubview:hintLabel];
}

- (void)processNotify:(NSNotification *)notify {
    
    if ([notify.userInfo[@"isLogined"] integerValue]) {
        // login in
        NSMutableArray *dataSource = [[NSMutableArray alloc] init];
        for (int i = 1; i <= 22; i++) {
            NSString *title = [NSString stringWithFormat:
                               @"Create a new instance of the appropriate %d class,"
                               " insert it into the array, and add a new row to the table view", i];
            NSString *review = @"Override to support conditional editing of the table view.";
            NSString *hint = @"200k sina / 12h";
            NSDictionary *dict = @{@"title":title, @"review":review, @"hint":hint};
            [dataSource addObject:dict];
        }
        self.dataSource = dataSource;
        
        [self setPageViewControllerWithCellType:DDCellTypeTitleOnly];
        
        // right bars
        UIImage *floaterSetingImage = DDImageWithName(@"mobile-icon-customize-white");
        UIBarButtonItem *floaterSettingItem = [[UIBarButtonItem alloc]
                                               initWithImage:floaterSetingImage
                                               style:UIBarButtonItemStylePlain
                                               target:self
                                               action:@selector(floaterSettingItemAction)];
        NSArray *bars = self.navigationItem.rightBarButtonItems;
        NSMutableArray *rightBarButtonItems = [NSMutableArray arrayWithArray:bars];
        [rightBarButtonItems addObject:floaterSettingItem];
        self.navigationItem.rightBarButtonItems = rightBarButtonItems;
        
        // delete hint label
        for (UIView *view in self.view.subviews) {
            if ([view isKindOfClass:[UILabel class]]) {
                UILabel *label = (UILabel *)view;
                [label removeFromSuperview];
            }
        }
        NSLog(@"%@", self.view.subviews);
    } else {
        // login out
        NSArray *childs = self.childViewControllers;
        if (childs) {
            for (UIViewController *viewController in childs) {
                if ([viewController isKindOfClass:[DDFlipPageViewController class]]) {
                    [viewController.view removeFromSuperview];
                    [viewController removeFromParentViewController];
                }
            }
        }
        // add hint label
        CGRect frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds),
                                  CGRectGetHeight(self.view.bounds) - 64);
        UILabel *hintLabel = [[UILabel alloc] initWithFrame:frame];
        hintLabel.font = [UIFont systemFontOfSize:24];
        hintLabel.textAlignment = NSTextAlignmentCenter;
        hintLabel.textColor = [UIColor orangeColor];
        hintLabel.text = @"Swip right to get started";
        [self.view addSubview:hintLabel];
        
        self.dataSource = nil;

        // right bars
        NSMutableArray *bars = [NSMutableArray arrayWithArray:self.navigationItem.rightBarButtonItems];
        [bars removeLastObject];
        self.navigationItem.rightBarButtonItems = bars;
    }
}

- (void)setCurrentCellTyp:(DDCellType)currentCellTyp {
    
    if (currentCellTyp != _currentCellTyp) {
        _currentCellTyp = currentCellTyp;
        [self setPageViewControllerWithCellType:currentCellTyp];
    }
}

- (void)setPageViewControllerWithCellType:(DDCellType)cellType {
    
    NSArray *childs = self.childViewControllers;
    if (childs) {
        for (UIViewController *viewController in childs) {
            if ([viewController isKindOfClass:[DDFlipPageViewController class]]) {
                [viewController.view removeFromSuperview];
                [viewController removeFromParentViewController];
            }
        }
    }
    
    DDFlipPageViewController *flipPageVC = [[DDFlipPageViewController alloc]
                                            initWithCellType:cellType];
    [self addChildViewController:flipPageVC];
    [self.view addSubview:flipPageVC.view];
    flipPageVC.dataSource = self.dataSource;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self showNetworkLinkHint];
}

- (void)setTitleViewTitle:(NSString *)titleViewTitle {
    
    if (_titleViewTitle != titleViewTitle) {
        _titleViewTitle = titleViewTitle;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(0, 0, 0, 44);
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc]
                                              initWithTarget:self
                                              action:@selector(titleViewSingleTapAction:)];
        [titleLabel addGestureRecognizer:singleTapGesture];
        titleLabel.text = _titleViewTitle;
        [self.view addSubview:titleLabel];
        
        self.navigationItem.titleView = titleLabel;
    }
}

#pragma mark - private messages

#pragma mark - Bar item Actions

- (void)menuBarItemAction {
    
    if (_handleMenuBarItemAction) {
        _handleMenuBarItemAction();
    }
}

- (void)searchBarItemAction {
    
    if (_handleSearchBarItemAction) {
        _handleSearchBarItemAction();
    }
}

- (void)floaterSettingItemAction {
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
    __weak DDMainUINaviController *mainUINavi = (DDMainUINaviController *)self.navigationController;
    [mainUINavi showFloaterAdjustView];
    
    /* blocks action */
    // set display style, notify display view reload data
    mainUINavi.titleOnlyView = ^{
        [self setCurrentCellTyp:DDCellTypeTitleOnly];
    };
    mainUINavi.listView = ^{
        [self setCurrentCellTyp:DDCellTypeList];
    };
    mainUINavi.magazineView = ^{
        [self setCurrentCellTyp:DDCellTypeMagazine];
    };
    mainUINavi.cardsView = ^{
        [self setCurrentCellTyp:DDCellTypeCards];
    };
    mainUINavi.refresh = ^{
        NSArray *childs = self.childViewControllers;
        for (UIViewController *viewController in childs) {
            if ([viewController isKindOfClass:[DDFlipPageViewController class]]) {
                DDFlipPageViewController *flipPageVC = (DDFlipPageViewController *)viewController;
                [flipPageVC refresh];
            }
        }
    };
    mainUINavi.toggleMarkAsRead = ^{
        
    };
    mainUINavi.toggleReadOrder = ^{
        
    };
    mainUINavi.toggleShowStoriesPolicy = ^{
        
    };
    mainUINavi.openWebpageDirectly = ^{
        
    };
    mainUINavi.toggleMarkMustRead = ^{
    
    };
    mainUINavi.remove = ^{
    
    };
}

#pragma mark - title view tap action

- (void)titleViewSingleTapAction:(UITapGestureRecognizer *)singleTap {
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
    NSArray *childs = self.childViewControllers;
    for (UIViewController *viewController in childs) {
        if ([viewController isKindOfClass:[DDFlipPageViewController class]]) {
            DDFlipPageViewController *flipPageVC = (DDFlipPageViewController *)viewController;
            [flipPageVC refresh];
        }
    }
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

#pragma mark - reload data with animation

- (void)reloadData {

    // animation
    UIView *backgroundView = [[UIView alloc] init];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    backgroundView.bounds = CGRectMake(0, 0, CGRectGetWidth(screenBounds),80);
    backgroundView.center = CGPointMake(CGRectGetMidX(self.view.bounds),
                                        CGRectGetMidY(self.view.bounds) - 34);
    [self.view addSubview:backgroundView];
    
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc]
                                              initWithActivityIndicatorStyle:
                                              UIActivityIndicatorViewStyleWhiteLarge];
    indicatorView.color = [UIColor grayColor];
    indicatorView.frame = CGRectMake(0,
                                     0,
                                     CGRectGetWidth(backgroundView.bounds),
                                     CGRectGetHeight(backgroundView.bounds) * 0.6);
    [backgroundView addSubview:indicatorView];
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
    
    // reload data
    
    // after reload date ,stop animation
}

@end
