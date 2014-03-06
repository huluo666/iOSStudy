//
//  CustomView.h
//  2014.3.6
//
//  Created by 张鹏 on 14-3-6.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomView : UIView

- (id)initWithFrame:(CGRect)frame infoDict:(NSDictionary *)infoDict;

// 显示
- (void)showCustomView;
// 隐藏
- (void)dismissCustomView;

@end

















