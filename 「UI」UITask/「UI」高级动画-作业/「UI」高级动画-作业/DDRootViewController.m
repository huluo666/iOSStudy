//
//  DDRootViewController.m
//  「UI」高级动画-作业
//
//  Created by 萧川 on 14-2-21.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "DDRootViewController.h"

@interface DDRootViewController ()

@property (retain, nonatomic) NSMutableArray *imageNameList;
@property (retain, nonatomic) NSMutableArray *imageViews;

- (void)initUserInterface;
// 开始动画
- (void)startAnimation;
// 更新显示图片
- (void)updateImages;

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
        _imageNameList = [[NSMutableArray alloc] init];
        for (int i = 0; i < 4; i++) {
            [_imageNameList addObject:[NSString stringWithFormat:@"i%d.png", i + 1]];
        }
        
        _imageViews = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [_imageNameList release];
    [_imageViews release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUserInterface];
    [self startAnimation];
}

- (void)updateImages
{
    // 更新图片名字列表顺序
    NSString *firstImageName = _imageNameList[0];
    [_imageNameList removeObjectAtIndex:0];
    [_imageNameList addObject:firstImageName];
    
    // 将更新后的图片顺序放上去
    for (int i = 0; i < 4; i++) {
        UIImage *image = [UIImage imageNamed:_imageNameList[i]];
        ((UIImageView *)_imageViews[i]).image = image;
    }
    
    // 循环调用动画
    [self performSelector:@selector(startAnimation) withObject:nil afterDelay:2.0f];
}

- (void)translationImageView
{
    [UIView animateWithDuration:1.0f animations:^{
        // 所有坐标向右移动一格
        for (UIImageView *imageView in _imageViews) {
            CGPoint center = imageView.center;
            imageView.center = CGPointMake(center.x + 320, center.y);
        }
    } completion:^(BOOL finished) {
        // 所有坐标向左移动回来
        for (UIImageView *imageView in _imageViews) {
            CGPoint center = imageView.center;
            imageView.center = CGPointMake(center.x - 320, center.y);
        }
        
        // 更新图片显示
        [self updateImages];
    }];
}

- (void)transformIdentity
{
    UIImageView *imageView = (UIImageView *)_imageViews[0];
    [UIView animateWithDuration:1.0f animations:^{
        imageView.transform = CGAffineTransformIdentity;
    }];
}

- (void)scaleImageView
{
    UIImageView *imageView = (UIImageView *)_imageViews[0];
    [UIView animateWithDuration:1.0f animations:^{
        imageView.transform = CGAffineTransformScale(imageView.transform, 2, 2);
    } completion:^(BOOL finished) {
        [self performSelector:@selector(transformIdentity) withObject:nil afterDelay:1.5f];
    }];
}

- (void)startAnimation
{
    // 放大显示图片
    [self scaleImageView];
    
    // 移动图片
    [self performSelector:@selector(translationImageView) withObject:nil afterDelay:3.5f];
}

- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 这是底图
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.jpg"]];
    bgImageView.frame = CGRectMake(0, 0, 1024, 768);
    bgImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:bgImageView];
    [bgImageView release];
    
    // 放UIImageView上去
    CGFloat width = self.view.frame.size.width;
    
    for (int i = 0; i < 4; i++) {
        UIImage *image = [UIImage imageNamed:_imageNameList[i]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(width - 320 * i, 470, 140, 160);
        imageView.layer.anchorPoint = CGPointMake(0.5, 1);
        [self.view addSubview:imageView];
        [_imageViews addObject:imageView];
        [imageView release];
    }
}



@end
