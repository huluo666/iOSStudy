//
//  AnimationViewController.m
//  「UI」动画、触摸、手势(day05)
//
//  Created by cuan on 14-2-11.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "AnimationViewController.h"
#import "TouchViewController.h"

@interface AnimationViewController ()

@property (retain, nonatomic) UIButton *butotn;

- (void)initUserInterface;
- (void)nextButtonPressed;
- (void)buttonPressed:(UIButton *)sender;

- (void)positionAnimationm; // 平移
- (void)scaleAnimation;     // 放大
- (void)rotateAnimation;    // 旋转
- (void)colorAnimation;     // 颜色
- (void)alphaAnimation;     // 透明度
- (void)endAnimation;       // 结束动画

- (void)animationDidStop:(NSString *)animationID
                finished:(NSNumber *)finished
                 context:(void *)context;

- (void)positionAnimationmBaseBlock; // 平移
- (void)scaleAnimationBaseBlock;     // 放大
- (void)rotateAnimationBaseBlock;    // 旋转
- (void)colorAnimationBaseBlock;     // 颜色
- (void)alphaAnimationBaseBlock;     // 透明度
- (void)endAnimationBaseBlock;       // 结束动画

@end

@implementation AnimationViewController

- (void)dealloc
{
    [_butotn release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (id)init
{
    if (self = [super init])
    {
        self.title = @"UIView Animation";
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUserInterface];
    
}

- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *next = [[UIBarButtonItem alloc]
                             initWithTitle:@"Next"
                             style:UIBarButtonItemStylePlain
                             target:self
                             action:@selector(nextButtonPressed)];
    self.navigationItem.rightBarButtonItem = next;
    [next release];
    
    _butotn = [UIButton buttonWithType:UIButtonTypeCustom];
    _butotn.bounds = CGRectMake(0, 0, 100, 100);
    _butotn.center = CGPointMake(CGRectGetMinX(self.view.bounds) + CGRectGetMidX(_butotn.bounds),
                                 CGRectGetMinY(self.view.bounds) + CGRectGetMidY(_butotn.bounds) + 66);
    _butotn.backgroundColor = [UIColor blackColor];
    [_butotn addTarget:self
                action:@selector(buttonPressed:)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_butotn];
    
}

- (void)buttonPressed:(UIButton *)sender
{
//    [self positionAnimationm];
    [self positionAnimationmBaseBlock];
    
}

#pragma mark - 动画效果方法

- (void)positionAnimationm
{
//    [UIView animateWithDuration:0.7f animations:^{
//        _butotn.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame));
//    }];
    [UIView beginAnimations:@"position" context:NULL];
    // 持续时间
    [UIView setAnimationDuration:1.0f];
    // 线性规律
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    // 代理对象
    [UIView setAnimationDelegate:self];
    // 回掉方法
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    // 配置动画(放到提交动画前) 对于视图同一属性，只能配置一次，不能重复配置
    _butotn.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame));
    // 提交动画
    [UIView commitAnimations];
}

- (void)scaleAnimation
{
    [UIView beginAnimations:@"scale" context:NULL];
    [UIView setAnimationDuration:1.0f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];

    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
//    _butotn.transform = CGAffineTransformMakeScale(-2, -2); // 旋转放大
    _butotn.transform = CGAffineTransformScale(_butotn.transform, 2, 2); // 基于视图原始纺射变幻缩放
    [UIView commitAnimations];
}

- (void)rotateAnimation
{
    [UIView beginAnimations:@"rotate" context:NULL];
    [UIView setAnimationDuration:1.0f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
//    _butotn.transform = CGAffineTransformMakeRotation(M_PI_2); // 直接赋值，不会基于视图原有状态变换
    _butotn.transform = CGAffineTransformRotate(_butotn.transform, M_PI_2); // 基于视图当前状态变换，更行变换
    [UIView commitAnimations];

}

- (void)colorAnimation
{
    [UIView beginAnimations:@"color" context:NULL];
    [UIView setAnimationDuration:1.0f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    _butotn.backgroundColor = [UIColor redColor];
    [UIView commitAnimations];
}

- (void)alphaAnimation
{
    [UIView beginAnimations:@"alpha" context:NULL];
    [UIView setAnimationDuration:1.0f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    _butotn.alpha = 0.2;
    [UIView commitAnimations];
}

- (void)endAnimation
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.0f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    // 动画是否逆向执行
    [UIView setAnimationRepeatAutoreverses:YES];
    // 动画重复次数
    [UIView setAnimationRepeatCount:REPEAT_COUNT];
    
    _butotn.alpha = 1.0f;
    _butotn.center = CGPointMake(CGRectGetMinX(self.view.bounds) + CGRectGetMidX(_butotn.bounds),
                                 CGRectGetMinY(self.view.bounds) + CGRectGetMidY(_butotn.bounds) + 66);
    _butotn.backgroundColor = [UIColor blackColor];
    // 将视图的纺射变换属性清除
    _butotn.transform = CGAffineTransformIdentity;
    /* transform:一旦该属性不为CGAffineTransformIdentity，
     * 进行了一些变换后，frame属性未定义，尽量不要使用frame。
     * center可以使用 */
    // UIView转场动画
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft
                           forView:_butotn
                             cache:NO];
    
    [UIView commitAnimations];
}

- (void)nextButtonPressed
{
    TouchViewController *touchVC = [[TouchViewController alloc] init];
    [self.navigationController pushViewController:touchVC animated:YES];
    [touchVC release];
}

- (void)animationDidStop:(NSString *)animationID
                finished:(NSNumber *)finished
                 context:(void *)context
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    if ([animationID isEqualToString:@"position"])
    {
        [self scaleAnimation];
    }
    else if ([animationID isEqualToString:@"scale"])
    {
        [self rotateAnimation];
    }
    else if ([animationID isEqualToString:@"rotate"])
    {
        [self colorAnimation];
    }
    else if ([animationID isEqualToString:@"color"])
    {
        [self alphaAnimation];
    }
    else if ([animationID isEqualToString:@"alpha"])
    {
        [self endAnimation];
    }
}

#pragma mark - 基于bolck的动画效果方法

- (void)positionAnimationmBaseBlock
{
    [UIView animateWithDuration:1.0f animations:^{
        _butotn.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame));
    } completion:^(BOOL finished) {
        [self scaleAnimationBaseBlock];
    }];
}

- (void)scaleAnimationBaseBlock
{
    [UIView animateWithDuration:1.0f animations:^{
        _butotn.transform = CGAffineTransformScale(_butotn.transform, 2, 2);
    } completion:^(BOOL finished) {
        [self rotateAnimationBaseBlock];
    }];
}

- (void)rotateAnimationBaseBlock
{
    [UIView animateWithDuration:1.0f animations:^{
        _butotn.transform = CGAffineTransformRotate(_butotn.transform, M_PI_2);
    } completion:^(BOOL finished) {
        [self colorAnimationBaseBlock];
    }];
}

- (void)colorAnimationBaseBlock
{
    [UIView animateWithDuration:1.0f animations:^{
        _butotn.backgroundColor = [UIColor redColor];
    } completion:^(BOOL finished) {
        [self alphaAnimationBaseBlock];
    }];
}

- (void)alphaAnimationBaseBlock
{
    [UIView animateWithDuration:1.0f animations:^{
        _butotn.alpha = 0.2;
    } completion:^(BOOL finished) {
        [self endAnimationBaseBlock];
    }];
}

- (void)endAnimationBaseBlock
{
    [UIView animateWithDuration:1.0f animations:^{
        _butotn.alpha = 1.0f;
        _butotn.center = CGPointMake(CGRectGetMinX(self.view.bounds) + CGRectGetMidX(_butotn.bounds),
                                     CGRectGetMinY(self.view.bounds) + CGRectGetMidY(_butotn.bounds) + 66);
        _butotn.backgroundColor = [UIColor blackColor];
        _butotn.transform = CGAffineTransformIdentity;
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft
                               forView:_butotn
                                 cache:NO];
    }];
}

@end

