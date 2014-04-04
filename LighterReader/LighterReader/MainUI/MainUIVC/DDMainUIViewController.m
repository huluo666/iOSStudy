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

// title view single tap action
- (void)titleViewSingleTapAction:(UITapGestureRecognizer *)singleTap;

// judge network connect is working
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
        self.navigationItem.leftBarButtonItem = menuBarItem;
        
        // right search bar
        UIImage *serchBarImage = DDImageWithName(@"mobile-icon-store-white");
        UIBarButtonItem *serchBarItem = [[UIBarButtonItem alloc]
                                         initWithImage:serchBarImage
                                         style:UIBarButtonItemStylePlain
                                         target:self
                                         action:@selector(searchBarItemAction)];
        self.navigationItem.rightBarButtonItem = serchBarItem;
        
        // regist notify
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(processNotify:)
                                                     name:@"login" object:nil];
        
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = [UIColor lightGrayColor];

    [self setTitleViewTitle:@"All/Home"];
    
    NSMutableArray *dataSource = [[NSMutableArray alloc] init];
    for (int i = 1; i <= 108; i++) {
        [dataSource addObject:[NSString stringWithFormat:@"测试数据内容编号为：%d", i]];
    }
    self.dataSource = dataSource;
    
    // add hint label
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 64);
    UILabel *hintLabel = [[UILabel alloc] initWithFrame:frame];
    hintLabel.font = [UIFont systemFontOfSize:24];
    hintLabel.textAlignment = NSTextAlignmentCenter;
    hintLabel.textColor = [UIColor whiteColor];
    hintLabel.text = @"Swip right to get started";
    [self.view addSubview:hintLabel];

}

- (void)processNotify:(NSNotification *)notify {
    
    if ([notify.userInfo[@"isLogined"] integerValue]) {
        [self setPageViewControllerWithCellType:DDCellTypeTitleOnly];
    };
}

- (void)setCurrentCellTyp:(DDCellType)currentCellTyp {
    
    if (currentCellTyp != self.currentCellTyp) {
        _currentCellTyp = currentCellTyp;
        [self setPageViewControllerWithCellType:currentCellTyp];
    }
}

- (void)setPageViewControllerWithCellType:(DDCellType)cellType {
    
    DDFlipPageViewController *flipPageVC = [[DDFlipPageViewController alloc]
                                            initWithCellType:cellType];
    [self addChildViewController:flipPageVC];
    [self.view addSubview:flipPageVC.view];
    flipPageVC.dataSource = self.dataSource;
}

- (void)viewWillAppear:(BOOL)animated
{
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
    mainUINavi.markCategroyAsRead = ^{
        
    };
    mainUINavi.toggleOldestFirst = ^{
    
    };
    mainUINavi.toggleShowStoriesPolicy = ^{
    
    };
    mainUINavi.openWebpageDirectly = ^{
    
    };
}

#pragma mark - title view tap action

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
