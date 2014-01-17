//
//  Person+Compare.m
//  2014.1.17plus
//
//  Created by 张鹏 on 14-1-17.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "Person+Compare.h"

@implementation Person (Compare)

// 动态合成：需要手动编写setter及getter
@dynamic identity;

- (void)setIdentity:(NSString *)identity {
    
    if (_identity != identity) {
        // ...
        [_identity release];
        _identity = [identity copy];
    }
}

- (NSString *)identity {
    
    return _identity;
}



- (Person *)elderPerson:(Person *)person {
    
    return _age > person.age ? self : person;
}

- (void)print {
    
    NSLog(@"xxxxxxxxxxxxxx");
}

@end








