//
//  main.m
//  「OC」KVO(KeyValueObserving)
//
//  Created by cuan on 14-1-27.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        Person *person = [[[Person alloc] init] autorelease];
        [person registerAsObsver];
        
        [[NSRunLoop currentRunLoop] run];
        
    }
    return 0;
}

