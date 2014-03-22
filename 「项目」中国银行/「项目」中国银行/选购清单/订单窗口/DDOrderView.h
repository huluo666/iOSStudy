//
//  DDOrderView.h
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-15.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface DDOrderView : UIView

@property (copy, nonatomic) void(^swipRight)(void);
@property (retain, nonatomic) NSDictionary *dataSource;

@end
