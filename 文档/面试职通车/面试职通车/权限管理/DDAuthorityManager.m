//
//  DDAuthorityManager.m
//  面试职通车
//
//  Created by 萧川 on 14-4-16.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDAuthorityManager.h"

static DDAuthorityManager *singleton = nil;

@implementation DDAuthorityManager

+ (DDAuthorityManager *)defaultAuthorityManager {
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    
    @synchronized(self) {
        if (!singleton) {
            singleton = [super allocWithZone:zone];
            return singleton;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone {

    return self;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _logined = NO;
    }
    return self;
}

@end
