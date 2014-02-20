//
//  UIImageViewAnimationViewController.m
//  demotest
//
//  Created by 张鹏 on 14-2-10.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "UIImageViewAnimationViewController.h"
#import "UIGestureRecognizerViewController.h"

@interface UIImageViewAnimationViewController () {
    
    UIImageView *_imageView;
}

- (void)initializeUserInterface;

- (void)barButtonPressed:(UIBarButtonItem *)sender;

- (void)changeImageViewAnimationState;
- (void)pushToNext;

@end

@implementation UIImageViewAnimationViewController

- (id)init {
    
    self = [super init];
    if (self) {
        
        self.title = @"UIImageView Animation";
        
    }
    return self;
}

- (void)dealloc {
    
    [_imageView release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initializeUserInterface];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.toolbarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.navigationController.toolbarHidden = YES;
    
    if (_imageView.isAnimating) {
        [self changeImageViewAnimationState];
    }
}

- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:138];
    for (int i = 0; i < 138; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%d.png", i];
        UIImage *image = [UIImage imageWithContentsOfFile:
                          [[NSBundle mainBundle] pathForAuxiliaryExecutable:imageName]];
        [images addObject:image];
    }
    
    _imageView = [[UIImageView alloc] init];
    _imageView.bounds = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetWidth(self.view.bounds));
    _imageView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    _imageView.userInteractionEnabled = YES;
    _imageView.animationDuration = 5.0;
    _imageView.animationImages = images;
    _imageView.animationRepeatCount = 0;
    [_imageView startAnimating];
    [self.view addSubview:_imageView];
    
    UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc]
                                     initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                     target:nil
                                     action:NULL];
    
    UIBarButtonItem *actionItem = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Stop Animating"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(barButtonPressed:)];
    actionItem.tag = 10;
    self.toolbarItems = @[flexibleItem, actionItem, flexibleItem];
    [flexibleItem release];
    [actionItem   release];
    
    UIBarButtonItem *nextItem = [[UIBarButtonItem alloc]
                                 initWithTitle:@"Next"
                                 style:UIBarButtonItemStylePlain
                                 target:self
                                 action:@selector(barButtonPressed:)];
    nextItem.tag = 11;
    self.navigationItem.rightBarButtonItem = nextItem;
    [nextItem release];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    if (touch.view == _imageView) {
        CGPoint previousLocation = [touch previousLocationInView:_imageView];
        CGPoint currentLocation = [touch locationInView:_imageView];
        CGPoint offset = CGPointMake(currentLocation.x - previousLocation.x, currentLocation.y - previousLocation.y);
        _imageView.center = CGPointMake(_imageView.center.x + offset.x, _imageView.center.y + offset.y);
    }
}

- (void)barButtonPressed:(UIBarButtonItem *)sender {
    
    NSInteger index = sender.tag - 10;
    if (index == 0) {
        [self changeImageViewAnimationState];
    }
    else {
        [self pushToNext];
    }
}

- (void)changeImageViewAnimationState {
    
    UIBarButtonItem *actionItem = (UIBarButtonItem *)self.toolbarItems[1];
    if (_imageView.isAnimating) {
        [_imageView stopAnimating];
        actionItem.title = @"Start Animating";
    }
    else {
        [_imageView startAnimating];
        actionItem.title = @"Stop Animating";
    }

}

- (void)pushToNext {
    
    UIGestureRecognizerViewController *vc = [[UIGestureRecognizerViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

@end
