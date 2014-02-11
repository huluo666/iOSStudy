//
//  TouchView.m
//  TouchDemo
//
//  Created by wei.chen on 13-2-28.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "TouchView.h"

@implementation TouchView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.multipleTouchEnabled = YES;
        
        movieView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        movieView.backgroundColor = [UIColor redColor];
        [self addSubview:movieView];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    NSLog(@"touchesBegan");
    
    
    //--------------------单击、双击----------------------
    UITouch *touch = [touches anyObject];
    NSUInteger tapCount = touch.tapCount;
//    NSLog(@"%d",tapCount);
    
    if (tapCount == 1) {
        [self performSelector:@selector(singleTap) withObject:nil afterDelay:0.5];
        
    }
    else if(tapCount == 2) {
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(singleTap) object:nil];
        
        [self doubleTap];
    }
    
    
    CGPoint point = [touch locationInView:self];
    NSLog(@"%@",NSStringFromCGPoint(point));
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    NSLog(@"touchesMoved");
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGRect frame = movieView.frame;
    frame.origin = point;
    
    movieView.frame = frame;
}

//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    NSLog(@"touchesEnded");
//}
//
//- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
//    NSLog(@"touchesCancelled");
//}

- (void)singleTap {
    NSLog(@"单击");
}

- (void)doubleTap {
    NSLog(@"双击");
}

@end
