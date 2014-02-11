//
//  TouchView.m
//  TouchPinch
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
        //开启多点触摸
        self.multipleTouchEnabled = YES;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([touches count] == 2) {
        NSArray *touchArray = [touches allObjects];
        UITouch *firstTouch = [touchArray objectAtIndex:0];
        UITouch *secondTouch = [touchArray objectAtIndex:1];
        
        CGPoint point1 = [firstTouch locationInView:self];
        CGPoint point2 = [secondTouch locationInView:self];
        
        double distance = [self distance:point1 point:point2];
        NSLog(@"%f",distance);
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([touches count] == 2) {
        NSArray *touchArray = [touches allObjects];
        UITouch *firstTouch = [touchArray objectAtIndex:0];
        UITouch *secondTouch = [touchArray objectAtIndex:1];
        
        CGPoint point1 = [firstTouch locationInView:self];
        CGPoint point2 = [secondTouch locationInView:self];
        
        //当前两点的距离
        double distance = [self distance:point1 point:point2];
        
        float subValue = distance-lastValue;
        if (subValue > 0) {
            NSLog(@"放大捏合");
        }else {
            NSLog(@"缩小捏合");
        }
        
        lastValue = distance;
    }
}


- (double)distance:(CGPoint)p1 point:(CGPoint)p2 {
    // ((x1-x2)平方+(y1-y2)平方)开方
    double distnce = sqrt(pow(p1.x-p2.x, 2)+pow(p1.y-p2.y, 2));
    return distnce;
}

@end
