//
//  UIViewAnimationViewController.m
//  demotest
//
//  Created by 张鹏 on 14-2-10.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "UIViewAnimationViewController.h"
#import "UIImageViewAnimationViewController.h"

@interface UIViewAnimationViewController () {
    
    UIButton *_button;
}

- (void)initializeUserInterface;

- (void)buttonPressed:(UIButton *)sender;
- (void)barButtonPressed:(UIBarButtonItem *)sender;

// UIView动画事务一般生成
- (void)positionAnimation;
- (void)scaleAnimation;
- (void)rotateAnimation;
- (void)colorAnimation;
- (void)alphaAnimation;
- (void)endAnimation;

// UIView动画事务一般生成回调方法
- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;

// UIView动画事务基于代码块生成
- (void)blockBasedPositionAnimation;
- (void)blockBasedScaleAnimation;
- (void)blockBasedRotateAnimation;
- (void)blockBasedColorAnimation;
- (void)blockBasedAlphaAnimation;
- (void)blockBasedEndAnimation;

@end

@implementation UIViewAnimationViewController

- (id)init {
    
    self = [super init];
    if (self) {
        
        self.title = @"UIView Animation";
    }
    return self;
}

- (void)dealloc {
    
    [_button release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initializeUserInterface];
}

- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];

    _button = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    _button.bounds = CGRectMake(0, 0, 100, 100);
    _button.center = CGPointMake(CGRectGetMinX(self.view.bounds) + CGRectGetMidX(_button.bounds),
                                 CGRectGetMinY(self.view.bounds) + 64 + CGRectGetMidY(_button.bounds));
    _button.backgroundColor = [UIColor blackColor];
    [_button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
    
    UIBarButtonItem *nextItem = [[UIBarButtonItem alloc]
                                 initWithTitle:@"Next"
                                 style:UIBarButtonItemStylePlain
                                 target:self
                                 action:@selector(barButtonPressed:)];
    self.navigationItem.rightBarButtonItem = nextItem;
    [nextItem release];
}

- (void)buttonPressed:(UIButton *)sender {
    
    // UIView动画事务一般生成
    [self positionAnimation];
    
    // UIView动画事务基于代码块生成
//    [self blockBasedPositionAnimation];
}

- (void)barButtonPressed:(UIBarButtonItem *)sender {
    
    UIImageViewAnimationViewController *vc = [[UIImageViewAnimationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

#pragma mark - Normal animation method

- (void)positionAnimation {
    
    [UIView beginAnimations:@"position" context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    _button.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    [UIView commitAnimations];
}

- (void)scaleAnimation {
    
    [UIView beginAnimations:@"scale" context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    _button.transform = CGAffineTransformScale(_button.transform, 2.0, 2.0);
    [UIView commitAnimations];
}

- (void)rotateAnimation {
    
    [UIView beginAnimations:@"rotate" context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    _button.transform = CGAffineTransformRotate(_button.transform, M_PI_2);
    [UIView commitAnimations];
}

- (void)colorAnimation {
    
    [UIView beginAnimations:@"color" context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    _button.backgroundColor = [UIColor redColor];
    [UIView commitAnimations];
}

- (void)alphaAnimation {
    
    [UIView beginAnimations:@"alpha" context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    _button.alpha = 0.5;
    [UIView commitAnimations];
}

- (void)endAnimation {
    
    [UIView beginAnimations:@"end" context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:_button cache:NO];
    _button.center = CGPointMake(CGRectGetMinX(self.view.bounds) + CGRectGetMidX(_button.bounds),
                                 CGRectGetMinY(self.view.bounds) + 64 + CGRectGetMidY(_button.bounds));
    _button.transform = CGAffineTransformIdentity;
    _button.alpha = 1.0;
    _button.backgroundColor = [UIColor blackColor];
    [UIView commitAnimations];
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
    if ([animationID isEqualToString:@"position"]) {
        [self scaleAnimation];
    }
    else if ([animationID isEqualToString:@"scale"]) {
        [self rotateAnimation];
    }
    else if ([animationID isEqualToString:@"rotate"]) {
        [self colorAnimation];
    }
    else if ([animationID isEqualToString:@"color"]) {
        [self alphaAnimation];
    }
    else if ([animationID isEqualToString:@"alpha"]){
        [self endAnimation];
    }
}

#pragma mark - Block based animation method

- (void)blockBasedPositionAnimation {
    
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _button.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    } completion:^(BOOL finished) {
        [self blockBasedScaleAnimation];
    }];
}

- (void)blockBasedScaleAnimation {
    
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _button.transform = CGAffineTransformScale(_button.transform, 2.0, 2.0);
    } completion:^(BOOL finished) {
        [self blockBasedRotateAnimation];
    }];
}

- (void)blockBasedRotateAnimation {
    
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _button.transform = CGAffineTransformRotate(_button.transform, M_PI_2);
    } completion:^(BOOL finished) {
        [self blockBasedColorAnimation];
    }];
}

- (void)blockBasedColorAnimation {
    
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _button.backgroundColor = [UIColor redColor];
    } completion:^(BOOL finished) {
        [self blockBasedAlphaAnimation];
    }];
}

- (void)blockBasedAlphaAnimation {
    
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _button.alpha = 0.5;
    } completion:^(BOOL finished) {
        [self blockBasedEndAnimation];
    }];
}

- (void)blockBasedEndAnimation {
    
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:_button cache:NO];
        _button.center = CGPointMake(CGRectGetMinX(self.view.bounds) + CGRectGetMidX(_button.bounds),
                                     CGRectGetMinY(self.view.bounds) + 64 + CGRectGetMidY(_button.bounds));
        _button.transform = CGAffineTransformIdentity;
        _button.alpha = 1.0;
        _button.backgroundColor = [UIColor blackColor];
    } completion:^(BOOL finished) {
        
    }];
}


@end
