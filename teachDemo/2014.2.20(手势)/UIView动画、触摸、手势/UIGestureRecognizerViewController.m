//
//  UIGestureRecognizerViewController.m
//  demotest
//
//  Created by 张鹏 on 14-2-10.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "UIGestureRecognizerViewController.h"

@interface UIGestureRecognizerViewController () {
    
    UIView *_gestureView;
    UILabel *_gestureDisplay;
}

- (void)initializeUserInterface;
- (void)processgestureReconizer:(UIGestureRecognizer *)gesture;
- (void)positionAnimationWithDirection:(UISwipeGestureRecognizerDirection)direction;

@end

@implementation UIGestureRecognizerViewController

- (id)init {
    
    self = [super init];
    if (self) {
        
        self.title = @"UIGestureRecognizer";
        
    }
    return self;
}

- (void)dealloc {
    
    [_gestureView    release];
    [_gestureDisplay release];
    
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
    
    _gestureView = [[UIView alloc] init];
    _gestureView.bounds = CGRectMake(0, 0, 200, 200);
    _gestureView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    _gestureView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_gestureView];
    
    _gestureDisplay = [[UILabel alloc] init];
    _gestureDisplay.bounds = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 44);
    _gestureDisplay.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMinY(self.view.bounds) + 100);
    _gestureDisplay.textAlignment = NSTextAlignmentCenter;
    _gestureDisplay.font = [UIFont systemFontOfSize:25];
    _gestureDisplay.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_gestureDisplay];
    
    // 左滑
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(processgestureReconizer:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipe];
    [leftSwipe release];
    
    // 右滑
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc]
                                            initWithTarget:self
                                            action:@selector(processgestureReconizer:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipe];
    [rightSwipe release];
    
    // 单击
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]
                                         initWithTarget:self
                                         action:@selector(processgestureReconizer:)];
    singleTap.numberOfTapsRequired = 1;
    [_gestureView addGestureRecognizer:singleTap];
    [singleTap release];
    
    // 双击
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]
                                         initWithTarget:self
                                         action:@selector(processgestureReconizer:)];
    doubleTap.numberOfTapsRequired = 2;
    [_gestureView addGestureRecognizer:doubleTap];
    [doubleTap release];
    
    // 当双击手势失败时，判断为单击手势
    [singleTap requireGestureRecognizerToFail:doubleTap];
    
    // 拖拽
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(processgestureReconizer:)];
    [_gestureView addGestureRecognizer:pan];
    [pan release];
    
    // 缩放
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(processgestureReconizer:)];
    [_gestureView addGestureRecognizer:pinch];
    [pinch release];
    
    // 旋转
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc]
                                             initWithTarget:self
                                             action:@selector(processgestureReconizer:)];
    [_gestureView addGestureRecognizer:rotation];
    [rotation release];
    
    // 长按
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                               initWithTarget:self
                                               action:@selector(processgestureReconizer:)];
    longPress.minimumPressDuration = 2.0;
    [_gestureView addGestureRecognizer:longPress];
    [longPress release];
}

- (void)processgestureReconizer:(UIGestureRecognizer *)gesture {
    
    // 滑动
    if ([gesture isKindOfClass:[UISwipeGestureRecognizer class]]) {
        UISwipeGestureRecognizer *swipe = (UISwipeGestureRecognizer *)gesture;
        _gestureDisplay.text = swipe.direction == UISwipeGestureRecognizerDirectionLeft ? @"左滑" : @"右滑";
        [self positionAnimationWithDirection:swipe.direction];
    }
    // 点击
    else if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
        UITapGestureRecognizer *tap = (UITapGestureRecognizer *)gesture;
        _gestureDisplay.text = tap.numberOfTapsRequired == 1 ? @"单击" : @"双击";
        _gestureView.transform = CGAffineTransformIdentity;
    }
    // 拖拽
    else if ([gesture isKindOfClass:[UIPanGestureRecognizer class]]) {
        _gestureDisplay.text = @"拖拽手势";
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gesture;
        static CGPoint startCenter;
        if (pan.state == UIGestureRecognizerStateBegan) {
            startCenter = _gestureView.center;
        }
        else if (pan.state == UIGestureRecognizerStateChanged) {
            // 此处必须从self.view中获取translation，因为translation和view的transform属性挂钩，若transform改变了则translation也会变
            CGPoint translation = [pan translationInView:self.view];
            _gestureView.center = CGPointMake(startCenter.x + translation.x, startCenter.y + translation.y);
        }
        else if (pan.state == UIGestureRecognizerStateEnded) {
            startCenter = CGPointZero;
        }
    }
    // 缩放
    else if ([gesture isKindOfClass:[UIPinchGestureRecognizer class]]) {
        _gestureDisplay.text = @"缩放手势";
        UIPinchGestureRecognizer *pinch = (UIPinchGestureRecognizer *)gesture;
        static CGFloat startScale;
        if (pinch.state == UIGestureRecognizerStateBegan) {
            startScale = pinch.scale;
        }
        else if (pinch.state == UIGestureRecognizerStateChanged) {
            CGFloat scale = (pinch.scale - startScale) / 2 + 1;
            _gestureView.transform = CGAffineTransformScale(_gestureView.transform, scale, scale);
            startScale = pinch.scale;
        }
        else if (pinch.state == UIGestureRecognizerStateEnded) {
            startScale = 1;
        }
    }
    // 旋转
    else if ([gesture isKindOfClass:[UIRotationGestureRecognizer class]]) {
        _gestureDisplay.text = @"旋转手势";
        UIRotationGestureRecognizer *rotate = (UIRotationGestureRecognizer *)gesture;
        static CGFloat startRotation;
        if (rotate.state == UIGestureRecognizerStateBegan) {
            startRotation = rotate.rotation;
        }
        else if (rotate.state == UIGestureRecognizerStateChanged) {
            CGFloat rotation = (rotate.rotation - startRotation) / 2;
            _gestureView.transform = CGAffineTransformRotate(_gestureView.transform, rotation);
            startRotation = rotate.rotation;
        }
        else if (rotate.state == UIGestureRecognizerStateEnded) {
            startRotation = 0;
        }
    }
    // 长按
    else if ([gesture isKindOfClass:[UILongPressGestureRecognizer class]] &&
             gesture.state == UIGestureRecognizerStateBegan) {
        _gestureDisplay.text = @"长按手势";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"长按手势"
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

- (void)positionAnimationWithDirection:(UISwipeGestureRecognizerDirection)direction {
    
    CGPoint center = direction == UISwipeGestureRecognizerDirectionLeft ?
                                  CGPointMake(CGRectGetMinX(self.view.bounds) + CGRectGetMidX(_gestureView.bounds),
                                              CGRectGetMidY(_gestureView.frame)) :
                                  CGPointMake(CGRectGetMaxX(self.view.bounds) - CGRectGetMidX(_gestureView.bounds),
                                              CGRectGetMidY(_gestureView.frame));
    [UIView animateWithDuration:1.0 animations:^{
        _gestureView.center = center;
    }];
}

@end
