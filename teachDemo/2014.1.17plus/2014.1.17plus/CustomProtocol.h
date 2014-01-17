//
//  CustomProtocol.h
//  2014.1.17plus
//
//  Created by 张鹏 on 14-1-17.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>

// 协议声明开始     协议名              继承的（遵守）协议
@protocol        CustomProtocol      <NSObject>

// 必须的（默认是@required）
- (void)print;

@optional
@property (copy, nonatomic) NSString *code;

@required
- (void)processBirthday;

@end
















