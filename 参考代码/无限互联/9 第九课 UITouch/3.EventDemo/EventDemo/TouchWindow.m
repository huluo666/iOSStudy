//
//  TouchWindow.m
//  EventDemo
//
//  Created by wei.chen on 13-3-1.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "TouchWindow.h"

@implementation TouchWindow

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//分发事件
- (void)sendEvent:(UIEvent *)event {
    [super sendEvent:event];
}

//事件的响应
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"TouchWindow touchesBegan");
    
    [self.nextResponder touchesBegan:touches withEvent:event];
}

@end
