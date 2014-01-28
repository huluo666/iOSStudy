//
//  main.m
//  「OC」通知中心
//
//  Created by cuan on 14-1-27.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Audience.h"
#import "Broadcast.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
    
        Audience *audience1 = [[[Audience alloc] init] autorelease];
        [audience1 listening];
        
        Audience *audience2 = [[[Audience alloc] init] autorelease];
        [audience2 listening];
        
        Broadcast *broadcast = [[[Broadcast alloc] init] autorelease];
        [broadcast broadcastLooper];
        
        [[NSRunLoop currentRunLoop] run];
        
        
    }
    return 0;
}

