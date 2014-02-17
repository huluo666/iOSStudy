//
//  ViewController.m
//  UITask
//
//  Created by cuan on 14-1-22.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "RootViewController.h"
#import "LoginViewController.h"
#import "PhotosViewController.h"
#import "HomePageViewController.h"
#import "SettingViewController.h"

@interface RootViewController ()

@property (nonatomic, retain) UIView *leftView;
@property (nonatomic, retain) UIView *rightView;
@property (nonatomic, assign, getter = isLeftViewShow) BOOL leftViewShow;
@property (nonatomic, retain) UILabel *label;

- (void)initializeUserInteface;
- (void)loadToolBarItems;
- (void)loadGestureRecognizer;
- (void)processGesture:(UISwipeGestureRecognizer *)swip;

@end

@implementation RootViewController

- (void)dealloc
{
    [_rightView release];
    [_leftView release];
    [_label release];
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
    if (self = [super init]) {
        _leftView = [[UIView alloc] init];
        _rightView = [[UIView alloc] init];
        _label = [[UILabel alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeUserInteface];
    [self loadToolBarItems];
    [self loadGestureRecognizer];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.toolbarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    _logined = YES;
    if (!_logined) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
        [loginVC release];
        
        self.title = @"首页";
    }
}

/*!
 *    初始化用户界面
 */
- (void)initializeUserInteface
{
    _leftView.bounds          = CGRectMake(0, 0, 200, self.view.frame.size.height);
    _leftView.center          = CGPointMake(-100, CGRectGetMidY(self.view.frame));
    _leftView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_leftView];
    
    _rightView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _rightView.backgroundColor = [UIColor blueColor];
    _rightView.layer.shadowColor = [UIColor blackColor].CGColor;
    _rightView.layer.shadowOffset = CGSizeMake(-3, -3);
    _rightView.layer.shadowOpacity = 0.5;
    [self.view addSubview:_rightView];
    
    _label.frame = CGRectMake(60, 259, 200, 50);
    _label.tag = 101;
    _label.text          = SHOW_RED_VIEW;
    _label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_label];
    [_label release];
    
    _leftViewShow = NO;
    _logined = NO;
}

/*!
 *    载入工具栏
 */
- (void)loadToolBarItems
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    UIBarButtonItem *space = [[UIBarButtonItem alloc]
                              initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                              target:nil
                              action:NULL];
    [items addObject:space];
    NSArray *array = @[@"相册", @"主页", @"设置", @"关于"];
    for (int i = 0; i < 4; i++) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc]
                                 initWithTitle:array[i]
                                 style:UIBarButtonItemStylePlain
                                 target:self
                                 action:@selector(itemPressed:)];
        item.tag = TOOL_BAT_ITEM_TAG + i;
        [items addObject:item];
        [items addObject:space];
        [item release];
    }

    self.toolbarItems = items;
    [items release];
}

/*!
 *    工具栏按钮监视器方法
 *
 *    @param item 点击的按钮
 */
- (void)itemPressed:(UIBarButtonItem *)item
{
    if ([item.title isEqualToString:@"相册"]) {
        PhotosViewController *photosVC = [[PhotosViewController alloc] init];
        photosVC.title = item.title;
        [self.navigationController pushViewController:photosVC animated:YES];
        [photosVC release];
        return;
    }
    
    if ([item.title isEqualToString:@"主页"]) {
        HomePageViewController *homePageVC = [[HomePageViewController alloc] init];
        homePageVC.title = item.title;
        [self.navigationController pushViewController:homePageVC animated:YES];
        [homePageVC release];
        return;
    }
    
    if ([item.title isEqualToString:@"设置"]) {
        SettingViewController *settingVC = [[SettingViewController alloc] init];
        settingVC.title = item.title;
        [self.navigationController pushViewController:settingVC animated:YES];
        [settingVC release];
        return;
    }
    
}

/*!
 *    添加手势识别
 */
- (void)loadGestureRecognizer
{
    UISwipeGestureRecognizer *swipLeft = [[UISwipeGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(processGesture:)];
    swipLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipLeft];
    [swipLeft release];
    
    UISwipeGestureRecognizer *swipRight = [[UISwipeGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(processGesture:)];
    swipRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipRight];
    [swipRight release];
}

/*!
 *    处理手势识别
 *
 *    @param swip 手势
 */
- (void)processGesture:(UISwipeGestureRecognizer *)swip
{
    if (swip.direction == UISwipeGestureRecognizerDirectionLeft) { // 向左滑动
        [UIView animateWithDuration:0.5f animations:^{
            _leftView.center = CGPointMake(-(_leftView.bounds.size.width/2),
                                           CGRectGetMidY(self.view.frame));
            _rightView.center = CGPointMake(CGRectGetMidX(self.view.frame),
                                            CGRectGetMidY(self.view.frame));
            self.navigationController.toolbar.center =
                CGPointMake(CGRectGetMidX(self.view.frame),
                            self.view.frame.size.height -
                            self.navigationController.toolbar.frame.size.height/2);

            _rightView.userInteractionEnabled = YES;
            self.navigationController.toolbar.userInteractionEnabled = YES;
        }];
    }
    
    if (swip.direction == UISwipeGestureRecognizerDirectionRight) {
        [UIView animateWithDuration:0.5f animations:^{
            _leftView.center = CGPointMake(_leftView.bounds.size.width/2,
                                           CGRectGetMidY(self.view.frame));
            _rightView.center = CGPointMake(CGRectGetMidX(self.view.frame) +
                                            _leftView.bounds.size.width,
                                            CGRectGetMidY(self.view.frame));
            self.navigationController.toolbar.center =
                CGPointMake(CGRectGetMidX(self.view.frame) +
                            _leftView.bounds.size.width,
                            self.view.frame.size.height -
                            self.navigationController.toolbar.frame.size.height/2);

            _rightView.userInteractionEnabled = NO;
            self.navigationController.toolbar.userInteractionEnabled = NO;
        }];
    }
    
    _leftViewShow = !_leftViewShow;
    
    _label.text = [_label.text isEqualToString:SHOW_RED_VIEW] ? SHOW_BLUE_VIEW : SHOW_RED_VIEW;
}

@end
