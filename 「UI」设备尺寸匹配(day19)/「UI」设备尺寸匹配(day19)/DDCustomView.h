//
//  DDCustomView.h
//  「UI」设备尺寸匹配(day19)
//
//  Created by 萧川 on 14-3-6.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const DDInfoDictImage = @"image";
static NSString * const DDInfoDictName = @"name";
static NSString * const DDInfoDictage = @"year";
static NSString * const DDInfoDictInfo = @"content";

@interface DDCustomView : UIView

- (instancetype)initWithFrame:(CGRect)frame infoDict:(NSDictionary *)infoDict;


- (void)showCustomView;
- (void)dismissCustomView;

@end
