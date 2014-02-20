//
//  TrainViewController.m
//  「UI」UITest
//
//  Created by 萧川 on 14-2-20.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "TrainViewController.h"

@interface TrainViewController ()

@property(nonatomic, retain) NSArray *titles;
@property (nonatomic, retain) NSMutableDictionary *dataSource;

// 初始化用户界面
- (void)initUserInterface;
// 处理分段控件点击事件
- (void)processControl:(UISegmentedControl *)sender;

// 全科培训
- (void)loadNormalTrainView;
// 企业高管
- (void)loadExecutivesTrainView;
// 师资培训
- (void)loadTeacherTrainView;
// 企业培训
- (void)loadEnterpriseTrainView;


@end

@implementation TrainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        UITabBarItem *tabBarItem = [[UITabBarItem alloc]
                                    initWithTitle:@"IOS培训"
                                    image:[UIImage imageNamed:@"item4"]
                                    tag:14];
        self.tabBarItem = tabBarItem;
        [tabBarItem release];
        
        _titles = [@[@"全科培训", @"高管培训", @"师资培训", @"企业内训"] retain];
        NSArray *imageNames1 = @[@"全科培训1.png", @"全科培训2.png", @"全科培训3.png"];
        NSArray *imageNames2 = @[@"高管培训.png"];
        NSArray *imageNames3 = @[@"师资培训.png"];
        NSArray *imageNames4 = @[@"企业内训1.png", @"企业内训2.png", @"企业内训3.png"];
        NSArray *imageNames = @[imageNames1, imageNames2, imageNames3, imageNames4];
        _dataSource = [[NSMutableDictionary alloc] init];
        for (int i = 0; i < 4; i++) {
            [_dataSource setObject:imageNames[i] forKey:_titles[i]];
        }
    }
    return self;
}

- (void)dealloc
{
    [_titles release];
    [_dataSource release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self initUserInterface];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 创建分段控件
    UISegmentedControl *segmentedControl  = [[UISegmentedControl alloc]
                                             initWithItems:_titles];
    segmentedControl.bounds               = CGRectMake(0, 0, 320, 44);
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor            = [UIColor whiteColor];
    [segmentedControl addTarget:self
                         action:@selector(processControl:)
               forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segmentedControl;
    [segmentedControl release];
    self.navigationItem.titleView = segmentedControl;
    
    [self loadNormalTrainView];
}

- (void)processControl:(UISegmentedControl *)sender
{
    NSInteger index = sender.selectedSegmentIndex;
    switch (index) {
        case 0:
            [self loadNormalTrainView];
            break;
        case 1:
            [self loadExecutivesTrainView];
            break;
        case 2:
            [self loadTeacherTrainView];
            break;
        case 3:
            [self loadEnterpriseTrainView];
            break;
        default:
            break;
    }
}

- (void)loadNormalTrainView
{
    NSArray *views = self.view.subviews;
    for (UIView *view in views) {
        [view removeFromSuperview];
    }
    
    UIView *view = [[UIView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:view];
    
    CGRect frame = CGRectMake(0, 64, CGRectGetWidth(view.frame),
                              CGRectGetHeight(view.frame));
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.contentSize = CGSizeMake(320, 366 * 3);
    scrollView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:scrollView];

    NSArray *images = _dataSource[_titles[0]];
    for (int i = 0; i < images.count; i++) {
        NSString *path = [[NSBundle mainBundle] pathForAuxiliaryExecutable:images[i]];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        UIImageView *imageView = [[UIImageView alloc]
                                  initWithFrame:CGRectMake(0, 366 * i, 320, 366)];
        imageView.image = image;
        
        [scrollView addSubview:imageView];
        
    }
    
    [scrollView release];
}

- (void)loadExecutivesTrainView
{
    NSArray *views = self.view.subviews;
    for (UIView *view in views) {
        [view removeFromSuperview];
    }
    
    NSString *path = [[NSBundle mainBundle]
                      pathForAuxiliaryExecutable:_dataSource[_titles[1]][0]];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    UIView *view = [[UIView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:view];
    
    CGRect frame = CGRectMake(0, 64, CGRectGetWidth(view.frame),
                              CGRectGetHeight(view.frame));
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.contentSize = CGSizeMake(960, 610);
    scrollView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:scrollView];
    [view release];
    
    [scrollView addSubview:imageView];
    [imageView release];
}

- (void)loadTeacherTrainView
{
    NSArray *views = self.view.subviews;
    for (UIView *view in views) {
        [view removeFromSuperview];
    }
    
    NSString *path = [[NSBundle mainBundle]
                      pathForAuxiliaryExecutable:_dataSource[_titles[2]][0]];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    UIView *view = [[UIView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:view];
    
    CGRect frame = CGRectMake(0, 64, CGRectGetWidth(view.frame),
                              CGRectGetHeight(view.frame));
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.contentSize = CGSizeMake(1156, 372);
    scrollView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:scrollView];
    [view release];
    
    [scrollView addSubview:imageView];
    [imageView release];
}

- (void)loadEnterpriseTrainView
{
    NSArray *views = self.view.subviews;
    for (UIView *view in views) {
        [view removeFromSuperview];
    }
    
    UIView *view = [[UIView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:view];
    
    CGRect frame = CGRectMake(0, 64, CGRectGetWidth(view.frame),
                              CGRectGetHeight(view.frame));
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.contentSize = CGSizeMake(320, 138 * 3);
    scrollView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:scrollView];
    
    NSArray *images = _dataSource[_titles[3]];
    for (int i = 0; i < images.count; i++) {
        NSString *path = [[NSBundle mainBundle]
                          pathForAuxiliaryExecutable:images[i]];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        UIImageView *imageView = [[UIImageView alloc]
                                  initWithFrame:CGRectMake(0, 138 * i, 320, 138)];
        imageView.image = image;
        
        [scrollView addSubview:imageView];
    }
    
    [scrollView release];
}

@end
