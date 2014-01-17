//
//  NSString+NumberCompare.h
//  2014.1.17plus
//
//  Created by 张鹏 on 14-1-17.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>

// 接口开始关键字   类名           类别名
@interface        NSString    (NumberCompare)

- (NSComparisonResult)numericCompare:(NSString *)string;

@end






