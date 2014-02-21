//
//  DDRootViewController.m
//  「UI」高级动画-作业
//
//  Created by 萧川 on 14-2-21.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "DDRootViewController.h"

@interface DDRootViewController () <UIScrollViewDelegate>

@property (retain, nonatomic) NSMutableArray *imageNameList;

@property (retain, nonatomic) UIScrollView *scrollView;

- (void)initUserInterface;
- (void)upadateUserInterface;

@end

@implementation DDRootViewController

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
        _imageNameList = [@[] mutableCopy];
        for (int i = 0; i < 4; i++) {
            [_imageNameList addObject:[NSString stringWithFormat:@"i%d.png", i + 1]];
        }
    }
    return self;
}

- (void)dealloc
{
    [_imageNameList release];
    [_scrollView release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUserInterface];
}

- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 这是底图
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.jpg"]];
    imageView.frame = CGRectMake(0, 0, 1024, 768);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    [imageView release];
    
    // 设置滚动视图
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor greenColor];
    _scrollView.frame = CGRectMake(0, 400, 1024, 150);
    _scrollView.contentMode = UIViewContentModeScaleAspectFit;
    _scrollView.contentSize = CGSizeMake(1024/3*5, 150);
    _scrollView.contentOffset = CGPointZero;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    for (int i = 0; i < 4; i++) {
        UIImage *image = [UIImage imageNamed:_imageNameList[i]];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor orangeColor];
        imageView.image = image;
        imageView.frame = CGRectMake(1024 / 3 * i + 100, 0, 120, 150);
        [_scrollView addSubview:imageView];
    }
}

- (void)upadateUserInterface
{
//    BOOL shouldUpdate = NO;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"%f", scrollView.contentOffset.x);
}


@end
