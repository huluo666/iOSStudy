//
//  DDRootViewController.m
//  [Demo]SotryboardContainer
//
//  Created by 萧川 on 14-4-20.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDRootViewController.h"

@interface DDRootViewController ()

@property (weak, nonatomic) IBOutlet UIView *leftMenuView;
@property (weak, nonatomic) IBOutlet UIView *mainUIView;

@property (assign, nonatomic, getter = isLeftMenuShow) BOOL leftMenuShow;

@end

@implementation DDRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    // add gestures
    UISwipeGestureRecognizer *swipRight = [[UISwipeGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(gestureAction:)];
    swipRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipRight];
    
    UISwipeGestureRecognizer *leftRight = [[UISwipeGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(gestureAction:)];
    leftRight.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftRight];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)gestureAction:(UISwipeGestureRecognizer *)gesture {
    
    CGPoint selfCenter = self.view.center;
    if (UISwipeGestureRecognizerDirectionRight == gesture.direction
        && !_leftMenuShow) {
        // swip right show the menu view
        [UIView animateWithDuration:1 animations:^{
            _mainUIView.center = CGPointMake(selfCenter.x * 2.8, selfCenter.y);
        } completion:^(BOOL finished) {
            _leftMenuShow = YES;
            _mainUIView.userInteractionEnabled = NO;
        }];
    } else if (UISwipeGestureRecognizerDirectionLeft == gesture.direction
               && _leftMenuShow) {
        // swip left close the menu view
        [UIView animateWithDuration:1 animations:^{
            _mainUIView.center = selfCenter;
        } completion:^(BOOL finished) {
            _leftMenuShow = NO;
            _mainUIView.userInteractionEnabled = YES;
        }];
    }
}

@end
