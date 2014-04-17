//
//  UILabel+Generate.h
//  面试职通车
//
//  Created by 萧川 on 14-4-17.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Generate)

- (id)initWithFrame:(CGRect)aFrame
      textAlignment:(NSTextAlignment)theTextAlignment
           textSize:(float)aSize
               text:(NSString *)aText
          textColor:(UIColor *)aColor;

+ (id)labelWithFrame:(CGRect)aFrame
      textAlignment:(NSTextAlignment)theTextAlignment
           textSize:(float)aSize
               text:(NSString *)aText
          textColor:(UIColor *)aColor;

@end
