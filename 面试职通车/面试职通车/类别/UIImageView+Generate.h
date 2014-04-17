//
//  UIImageView+Generate.h
//  面试职通车
//
//  Created by 萧川 on 14-4-18.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Generate)

- (UIImageView *)initWithOrigin:(CGPoint)anOrigin image:(UIImage *)aImage highlightedImage:(UIImage *)highlightedImage;
+ (UIImageView *)imageViewWithOrigin:(CGPoint)anOrigin image:(UIImage *)aImage highlightedImage:(UIImage *)highlightedImage;

- (UIImageView *)initWithOrigin:(CGPoint)anOrigin retinaImage:(UIImage *)aRetainImage highlightedRetinaImage:(UIImage *)highlightedRetinaImage;
+ (UIImageView *)imageViewWithOrigin:(CGPoint)anOrigin retinaImage:(UIImage *)aRetinaImage highlightedRetinaImage:(UIImage *)highlightedRetinaImage;

@end
