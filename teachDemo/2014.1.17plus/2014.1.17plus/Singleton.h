//
//  Singleton.h
//  2014.1.17plus
//
//  Created by 张鹏 on 14-1-17.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>

// 1.简单的实现：可以实例化多次，可以被持有、可以被释放、可以被复制、不保证线程安全
// 2.完整的实现

@interface Singleton : NSObject <NSCopying>

+ (Singleton *)sharedSingleton;
+ (id)allocWithZone:(struct _NSZone *)zone;
- (id)copyWithZone:(NSZone *)zone;
- (id)retain;
- (NSUInteger)retainCount;
- (oneway void)release;
- (id)autorelease;

@end

















