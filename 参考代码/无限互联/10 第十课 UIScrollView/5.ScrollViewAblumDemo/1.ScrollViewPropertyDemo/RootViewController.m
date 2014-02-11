//
//  RootViewController.m
//  1.ScrollViewPropertyDemo
//
//  Created by 周泉 on 13-2-28.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G开发培训中心. All rights reserved.
//

#import "RootViewController.h"
#import "ImageScrollView.h"

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
	
    // base scrollView
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 340, 460)];
    _scrollView.backgroundColor = [UIColor blackColor];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.tag = INT_MAX;
    _scrollView.showsHorizontalScrollIndicator = NO;
    // 设置内容大小
    _scrollView.contentSize = CGSizeMake(340*4, 460);
    [self.view addSubview:_scrollView];
    
    int _x = 0;
    for (int index = 0; index < 4; index++) {
        ImageScrollView *imgScrollView = [[ImageScrollView alloc] initWithFrame:CGRectMake(0+_x, 0, 320, 460)];
        imgScrollView.tag = index;
        NSString *imgName = [NSString stringWithFormat:@"%d.jpg", index+1];
        imgScrollView.imageView.image = [UIImage imageNamed:imgName];
        [_scrollView addSubview:imgScrollView];
        _x += 340;
    }
    
}

int pre = 0;
#pragma mark - UIScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int current = scrollView.contentOffset.x / 340;
    
    ImageScrollView *imgScrollView = (ImageScrollView *)[scrollView viewWithTag:pre];
    if (current != pre && imgScrollView.zoomScale > 1) {
        imgScrollView.zoomScale = 1;
    }
    
    pre = current;
}

/*
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
}*/

- (void)dealloc
{
    [_scrollView release];
    [_imageView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
