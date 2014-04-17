//
//  UILabel+Generate.m
//  面试职通车
//
//  Created by 萧川 on 14-4-17.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "UILabel+Generate.h"

@implementation UILabel (Generate)

- (id)initWithFrame:(CGRect)aFrame
      textAlignment:(NSTextAlignment)theTextAlignment
           textSize:(float)aSize
               text:(NSString *)aText
          textColor:(UIColor *)aColor {
    
    if (self = [super initWithFrame:aFrame]) {
        self.textAlignment = theTextAlignment;
        self.font = [UIFont systemFontOfSize:aSize];
        self.text = aText;
        self.backgroundColor = aColor;
        self.lineBreakMode = NSLineBreakByWordWrapping;
        self.numberOfLines = 0;
    }
    return self;
}

+ (id)labelWithFrame:(CGRect)aFrame
       textAlignment:(NSTextAlignment)theTextAlignment
            textSize:(float)aSize
                text:(NSString *)aText
           textColor:(UIColor *)aColor {
    
    return [[self alloc] initWithFrame:aFrame
                         textAlignment:theTextAlignment
                              textSize:aSize
                                  text:aText
                             textColor:aColor];
}

@end
