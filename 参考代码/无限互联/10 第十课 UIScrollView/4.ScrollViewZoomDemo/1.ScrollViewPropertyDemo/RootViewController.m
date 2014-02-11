//
//  RootViewController.m
//  1.ScrollViewPropertyDemo
//
//  Created by 周泉 on 13-2-28.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G开发培训中心. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.delegate = self;
    // 设置内容大小
    scrollView.contentSize = CGSizeMake(320, 460);
    scrollView.minimumZoomScale = 0.5;
    // 缩放时，是否存在反弹效果
//    scrollView.bouncesZoom = NO;
    scrollView.maximumZoomScale = 2;
    [self.view addSubview:scrollView];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    _imageView.image = [UIImage imageNamed:@"1.jpg"];
    [scrollView addSubview:_imageView];
    
}

#pragma mark - UIScrollView Delegate
// 返回一个放大或者缩小的视图
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}
// 开始放大或者缩小
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:
(UIView *)view
{
    NSLog(@"scrollViewWillBeginZooming");
}

// 缩放结束时
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    NSLog(@"scrollViewDidEndZooming : %f", scale);
}
 
// 视图已经放大或缩小
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidZoom");
}

- (void)dealloc
{
    [scrollView release];
    [_imageView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
