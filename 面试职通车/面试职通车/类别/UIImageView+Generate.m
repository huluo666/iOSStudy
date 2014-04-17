//
//  UIImageView+Generate.m
//  面试职通车
//
//  Created by 萧川 on 14-4-18.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "UIImageView+Generate.h"

@implementation UIImageView (Generate)

- (UIImageView *)initWithOrigin:(CGPoint)anOrigin
                          image:(UIImage *)aImage
               highlightedImage:(UIImage *)highlightedImage {
    
    CGRect frame = CGRectMake(anOrigin.x,
                              anOrigin.y,
                              aImage.size.width,
                              aImage.size.height);
    if (self = [super initWithFrame:frame]) {
        [self setImage:aImage];
        [self setHighlightedImage:highlightedImage];
    }
    return self;
}

+ (UIImageView *)imageViewWithOrigin:(CGPoint)anOrigin
                               image:(UIImage *)aImage
                    highlightedImage:(UIImage *)highlightedImage {
    
    return [[self alloc] initWithOrigin:anOrigin
                                  image:aImage
                       highlightedImage:highlightedImage];
}

- (UIImageView *)initWithOrigin:(CGPoint)anOrigin
                    retinaImage:(UIImage *)aRetinaImage
         highlightedRetinaImage:(UIImage *)highlightedRetinaImage {
    
    CGRect frame = CGRectMake(anOrigin.x,
                              anOrigin.y,
                              aRetinaImage.size.width / 2,
                              aRetinaImage.size.height / 2);
    if (self = [super initWithFrame:frame]) {
        [self setImage:aRetinaImage];
        [self setHighlightedImage:highlightedRetinaImage];
    }
    return self;
}

+ (UIImageView *)imageViewWithOrigin:(CGPoint)anOrigin
                         retinaImage:(UIImage *)aRetinaImage
              highlightedRetinaImage:(UIImage *)highlightedRetinaImage; {
    
    return [[self alloc] initWithOrigin:anOrigin
                            retinaImage:aRetinaImage
                 highlightedRetinaImage:highlightedRetinaImage];

}

@end
