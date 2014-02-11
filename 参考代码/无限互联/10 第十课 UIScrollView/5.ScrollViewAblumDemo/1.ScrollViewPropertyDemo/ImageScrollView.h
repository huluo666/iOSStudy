//
//  ImageScrollView.h
//  1.ScrollViewPropertyDemo
//
//  Created by 周泉 on 13-2-28.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G开发培训中心. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageScrollView : UIScrollView <UIScrollViewDelegate>
{
@private
    UIImageView *_imageView;
}

@property (nonatomic, retain) UIImageView *imageView;

@end
