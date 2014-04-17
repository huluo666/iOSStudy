//
//  UITextField+Generate.m
//  面试职通车
//
//  Created by 萧川 on 14-4-17.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "UITextField+Generate.h"

@implementation UITextField (Generate)

- (id)initWithOrigin:(CGPoint)anOrigin
       textAlignment:(NSTextAlignment)theTextAlignment
            textSize:(float)aSize
           backImage:(UIImage *)anImage {
    
    CGRect frame = CGRectMake(anOrigin.x, anOrigin.y, anImage.size.width, anImage.size.height);
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.textAlignment = theTextAlignment;
        self.background = anImage;
        self.font = [UIFont systemFontOfSize:aSize];
    }
    
    return self;
}

+ (id)textFiedlWithOrigin:(CGPoint)anOrigin
            textAlignment:(NSTextAlignment)theTextAlignment
                 textSize:(float)aSize
                backImage:(UIImage *)anImage {
    
    return [[self alloc] initWithOrigin:anOrigin
                          textAlignment:theTextAlignment
                               textSize:aSize
                              backImage:anImage];
}


- (id)initWithOrigin:(CGPoint)anOrigin
       textAlignment:(NSTextAlignment)theTextAlignment
            textSize:(float)aSize
     backRetainImage:(UIImage *)backRetainImage {
    
    CGRect frame = CGRectMake(anOrigin.x,
                              anOrigin.y,
                              backRetainImage.size.width / 2,
                              backRetainImage.size.height / 2);
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.textAlignment = theTextAlignment;
        self.background = backRetainImage;
        self.font = [UIFont systemFontOfSize:aSize];
    }
    
    return self;
}

+ (id)textFiedlWithOrigin:(CGPoint)anOrigin
            textAlignment:(NSTextAlignment)theTextAlignment
                 textSize:(float)aSize
          backRetainImage:(UIImage *)backRetainImage {
    
    return [[self alloc] initWithOrigin:anOrigin
                          textAlignment:theTextAlignment
                               textSize:aSize
                              backImage:backRetainImage];
}


@end
