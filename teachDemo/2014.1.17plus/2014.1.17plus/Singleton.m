//
//  Singleton.m
//  2014.1.17plus
//
//  Created by 张鹏 on 14-1-17.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "Singleton.h"

static Singleton * singleton = nil;

@implementation Singleton

+ (Singleton *)sharedSingleton {
    
    @synchronized(self) {
        if (!singleton) {
            singleton = [[self alloc] init];
        }
    }
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

- (id)retain {
    
    return self;
}

- (NSUInteger)retainCount {
    
    return NSUIntegerMax;
}

- (id)autorelease {
    
    return self;
}

- (oneway void)release {
    
    // do nothing...
}

@end























