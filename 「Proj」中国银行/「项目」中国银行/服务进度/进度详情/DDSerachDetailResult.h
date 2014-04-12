//
//  DDSerachDetailResult.h
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-21.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDSerachDetailResult : UIView

@property (copy, nonatomic) void(^goBack)(void);
@property (assign, nonatomic) NSInteger serviceStatus;

@end
