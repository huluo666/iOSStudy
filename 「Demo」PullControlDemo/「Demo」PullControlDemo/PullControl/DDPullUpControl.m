//
//  DDPullUpControl.m
//  「Demo」PullControlDemo
//
//  Created by 萧川 on 14-4-12.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDPullUpControl.h"

@interface DDPullUpControl ()

@property (nonatomic, retain) UIImageView *arrowView;
@property (nonatomic, retain) UIActivityIndicatorView *indicatorView;
@property (nonatomic, retain) UILabel *titleLabel;

@end

@implementation DDPullUpControl

- (void)dealloc {
    
    [[self scrollView] removeObserver:self forKeyPath:@"contentSize"];
    NSLog(@"%s", __FUNCTION__);
}

- (void)didMoveToSuperview {
    
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    CGFloat height = CGRectGetHeight([[UIScreen mainScreen] bounds]);
    CGFloat contentSizeHeight = self.scrollView.contentSize.height;
    
    CGFloat y = contentSizeHeight > height - 60 ? contentSizeHeight : height - 60;
    NSLog(@"y = %f", y);
    
    self.frame = CGRectMake(0, y, width, 60);
    
    _arrowView.bounds = CGRectMake(0, 0, 30, 30);
    _arrowView.center = CGPointMake(CGRectGetMidX(self.bounds) - kArrowDistancefromCenter,
                                    CGRectGetMidY(self.bounds));
    
    _indicatorView.frame = _arrowView.frame;
    
    _titleLabel.frame = self.bounds;
}

- (void)setState:(DDPullControlState)state {
    
    [super setState:state];
    
    switch(state) {
        case DDPullControlStateHidden:
        {
            _indicatorView.hidden = YES;
            [_indicatorView stopAnimating];
            _arrowView.hidden = NO;
        }
            break;
        case DDPullControlStatePullingUp:
        {
            self.titleLabel.text = @"Pulling Up";
            [UIView animateWithDuration:0.2 animations:^{
                _arrowView.transform = CGAffineTransformMakeRotation(0);
            }];
        }
            break;
        case DDPullControlStateOveredThreshold:
        {
            self.titleLabel.text = @"OveredThreshold";
            
            [UIView animateWithDuration:0.2 animations:^{
                _arrowView.transform = CGAffineTransformMakeRotation(M_PI);
            }];
        }
            break;
        case DDPullControlStateStoping:
        {
            _indicatorView.hidden = NO;
            [_indicatorView startAnimating];
            self.titleLabel.text = @"Stoping";
            _arrowView.hidden = YES;
        }
            break;
        default:
            break;
    }
}
//
//- (void)willMoveToSuperview:(UIView *)newSuperview {
//
//    [super willMoveToSuperview:newSuperview];
//    
//    if([self scrollView] != nil) {
//        [[self scrollView] removeObserver:self forKeyPath:@"contentSize"];
//    }
//    
//    if([newSuperview isKindOfClass:[UIScrollView class]]) {
//        [newSuperview addObserver:self
//                       forKeyPath:@"contentSize"
//                          options:NSKeyValueObservingOptionNew
//                          context:NULL];
//    }
//}
//
//#pragma mark - kvo
//
//// kvo monitor message
//- (void)observeValueForKeyPath:(NSString *)keyPath
//                      ofObject:(id)object
//                        change:(NSDictionary *)change
//                       context:(void *)context {
//    
//    if([keyPath isEqualToString:@"contentSize"]) {
//        UIScrollView *scrollView = (UIScrollView *)object;
//        
//        if(_dragging != scrollView.isDragging) {
//            if(!scrollView.isDragging) {
////                [self scrollViewDidEndDragging:scrollView willDecelerate:NO];
//            }
//            
//            _dragging = scrollView.isDragging;
//        }
//        
////        [self scrollViewDidScroll:scrollView];
//    }
//}

@end
