//
//  ViewController.m
//  UITask
//
//  Created by cuan on 14-1-22.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "RootViewController.h"
#import "LoginViewController.h"
#import "RandomViewController.h"

@interface RootViewController ()

@property (nonatomic, retain) UIView *leftView;
@property (nonatomic, retain) UIView *rightView;
@property (nonatomic, assign, getter = isLeftViewShow) BOOL leftViewShow;
@property (nonatomic, retain) UILabel *label;

- (void)initializeUserInteface;

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
    if (self = [super init])
    {
        _leftView = [[UIView alloc] init];
        _rightView = [[UIView alloc] init];
        _label = [[UILabel alloc] init];
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self initializeUserInteface];
    
    [self loadToolBarItems];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!_logined)
    {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
        [loginVC release];
        
        self.title = @"首页";
    }
}

- (void)loadToolBarItems
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
    [items addObject:space];
    for (int i = 0; i < 4; i++)
    {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"VC%d", i] style:UIBarButtonItemStylePlain target:self action:@selector(itemPressed:)];
        item.tag = TOOL_BAT_ITEM_TAG + i;
        [items addObject:item];
        [items addObject:space];
        [item release];
    }

    self.toolbarItems = items;
    [items release];
}

- (void)itemPressed:(UIBarButtonItem *)item
{
    RandomViewController *randVC = [[RandomViewController alloc] init];
    randVC.title = [NSString stringWithFormat:@"ViewController%ld", item.tag - TOOL_BAT_ITEM_TAG];
    [self.navigationController pushViewController:randVC animated:YES];
    [randVC release];
}

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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_leftViewShow)
    {
        [UIView animateWithDuration:0.5f animations:^{
             _leftView.center = CGPointMake(-100, CGRectGetMidY(self.view.frame));
            _rightView.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame));
        }];
    }
    else
    {
        [UIView animateWithDuration:0.5f animations:^{
            _leftView.center = CGPointMake(100, CGRectGetMidY(self.view.frame));
            _rightView.center = CGPointMake(160 + 200, CGRectGetMidY(self.view.frame));
        }];
    }
    _leftViewShow = !_leftViewShow;
    
    _label.text = [_label.text isEqualToString:SHOW_RED_VIEW] ? SHOW_BLUE_VIEW : SHOW_RED_VIEW;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
