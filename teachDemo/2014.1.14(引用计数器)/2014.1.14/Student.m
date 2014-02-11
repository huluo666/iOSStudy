//
//  Student.m
//  2014.1.14
//
//  Created by 张鹏 on 14-1-14.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "Student.h"

@implementation Student

// 重写dealloc：为了在当前对象释放时做自定义操作
- (void)dealloc {
    
    NSLog(@"student dealloced.");
    
    // [super dealloc] 之前进行自定义操作
    [super dealloc];
}

- (void)print {
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
}
















@end
