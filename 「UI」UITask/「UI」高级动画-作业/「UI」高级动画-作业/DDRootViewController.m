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

@property (retain, nonatomic) NSMutableArray *hintImageNameList;
@property (retain, nonatomic) UIImageView *hintImageView;

- (void)initUserInterface;
// 开始动画
- (void)startAnimation;
// 更新显示图片
- (void)updateImages;

// 提示图片动画
- (void)startHintImageViewAnition;
// 将提示图片移走
- (void)hintImageViewGone;

// 展示图片向右移动
- (void)translationImageViewToLeft;


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
        _hintImageNameList = [[NSMutableArray alloc] init];
        for (int i = 0; i < 4; i++) {
            [_imageNameList addObject:[NSString stringWithFormat:@"i%d.png", i + 1]];
            [_hintImageNameList addObject:[NSString stringWithFormat:@"b%d.png", i + 1]];
        }

        _imageViews = [[NSMutableArray alloc] init];
        _hintImageView = [[UIImageView alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [_imageNameList release];
    [_imageViews release];
    [_hintImageNameList release];
    [_hintImageView release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUserInterface];
    [self startAnimation];
    
    NSLog(@"%@", self.view.subviews);
}

- (void)translationImageViewToLeft
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

- (void)hintImageViewGone
{
    [UIView animateWithDuration:0.5f animations:^{
        _hintImageView.center = CGPointMake(1024 + 150, 768 + 100);
    } completion:^(BOOL finished) {
        _hintImageView.transform = CGAffineTransformIdentity;
        _hintImageView.alpha = 1;

        // 更新提示图片名字列表顺序
        NSString *firstHintImaeName =  _hintImageNameList[0];
        [_hintImageNameList removeObjectAtIndex:0];
        [_hintImageNameList addObject:firstHintImaeName];
        // 将更新后的提示图片按顺序放上去
        UIImage *image = [UIImage imageNamed:_hintImageNameList[0]];
        _hintImageView.image = image;
    }];
}

- (void)goBottom
{
    [UIView animateWithDuration:1.5f animations:^{
        _hintImageView.center = CGPointMake(760, 520);
        _hintImageView.transform = CGAffineTransformScale(_hintImageView.transform, 0.5, 0.5);
        _hintImageView.alpha = 0.7;
    } completion:^(BOOL finished) {
        // 移出课件视图
        [self performSelector:@selector(hintImageViewGone)];
    }];
}

- (void)startHintImageViewAnition
{
    // 位置还原
    _hintImageView.center = CGPointMake(460, -250);
    _hintImageView.transform = CGAffineTransformRotate(_hintImageView.transform, M_PI_4);
    [UIView animateWithDuration:1.0f animations:^{
        // 掉下来
        _hintImageView.center = CGPointMake(460, 250);
        _hintImageView.transform = CGAffineTransformRotate(_hintImageView.transform, -M_PI_4);
    } completion:^(BOOL finished) {
        // 到底部
        [self performSelector:@selector(goBottom) withObject:nil afterDelay:3.0f];
    }];
}

- (void)updateImages
{
    // 更新图片名字列表顺序
    NSString *firstImageName = _imageNameList[0];
    [_imageNameList removeObjectAtIndex:0];
    [_imageNameList addObject:firstImageName];
    // 将更新后的图片按顺序放上去
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
        imageView.transform = CGAffineTransformScale(imageView.transform, 2.5, 2.5);
    } completion:^(BOOL finished) {
        [self performSelector:@selector(transformIdentity)
                   withObject:nil
                   afterDelay:3.0f];
    }];
}

- (void)startAnimation
{
    // 放大显示图片
    [self scaleImageView];
    [self startHintImageViewAnition];
    // 移动图片
    [self performSelector:@selector(translationImageView)
               withObject:nil
               afterDelay:4.5f];
}

- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 这是底图
    UIImageView *bgImageView = [[UIImageView alloc]
                                initWithImage:[UIImage imageNamed:@"bg.jpg"]];
    bgImageView.frame = CGRectMake(0, 0, 1024, 768);
    bgImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:bgImageView];
    [bgImageView release];
    
    // 放UIImageView上去
    CGFloat screenHeight = self.view.frame.size.height;
    
    for (int i = 0; i < 4; i++) {
        UIImage *image = [UIImage imageNamed:_imageNameList[i]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        imageView.frame = CGRectMake(screenHeight - 320 * (i + 1), 470, 140, 160);
        imageView.layer.anchorPoint = CGPointMake(0.5, 1);
        [self.view addSubview:imageView];
        [_imageViews addObject:imageView];
        [imageView release];
    }
    
    // 提示图片
    UIImage *hintImage = [UIImage imageNamed:_hintImageNameList[0]];
    _hintImageView = [[UIImageView alloc] initWithImage:hintImage];
    _hintImageView.frame = CGRectMake(310, - 150, 300, 200);
    [self.view addSubview:_hintImageView];
    [_hintImageView release];
    
    // 提示图片切换到第二个展示图片的后面
    [self.view exchangeSubviewAtIndex:2 withSubviewAtIndex:5];
}



@end
