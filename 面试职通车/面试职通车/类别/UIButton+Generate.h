//
//  UIButton+Generate.h
//  面试职通车
//
//  Created by 萧川 on 14-4-17.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Generate)

- (UIButton *)initWithOrigin:(CGPoint)anOrigin image:(UIImage *)anImage target:(id)aTarget action:(SEL)sel;
+ (UIButton *)buttonWithOrigin:(CGPoint)anOrigin image:(UIImage *)anImage target:(id)aTarget action:(SEL)sel;

- (UIButton *)initWithOrigin:(CGPoint)anOrigin retinaImage:(UIImage *)aRetinaImage target:(id)aTarget action:(SEL)sel;
+ (UIButton *)buttonWithOrigin:(CGPoint)anOrigin retinaImage:(UIImage *)aRetinaImage target:(id)aTarget action:(SEL)sel;
@end
