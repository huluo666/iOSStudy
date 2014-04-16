//
//  DDAuthorityManager.h
//  面试职通车
//
//  Created by 萧川 on 14-4-16.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDAuthorityManager : NSObject <NSCopying>

+ (DDAuthorityManager *)defaultAuthorityManager;
+ (id)allocWithZone:(struct _NSZone *)zone;
- (id)copyWithZone:(NSZone *)zone;
//- (id)retain;
//- (NSUInteger)retainCount;
//- (oneway void)release;
//- (id)autorelease;

@property (nonatomic, assign, getter = isLogined) BOOL logined;

@end
