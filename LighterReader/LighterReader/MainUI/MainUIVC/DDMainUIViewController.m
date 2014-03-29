//
//  DDMainUIViewController.m
//  LighterReader
//
//  Created by 萧川 on 14-3-27.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDMainUIViewController.h"
#import "DDHomeView.h"

@interface DDMainUIViewController ()

@property (nonatomic, retain) NSString *titleViewTitle;

// load home page view
- (void)loadHomeView;

// title view single tap action
- (void)titleViewSingleTapAction:(UITapGestureRecognizer *)singleTap;

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
        self.view.backgroundColor = [UIColor lightGrayColor];
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
}

- (void)titleViewSingleTapAction:(UITapGestureRecognizer *)singleTap {
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

@end
