//
//  GraphicView.m
//  GraphicDemo
//
//  Created by wei.chen on 13-1-8.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "GraphicView.h"
#import <QuartzCore/QuartzCore.h>

@implementation GraphicView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        subView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        subView.backgroundColor = [UIColor orangeColor];
        [self addSubview:subView];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
//    //设置画线的颜色
//    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
//    //设置填充的颜色
//    CGContextSetFillColorWithColor(ctx, [UIColor greenColor].CGColor);
    
    [[UIColor redColor] setStroke];
    [[UIColor greenColor] setFill];
    
    
    //设置绘制线的宽度
    CGContextSetLineWidth(ctx, 2);
    
    //让画笔移动到某一点
    CGContextMoveToPoint(ctx, 10, 20);
    
    //添加一条线
    CGContextAddLineToPoint(ctx, 200, 20);
    //添加多个点组成多个线
//    CGContextAddLines(<#CGContextRef c#>, <#const CGPoint *points#>, <#size_t count#>)
    
    CGContextAddRect(ctx, CGRectMake(10, 40, 100, 100));
    
    
    CGContextAddCurveToPoint(ctx, 10, 10, 100, 200, 100, 50);
    
    //绘画
    CGContextDrawPath(ctx, kCGPathStroke);
//    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    //创建路径
    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathAddCurveToPoint(<#CGMutablePathRef path#>, <#const CGAffineTransform *m#>, <#CGFloat cp1x#>, <#CGFloat cp1y#>, <#CGFloat cp2x#>, <#CGFloat cp2y#>, <#CGFloat x#>, <#CGFloat y#>)
    CGPathAddRect(path, NULL, CGRectMake(10, 40, 100, 100));
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
    animation.repeatCount = 1000;
    animation.path = path;
    
    //为subView视图添加动画
    [subView.layer addAnimation:animation forKey:@"test"];
    
}

@end
