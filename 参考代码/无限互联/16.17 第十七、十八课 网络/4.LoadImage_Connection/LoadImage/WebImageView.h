//
//  WebImageView.h
//  LoadImage
//
//  Created by wei.chen on 13-1-10.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebImageView : UIImageView

@property(nonatomic,retain)NSMutableData *data;

- (void)setURL:(NSURL *)url;

@end
