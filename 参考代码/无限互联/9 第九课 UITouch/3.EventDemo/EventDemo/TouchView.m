//
//  TouchView.m
//  EventDemo
//
//  Created by wei.chen on 13-3-1.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "TouchView.h"

@implementation TouchView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

//事件的响应
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"TouchView touchesBegan");
    
    //如果不进行处理，则将事件传递给下一个响应者
    [self.nextResponder touchesBegan:touches withEvent:event];
}

@end
