//
//  UIImageView+WebCach.m
//  LoadImage
//
//  Created by wei.chen on 13-1-10.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "UIImageView+WebCach.h"

@implementation UIImageView (WebCach)

- (void)setImageWithURL:(NSURL *)url {
    dispatch_queue_t queue = dispatch_queue_create("loadImage", NULL);
    dispatch_async(queue, ^{
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.image = image;
        });
//        self.image = image;
    });
}

@end
