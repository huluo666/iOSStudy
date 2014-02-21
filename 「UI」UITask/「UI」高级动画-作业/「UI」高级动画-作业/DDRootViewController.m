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
        _imageNameList = [@[] mutableCopy];
        for (int i = 0; i < 4; i++) {
            [_imageNameList addObject:[NSString stringWithFormat:@"i%d.png", i + 1]];
        }
        
        _imageViews = [@[] mutableCopy];
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
    [self performSelector:@selector(startAnimation) withObject:nil afterDelay:1.0f];
}

- (void)updateImages
{
    UIImageView *obj = _imageViews[0];
    NSLog(@"obj0 remove = %@", obj);
    [_imageViews removeObjectAtIndex:0];
    [_imageViews addObject:obj];
    
    [self performSelector:@selector(startAnimation) withObject:nil afterDelay:1.0f];
}

- (void)startAnimation
{
    for (int i = 0; i < _imageViews.count; i++) {
        CGPoint center = ((UIImageView *)_imageViews[i]).center;
        [UIView animateWithDuration:1.0f animations:^{
            NSLog(@"obj0 add = %@", _imageViews[0]);
            // 向右移动动画
            ((UIImageView *)_imageViews[i]).center = CGPointMake(center.x + 320, center.y);
        } completion:^(BOOL finished) {
            // 移动完成后，坐标还原
            ((UIImageView *)_imageViews[i]).center = center;
            // 更行图片显示
            [self updateImages];
        }];
    }
    
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
        UIImage *imageName = [UIImage imageNamed:_imageNameList[i]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:imageName];
        imageView.frame = CGRectMake(width - 320 * i, 400, 140, 160);
        [self.view addSubview:imageView];
        [_imageViews addObject:imageView];
        [imageView release];
    }
}



@end
