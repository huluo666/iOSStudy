//
//  UIButton+Generate.m
//  面试职通车
//
//  Created by 萧川 on 14-4-17.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "UIButton+Generate.h"

@implementation UIButton (Generate)

- (UIButton *)initWithOrigin:(CGPoint)anOrigin
                       image:(UIImage *)anImage
                      target:(id)aTarget
                      action:(SEL)sel {
    
    CGRect rect = CGRectMake(anOrigin.x,
                             anOrigin.y,
                             anImage.size.width,
                             anImage.size.height);
    if (self = [super initWithFrame:rect]) {
        [self setBackgroundImage:anImage forState:UIControlStateNormal];
        [self addTarget:aTarget
                 action:sel
       forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

+ (UIButton *)buttonWithOrigin:(CGPoint)anOrigin
                       image:(UIImage *)anImage
                      target:(id)aTarget
                      action:(SEL)sel {
    
    return [[self alloc] initWithOrigin:anOrigin
                                  image:anImage
                                 target:aTarget
                                 action:sel];;
}

- (UIButton *)initWithOrigin:(CGPoint)anOrigin
                 retinaImage:(UIImage *)aRetinaImage
                      target:(id)aTarget
                      action:(SEL)sel {
    
    CGRect rect = CGRectMake(anOrigin.x,
                             anOrigin.y,
                             aRetinaImage.size.width / 2,
                             aRetinaImage.size.height / 2);
    if (self = [super initWithFrame:rect]) {
        [self setBackgroundImage:aRetinaImage forState:UIControlStateNormal];
        [self addTarget:aTarget
                 action:sel
       forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

+ (UIButton *)buttonWithOrigin:(CGPoint)anOrigin
                 retinaImage:(UIImage *)aRetinaImage
                      target:(id)aTarget
                      action:(SEL)sel {
    
    return [[self alloc] initWithOrigin:anOrigin
                            retinaImage:aRetinaImage
                                 target:aTarget
                                 action:sel];
}

@end
