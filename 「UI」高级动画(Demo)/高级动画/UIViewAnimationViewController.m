//
//  UIViewAnmationViewController.m
//  高级动画
//
//  Created by 张鹏 on 14-2-20.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "UIViewAnimationViewController.h"

@interface UIViewAnimationViewController ()

- (void)initializeUserInterface;
- (void)startRevealAnimation;
- (UIImage *)creatScreenshot;

@end

@implementation UIViewAnimationViewController

- (id)init
{
    self = [super init];
    if (self) {
        
        self.title = NSStringFromClass([self class]);
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initializeUserInterface];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self startRevealAnimation];
}

- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.text = @"Animation";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:40];
    label.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label];
}

- (void)startRevealAnimation {
    
    UIImage *previousImage = [self creatScreenshot];
    self.view.backgroundColor = [UIColor specialRandomColor];
    UIImage *currentImage = [self creatScreenshot];
    
    CGRect bounds = self.view.bounds;
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:bounds];
    backgroundView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:backgroundView];
    
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:bounds];
    backImageView.image = currentImage;
    backImageView.contentMode = UIViewContentModeScaleAspectFill;
    [backgroundView addSubview:backImageView];
    
    UIImageView *leftImageView = [[UIImageView alloc]
                                  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(bounds) / 2, CGRectGetHeight(bounds))];
    leftImageView.image = previousImage;
    leftImageView.contentMode = UIViewContentModeLeft;
    leftImageView.clipsToBounds = YES;
    [backgroundView addSubview:leftImageView];
    
    UIImageView *rightImageView = [[UIImageView alloc]
                                   initWithFrame:CGRectMake(CGRectGetMaxX(leftImageView.frame), 0, CGRectGetWidth(bounds) / 2, CGRectGetHeight(bounds))];
    rightImageView.image = previousImage;
    rightImageView.contentMode = UIViewContentModeRight;
    rightImageView.clipsToBounds = YES;
    [backgroundView addSubview:rightImageView];
    
    backImageView.alpha = 0.5;
    backImageView.transform = CGAffineTransformMakeScale(0.7, 0.7);
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        leftImageView.center = CGPointMake(CGRectGetMinX(bounds) - CGRectGetWidth(leftImageView.bounds) / 2, CGRectGetMidY(bounds));
        rightImageView.center = CGPointMake(CGRectGetMaxX(bounds) + CGRectGetWidth(rightImageView.bounds) / 2, CGRectGetMidY(bounds));
    } completion:nil];
    [UIView animateWithDuration:1.0 delay:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        leftImageView.alpha = 0.7;
        rightImageView.alpha = 0.7;
        backImageView.alpha = 1.0;
        backImageView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
    
}

- (UIImage *)creatScreenshot {
    
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, 0);
//    [self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:YES];
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}

@end
