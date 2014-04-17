//
//  UITextField+Generate.h
//  面试职通车
//
//  Created by 萧川 on 14-4-17.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Generate)

- (id)initWithOrigin:(CGPoint)anOrigin
       textAlignment:(NSTextAlignment)theTextAlignment
            textSize:(float)aSize
           backImage:(UIImage *)anImage;

+ (id)textFiedlWithOrigin:(CGPoint)anOrigin
       textAlignment:(NSTextAlignment)theTextAlignment
            textSize:(float)aSize
           backImage:(UIImage *)anImage;

- (id)initWithOrigin:(CGPoint)anOrigin
       textAlignment:(NSTextAlignment)theTextAlignment
            textSize:(float)aSize
           backRetinaImage:(UIImage *)backRetinaImage;

+ (id)textFiedlWithOrigin:(CGPoint)anOrigin
            textAlignment:(NSTextAlignment)theTextAlignment
                 textSize:(float)aSize
                backRetinaImage:(UIImage *)backRetinaImage;
@end
